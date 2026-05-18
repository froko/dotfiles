-- lsp/cspell_ls.lua
--
-- CSpell language-server configuration.
--
-- Features:
--   1. Loads cspell.json / .cspell.json from the project root.
--   2. Respects `ignorePaths` -- detaches from ignored buffers.
--   3. Watches writable dictionary files and auto-sorts them on change,
--      keeping dictionaries deduplicated and alphabetically ordered.
--
-- Dictionary sorting is debounced (100ms) via libuv fs_event + timer
-- to avoid re-sorting while CSpell is still writing.

-- ── Config file loading ──────────────────────────────────────────────

--- Look for cspell.json or .cspell.json in `root_dir`, parse it.
---@param root_dir string  absolute path to the project root
---@return table?, string?  (config_table, config_dir) or (nil, nil)
local function load_cspell_config(root_dir)
  for _, name in ipairs({ 'cspell.json', '.cspell.json' }) do
    local path = root_dir .. '/' .. name
    local f = io.open(path, 'r')
    if f then
      local ok, cfg = pcall(vim.json.decode, f:read('*a'))
      f:close()
      if ok and cfg then
        return cfg, root_dir
      end
    end
  end
  return nil, nil
end

--- Extract the `ignorePaths` array from a cspell config.
---@param root_dir string
---@return string[]  glob patterns to ignore (empty if none)
local function load_ignore_paths(root_dir)
  local cfg = load_cspell_config(root_dir)
  if cfg and cfg.ignorePaths then
    return cfg.ignorePaths
  end
  return {}
end

-- ── Glob-to-Lua pattern conversion ──────────────────────────────────

--- Convert a simple glob pattern to a Lua pattern.
--- Covers the most common cases: **, *, ?, and special-char escaping.
---@param glob string  glob pattern (e.g. "**/node_modules/**")
---@return string      equivalent Lua pattern
local function glob_to_lua_pattern(glob)
  local pat = glob
    :gsub('([%.%+%-%^%$%(%)%%])', '%%%1') -- escape regex-special chars
    :gsub('%*%*/', '.*') -- **/ -> any directory prefix
    :gsub('%*%*', '.*') -- **  -> any characters
    :gsub('%*', '[^/]*') -- *   -> single path segment
    :gsub('%?', '.') -- ?   -> single character
  return pat
end

--- Check whether a buffer path matches any `ignorePaths` globs.
---@param bufname string   absolute path of the buffer
---@param root_dir string  project root directory
---@return boolean         true if the buffer should be ignored
local function is_ignored(bufname, root_dir)
  local patterns = load_ignore_paths(root_dir)

  -- Make path relative to root so patterns like "dist/**" work
  local rel = bufname
  if root_dir and bufname:sub(1, #root_dir) == root_dir then
    rel = bufname:sub(#root_dir + 2) -- strip root + separator
  end

  for _, glob in ipairs(patterns) do
    local lua_pat = glob_to_lua_pattern(glob)
    if rel:match(lua_pat) or bufname:match(lua_pat) then
      return true
    end
  end
  return false
end

-- ── Dictionary file management ───────────────────────────────────────

--- Collect absolute paths of dictionary files that have `addWords = true`.
--- These are the files CSpell writes new words to.
---@param root_dir string
---@return string[]  list of absolute dictionary file paths
local function get_writable_dict_paths(root_dir)
  local cfg, cfg_dir = load_cspell_config(root_dir)
  if not cfg or not cfg.dictionaryDefinitions then
    return {}
  end

  local paths = {}
  for _, def in ipairs(cfg.dictionaryDefinitions) do
    if def.addWords and def.path then
      local dict_path = def.path
      -- Resolve relative paths against the config directory
      if not vim.startswith(dict_path, '/') then
        dict_path = cfg_dir .. '/' .. dict_path
      end
      dict_path = vim.fn.fnamemodify(dict_path, ':p')
      table.insert(paths, dict_path)
    end
  end
  return paths
end

--- Read a dictionary file, sort lines case-insensitively, deduplicate,
--- and write back only when content actually changed (prevents loops).
---@param filepath string  absolute path to the dictionary file
local function sort_dictionary_file(filepath)
  local f = io.open(filepath, 'r')
  if not f then
    return
  end
  local original = f:read('*a')
  f:close()

  -- Split into lines, trim whitespace, drop blanks
  local lines = {}
  for line in original:gmatch('[^\r\n]+') do
    local trimmed = line:match('^%s*(.-)%s*$')
    if trimmed ~= '' then
      table.insert(lines, trimmed)
    end
  end

  -- Sort case-insensitively
  table.sort(lines, function(a, b)
    return a:lower() < b:lower()
  end)

  -- Deduplicate consecutive entries (safe after sort)
  local deduped = {}
  for i, line in ipairs(lines) do
    if i == 1 or line:lower() ~= lines[i - 1]:lower() then
      table.insert(deduped, line)
    end
  end

  local sorted = table.concat(deduped, '\n') .. '\n'

  -- Only write if content changed to prevent infinite watcher loops
  if sorted ~= original then
    local out = io.open(filepath, 'w')
    if out then
      out:write(sorted)
      out:close()
    end
  end
end

-- ── File watchers ────────────────────────────────────────────────────
-- We watch writable dictionary files for changes and auto-sort them.
-- A module-level table tracks active watchers to prevent duplicates
-- when on_attach fires for multiple buffers in the same project.

---@type table<string, { handle: uv.uv_fs_event_t, timer: uv.uv_timer_t }>
local _watchers = {}

--- Start fs_event watchers for all writable dictionaries in a project.
--- Idempotent: skips files that already have an active watcher.
---@param root_dir string  project root directory
local function setup_dict_watchers(root_dir)
  local paths = get_writable_dict_paths(root_dir)
  for _, filepath in ipairs(paths) do
    if not _watchers[filepath] and vim.uv.fs_stat(filepath) then
      local handle = vim.uv.new_fs_event()
      local timer = vim.uv.new_timer()

      -- Debounce: reset timer on each fs event, sort after 100ms of quiet
      handle:start(filepath, {}, function(err)
        if err then
          return
        end
        timer:stop()
        timer:start(100, 0, function()
          vim.schedule(function()
            sort_dictionary_file(filepath)
          end)
        end)
      end)

      _watchers[filepath] = { handle = handle, timer = timer }
    end
  end
end

--- Stop and clean up all active dictionary file watchers.
--- Called on LSP server exit to free libuv handles.
local function stop_all_watchers()
  for filepath, w in pairs(_watchers) do
    if w.timer then
      w.timer:stop()
      w.timer:close()
    end
    if w.handle then
      w.handle:stop()
      w.handle:close()
    end
    _watchers[filepath] = nil
  end
end

-- ── LSP server config ────────────────────────────────────────────────

return {
  cmd = { 'cspell-lsp', '--stdio' },
  root_markers = { '.git', 'cspell.json', '.cspell.json' },

  on_attach = function(client, bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local root_dir = client.root_dir or ''

    -- Detach from buffers matching ignorePaths
    if is_ignored(bufname, root_dir) then
      vim.lsp.buf_detach_client(bufnr, client.id)
      return
    end

    -- Start dictionary file watchers (idempotent per filepath)
    setup_dict_watchers(root_dir)
  end,

  on_exit = function()
    stop_all_watchers()
  end,
}
