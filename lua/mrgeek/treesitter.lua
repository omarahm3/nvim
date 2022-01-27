local present, ts_config = pcall(require, 'nvim-treesitter.configs')

if not present then
  return
end

local default = {
  ensure_installed = {
    'json',
    'javascript',
    'php',
    'typescript',
    'fish',
    'bash',
    'tsx',
    'regex',
    'jsdoc',
    'html',
    'go',
    'dockerfile',
    'css',
    'comment',
    'python',
    'ruby',
    'rust',
    'lua',
    'vim',
  },
  highlight = {
    enable = true,
    disable = { '' },
    -- additional_vim_regex_highlighting = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
    disable = { 'yaml', 'php' },
  },
}

local M = {}
M.setup = function()
  ts_config.setup(default)
end

return M
