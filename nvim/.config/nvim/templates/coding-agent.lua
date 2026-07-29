-- templates/coding-agent.lua
--
-- Helpers for working alongside a coding agent in an adjacent tmux pane.
-- Auto-reloads files changed externally; keymaps under <leader>c.

-- ── Autoread ────────────────────────────────────────────────────────

vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = 'checktime',
})

-- ── Helpers ─────────────────────────────────────────────────────────

local agent_commands = { 'claude', 'opencode' }

local function find_agent_panes()
  local output = vim.fn.system({ 'tmux', 'list-panes', '-F', '#{pane_id} #{pane_current_command}' })
  local current = vim.fn.system({ 'tmux', 'display-message', '-p', '#{pane_id}' }):gsub('%s+$', '')
  local candidates = {}
  for line in output:gmatch('[^\n]+') do
    local id, cmd = line:match('^(%S+)%s+(%S+)')
    if id and id ~= current then
      for _, agent in ipairs(agent_commands) do
        if cmd == agent then
          table.insert(candidates, { id = id, cmd = cmd })
        end
      end
    end
  end
  return candidates
end

local function resolve_agent_pane(callback)
  local candidates = find_agent_panes()
  if #candidates == 0 then
    vim.notify('No agent pane found (looked for: ' .. table.concat(agent_commands, ', ') .. ')', vim.log.levels.WARN)
    return
  end
  if #candidates == 1 then
    callback(candidates[1].id)
    return
  end
  vim.ui.select(candidates, {
    prompt = 'Multiple agent panes found:',
    format_item = function(c)
      return c.cmd .. ' (' .. c.id .. ')'
    end,
  }, function(choice)
    if choice then
      callback(choice.id)
    end
  end)
end

local function tmux_send(target, text, literal)
  local cmd = { 'tmux', 'send-keys', '-t', target }
  if literal then
    table.insert(cmd, '-l')
  end
  table.insert(cmd, text)
  vim.fn.system(cmd)
end

local function send_file_path(target)
  local relative_path = vim.fn.expand('%:.')
  if relative_path == '' then
    return
  end
  vim.fn.system({ 'tmux', 'send-keys', '-t', target, 'C-u' })
  tmux_send(target, '@' .. relative_path .. ' ', true)
end

local function get_visual_selection()
  local saved_reg = vim.fn.getreg('z')
  local saved_regtype = vim.fn.getregtype('z')
  vim.cmd('normal! "zy')
  local selection = vim.fn.getreg('z')
  vim.fn.setreg('z', saved_reg, saved_regtype)
  return selection
end

local function send_selection(target)
  local selection = get_visual_selection()
  local relative_path = vim.fn.expand('%:.')
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local ft = vim.bo.filetype

  local header = string.format('Context from `%s` (lines %d-%d):\n', relative_path, start_line, end_line)
  local code_block = string.format('```%s\n%s\n```\n', ft, selection)

  tmux_send(target, header .. code_block, true)
end

local function send_diagnostics(target)
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics == 0 then
    vim.notify('No diagnostics in current buffer')
    return
  end

  local relative_path = vim.fn.expand('%:.')
  local severity_label = { 'ERROR', 'WARN', 'INFO', 'HINT' }
  local lines = {}
  table.sort(diagnostics, function(a, b)
    return a.severity < b.severity
  end)
  for _, d in ipairs(diagnostics) do
    if d.severity > vim.diagnostic.severity.WARN then
      break
    end
    local label = severity_label[d.severity] or 'UNKNOWN'
    table.insert(lines, string.format('  Line %d: [%s] %s', d.lnum + 1, label, d.message))
  end

  local text =
    string.format('Diagnostics for `%s` (%d issues):\n%s\n', relative_path, #lines, table.concat(lines, '\n'))
  tmux_send(target, text, true)
end

local function send_prompt_with_file(target)
  local relative_path = vim.fn.expand('%:.')
  if relative_path == '' then
    return
  end
  vim.ui.input({ prompt = 'Prompt: ' }, function(input)
    if not input or input == '' then
      return
    end
    vim.fn.system({ 'tmux', 'send-keys', '-t', target, 'C-u' })
    tmux_send(target, input .. ' @' .. relative_path .. ' ', true)
  end)
end

-- ── Keymaps ─────────────────────────────────────────────────────────

require('which-key').add({ '<leader>c', group = 'Coding Agent' })

local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

nnoremap('<leader>cy', function()
  local path = '@' .. vim.fn.expand('%:.')
  vim.fn.setreg('+', path)
  vim.notify('Copied to clipboard: ' .. path)
end, { desc = 'Copy @file path' })

nnoremap('<leader>cf', function()
  resolve_agent_pane(function(pane)
    send_file_path(pane)
  end)
end, { desc = 'Send file path to agent' })

vnoremap('<leader>cs', function()
  resolve_agent_pane(function(pane)
    send_selection(pane)
  end)
end, { desc = 'Send selection to agent' })

nnoremap('<leader>cd', function()
  resolve_agent_pane(function(pane)
    send_diagnostics(pane)
  end)
end, { desc = 'Send diagnostics to agent' })

nnoremap('<leader>cp', function()
  resolve_agent_pane(function(pane)
    send_prompt_with_file(pane)
  end)
end, { desc = 'Prompt agent with file' })
