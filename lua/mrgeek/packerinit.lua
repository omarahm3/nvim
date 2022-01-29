local api = vim.api
local packer = nil
local data_dir = string.format('%s/site/', vim.fn.stdpath('data'))

local load_packer = function()
  print('>Packer.load_packer:: Loading packer instance')

  if not packer then
    print('>Packer.load_packer:: Packer is not loaded, loading..')

    vim.cmd [[packadd packer.nvim]]

    print('>Packer.load_packer:: Packer was added, requiring packer..')

    packer = require('packer')
  end

  print('>Packer.load_packer:: Running packer init')

  packer.init {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'single' }
      end,
      prompt_border = 'single',
    },
    git = {
      clone_timeout = 6000, -- seconds
    },
    auto_clean = true,
    max_jobs = 20,
    compile_on_sync = true,
  }
end

print('>Packer:: Making sure that packer is installed')

print('>Packer:: Data path: [ ' .. vim.fn.stdpath('data') .. ' ]')

local packer_dir = string.format('%ssite/pack/packer/opt/packer.nvim', data_dir)

print('>Packer:: path: [ ' .. packer_dir .. ' ]')

local state = vim.loop.fs_stat(packer_dir)

print('>Packer:: file state: [ ' .. vim.inspect(state) .. ' ]')

if not state then
  print '>Packer:: Packer does not exist, cloning...'

  -- remove the dir before cloning
  vim.fn.delete(packer_dir, 'rf')

  print('>Packer:: Removing current packer directory')

  vim.fn.system {
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    '--depth',
    '20',
    packer_dir,
  }

  print('>Packer:: Packer was cloned')

  load_packer()
  packer.install()
else
  print '>Packer:: Packer exists, requiring it only'

  loaded, packer = pcall(require, 'packer')

  if not loaded then
    print '>Packer:: WTF could not require packer'
    vim.notify('Packer was not loaded something really bad happened')
  end
end

print '>Packer:: Check finished, returning packer instance'

return packer
