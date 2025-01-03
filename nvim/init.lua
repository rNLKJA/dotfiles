-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Basic settings (these can be set before plugins)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Plugin setup
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'Mofiqul/dracula.nvim' -- Dracula theme
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use 'junegunn/fzf.vim'
  
  if is_bootstrap then
    require('packer').sync()
  end
end)

-- Theme setup (wrapped in protected call)
local status_ok, _ = pcall(vim.cmd, "colorscheme dracula")
if not status_ok then
  vim.notify("dracula colorscheme not found!")
  return
end

-- Split window mappings
vim.keymap.set('n', '<C-\\>', ':vsplit<CR>', { silent = true })
vim.keymap.set('n', '<C-->', ':split<CR>', { silent = true })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })


-- Set leader key to space
vim.g.mapleader = ' '

-- Window resize mappings (using space as leader)
vim.keymap.set('n', '<leader>l', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<leader>h', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<leader>j', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<leader>k', ':resize +2<CR>', { silent = true })




-- FZF mappings
vim.keymap.set('n', '<C-o>', ':Files<CR>', { silent = true })
vim.keymap.set('n', '<C-f>', ':Rg<CR>', { silent = true })

-- Automatically run PackerSync if we just bootstrapped
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end