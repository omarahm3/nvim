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
    'hcl',
  },
  highlight = {
    enable = true,
    disable = { '' },
    additional_vim_regex_highlighting = true, -- Needed for PHP files
    use_languagetree = true,
  },
  indent = {
    enable = true,
    disable = { 'yaml', 'php', 'go' },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

local M = {}
M.setup = function()
  ts_config.setup(default)
  -- Set ejs syntax highlighting
  vim.cmd([[
    au BufNewFile,BufRead *.ejs set filetype=html
  ]])
end

return M
