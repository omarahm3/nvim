require 'mrgeek.core.globals'
require 'mrgeek.core.config'
require 'mrgeek.core.keymappings'

-- Remap space as a leader key
local function remap_leader()
  vim.api.nvim_set_keymap('', MrGeek.default_leader, '<Nop>', {
    noremap = true,
    silent = true,
  })
  vim.g.mapleader = (MrGeek.default_leader == '<Space>' and '') or MrGeek.default_leader
  vim.g.maplocalleader =(MrGeek.default_leader == '<Space>' and '') or MrGeek.default_leader
end

remap_leader()

local cmd = vim.cmd

-- Commands
cmd [[command! WhatHighlight :call util#syntax_stack()]]
cmd [[command! PackerInstall packadd packer.nvim | lua require('mrgeek.plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('mrgeek.plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('mrgeek.plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('mrgeek.plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('mrgeek.plugins').compile()]]
