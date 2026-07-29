-- lsp/angularls.lua
--
-- Angular language server (@angular/language-server, binary: `ngserver`).
--
-- This repo uses Neovim's native `vim.lsp.config`/`vim.lsp.enable` API
-- (no nvim-lspconfig), so the full server definition — including `cmd`,
-- `filetypes`, and `root_markers` — must live here.
--
-- Coverage:
--   typescript / typescriptreact - component classes, inline templates
--   html / htmlangular           - external `.html` templates
--
-- `ngserver` needs to probe a project's `node_modules` to find the
-- matching @angular/language-service + typescript versions, so the
-- command is built dynamically from the resolved root directory.

local fs, fn, uv = vim.fs, vim.fn, vim.uv

--- Collect node_modules dirs to probe: the project's own, plus the one
--- shipped alongside the Mason-installed `ngserver` (fallback versions).
---@param root_dir string
---@return string[]
local function collect_node_modules(root_dir)
  local results = {}

  local project_node = fs.joinpath(root_dir, 'node_modules')
  if uv.fs_stat(project_node) then
    table.insert(results, project_node)
  end

  local ngserver_exe = fn.exepath('ngserver')
  if ngserver_exe and #ngserver_exe > 0 then
    local realpath = uv.fs_realpath(ngserver_exe) or ngserver_exe
    -- ngserver lives at <pkg>/bin/ngserver → climb to the dir holding node_modules
    local candidate = fs.normalize(fs.joinpath(fs.dirname(realpath), '../../..'))
    if uv.fs_stat(candidate) then
      table.insert(results, candidate)
    end
  end

  return results
end

--- Read the project's installed @angular/core version (helps the server
--- enable version-specific template features). Returns '' when unknown.
---@param root_dir string
---@return string
local function get_angular_core_version(root_dir)
  local package_json = fs.joinpath(root_dir, 'package.json')
  if not uv.fs_stat(package_json) then
    return ''
  end

  local ok, content = pcall(fn.readblob, package_json)
  if not ok or not content then
    return ''
  end

  local json = vim.json.decode(content) or {}
  local deps = json.dependencies or {}
  local dev_deps = json.devDependencies or {}
  local version = deps['@angular/core'] or dev_deps['@angular/core'] or ''
  return version:match('%d+%.%d+%.%d+') or ''
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local root_dir = (config and config.root_dir) or fn.getcwd()
    local node_paths = collect_node_modules(root_dir)

    local ts_probe = table.concat(node_paths, ',')
    local ng_probe = table.concat(
      vim
        .iter(node_paths)
        :map(function(p)
          return fs.joinpath(p, '@angular/language-server/node_modules')
        end)
        :totable(),
      ','
    )

    local cmd = {
      'ngserver',
      '--stdio',
      '--tsProbeLocations',
      ts_probe,
      '--ngProbeLocations',
      ng_probe,
      '--angularCoreVersion',
      get_angular_core_version(root_dir),
    }

    return vim.lsp.rpc.start(cmd, dispatchers)
  end,

  -- Cover both component classes and external HTML templates. `htmlangular`
  -- is Neovim's built-in filetype for Angular component templates (matched
  -- via the `html` LSP plus tailwind/eslint `includeLanguages` mapping).
  filetypes = { 'typescript', 'typescriptreact', 'html', 'htmlangular' },

  -- Only start inside an actual Angular workspace.
  root_markers = { 'angular.json', 'nx.json' },
}
