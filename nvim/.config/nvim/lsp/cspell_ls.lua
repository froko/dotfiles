-- Read ignorePaths from cspell.json and prevent the LSP from attaching
-- to buffers that match those patterns (cspell-lsp doesn't honour ignorePaths).
local function load_ignore_paths(root_dir)
  for _, name in ipairs({ 'cspell.json', '.cspell.json' }) do
    local path = root_dir .. '/' .. name
    local f = io.open(path, 'r')
    if f then
      local ok, cfg = pcall(vim.json.decode, f:read('*a'))
      f:close()
      if ok and cfg and cfg.ignorePaths then
        return cfg.ignorePaths
      end
    end
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

return {
  cmd = { 'cspell-lsp', '--stdio' },
  root_markers = { '.git', 'cspell.json', '.cspell.json' },
  on_attach = function(client, bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local root_dir = client.root_dir or ''
    if is_ignored(bufname, root_dir) then
      -- Detach immediately; this buffer should not be spell-checked.
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
  end,
}
