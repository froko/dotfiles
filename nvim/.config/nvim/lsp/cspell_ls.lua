-- Shared: load and parse cspell.json / .cspell.json from root_dir.
-- Returns (config_table, config_dir) or (nil, nil).
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

-- Extract ignorePaths from the cspell config.
local function load_ignore_paths(root_dir)
  local cfg = load_cspell_config(root_dir)
  if cfg and cfg.ignorePaths then
    return cfg.ignorePaths
  end
  return {}
end

-- Convert a simple glob pattern to a Lua pattern (covers common cases).
local function glob_to_lua_pattern(glob)
  local pat = glob
    :gsub('([%.%+%-%^%$%(%)%%])', '%%%1') -- escape special chars
    :gsub('%*%*/', '.*') -- **/ -> match any dir prefix
    :gsub('%*%*', '.*') -- ** alone
    :gsub('%*', '[^/]*') -- * -> single segment
    :gsub('%?', '.') -- ? -> single char
  return pat
end

local function is_ignored(bufname, root_dir)
  local patterns = load_ignore_paths(root_dir)
  -- Make path relative to root for matching
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

-- Return absolute paths of dictionary files that have addWords = true.
local function get_writable_dict_paths(root_dir)
  local cfg, cfg_dir = load_cspell_config(root_dir)
  if not cfg or not cfg.dictionaryDefinitions then
    return {}
  end
  local paths = {}
  for _, def in ipairs(cfg.dictionaryDefinitions) do
    if def.addWords and def.path then
      local dict_path = def.path
      if not vim.startswith(dict_path, '/') then
        dict_path = cfg_dir .. '/' .. dict_path
      end
      dict_path = vim.fn.fnamemodify(dict_path, ':p')
      table.insert(paths, dict_path)
    end
  end
  return paths
end

-- Read a dictionary file, sort case-insensitively, deduplicate,
-- and write back only if content changed.
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

  -- Deduplicate (consecutive after sort)
  local deduped = {}
  for i, line in ipairs(lines) do
    if i == 1 or line:lower() ~= lines[i - 1]:lower() then
      table.insert(deduped, line)
    end
  end

  local sorted = table.concat(deduped, '\n') .. '\n'

  -- Only write if something actually changed (prevents infinite loop)
  if sorted ~= original then
    local out = io.open(filepath, 'w')
    if out then
      out:write(sorted)
      out:close()
    end
  end
end

-- Module-level table: tracks active fs_event watchers by filepath.
-- Prevents duplicate watchers when on_attach fires for multiple buffers.
local _watchers = {}

local function setup_dict_watchers(root_dir)
  local paths = get_writable_dict_paths(root_dir)
  for _, filepath in ipairs(paths) do
    if not _watchers[filepath] and vim.uv.fs_stat(filepath) then
      local handle = vim.uv.new_fs_event()
      local timer = vim.uv.new_timer()

      handle:start(filepath, {}, function(err)
        if err then
          return
        end
        -- Debounce: reset timer on each event, fire after 100ms of quiet
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

return {
  cmd = { 'cspell-lsp', '--stdio' },
  root_markers = { '.git', 'cspell.json', '.cspell.json' },
  on_attach = function(client, bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local root_dir = client.root_dir or ''
    if is_ignored(bufname, root_dir) then
      vim.lsp.buf_detach_client(bufnr, client.id)
      return
    end
    -- Set up file watchers for writable dictionaries (idempotent)
    setup_dict_watchers(root_dir)
  end,
  on_exit = function()
    stop_all_watchers()
  end,
}
