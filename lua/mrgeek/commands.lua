-- Packer commands
vim.api.nvim_create_user_command("PackerInstall", "packadd packer.nvim | lua require('mrgeek.plugins').install()", {})
vim.api.nvim_create_user_command("PackerUpdate", "packadd packer.nvim | lua require('mrgeek.plugins').update()", {})
vim.api.nvim_create_user_command("PackerSync", "packadd packer.nvim | lua require('mrgeek.plugins').sync()", {})
vim.api.nvim_create_user_command("PackerClean", "packadd packer.nvim | lua require('mrgeek.plugins').clean()", {})
vim.api.nvim_create_user_command("PackerCompile", "packadd packer.nvim | lua require('mrgeek.plugins').compile()", {})
vim.api.nvim_create_user_command("PC", "PackerCompile", {})
vim.api.nvim_create_user_command("PU", "PackerSync", {})
vim.api.nvim_create_user_command("WhatHighlight", ":call util#syntax_stack()", {})
