local present, plugin = pcall(require, 'material')

if not present then
   return
end

local default = {
  lualine_style = 'stealth',
}

plugin.setup(default)
