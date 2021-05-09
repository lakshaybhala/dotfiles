local config = {}

local _errors
local _warnings
local _hints
local _info
local icons

local diagnostics = require('lsp-status/diagnostics')
local messages = require('lsp-status/messaging').messages
local aliases = {
  pyls_ms = 'MPLS',
}

local function make_statusline_component(diagnostics_key)
  return function(bufh)
    bufh = bufh or vim.api.nvim_get_current_buf()
    local icon = icons[diagnostics_key] .. config.indicator_separator
    return (icon or '') .. diagnostics(bufh)[diagnostics_key]
  end
end

local function init(_, _config)
  config = vim.tbl_extend('force', config, _config)

  icons = {
    errors = config.indicator_errors,
    warnings = config.indicator_warnings,
    hints = config.indicator_hint,
    info = config.indicator_info,
  }

  _errors = make_statusline_component('errors')
  _warnings = make_statusline_component('warnings')
  _hints = make_statusline_component('hints')
  _info = make_statusline_component('info')
end

local function statusline_lsp(bufnr)
  bufnr = bufnr or 0
  if #vim.lsp.buf_get_clients(bufnr) == 0 then
    return ''
  end

  local buf_diagnostics = diagnostics(bufnr)
  local buf_messages = messages()
  local status_parts = {}
  if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
    table.insert(status_parts, config.indicator_errors .. config.indicator_separator .. buf_diagnostics.errors)
  end

  if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
    table.insert(status_parts, config.indicator_warnings .. config.indicator_separator .. buf_diagnostics.warnings)
  end

  if buf_diagnostics.info and buf_diagnostics.info > 0 then
    table.insert(status_parts, config.indicator_info .. config.indicator_separator .. buf_diagnostics.info)
  end

  if buf_diagnostics.hints and buf_diagnostics.hints > 0 then
    table.insert(status_parts, config.indicator_hint .. config.indicator_separator .. buf_diagnostics.hints)
  end

  local msgs = {}

  local base_status = vim.trim(table.concat(status_parts, ' ') .. ' ' .. table.concat(msgs, ' '))
  local symbol = config.status_symbol .. ' '
  if config.current_function then
    local current_function = vim.b.lsp_current_function
    if current_function and current_function ~= '' then
      symbol = symbol .. '(' .. current_function .. ') '
    end
  end

  if base_status ~= '' then
    return symbol .. base_status .. ' '
  end

  return symbol .. config.indicator_ok .. ' '
end

local function get_component_functions()
  return {
    errors = _errors,
    warnings = _warnings,
    hints = _hints,
    info = _info,
  }
end

local M = {
  _init = init,
  status = statusline_lsp,
  _get_component_functions = get_component_functions
}

return M
