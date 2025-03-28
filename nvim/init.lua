-- ~/.config/nvim/init.lua

-- Install packer automatically if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Basic Settings
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
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.g.mapleader = ' ' -- Set leader key to space

-- Minimal Plugin Setup
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  
  -- Theme
  use 'folke/catppuccin.nvim'
  
  -- File Explorer
  use 'nvim-tree/nvim-tree.lua'
  
  -- Icons
  use 'nvim-tree/nvim-web-devicons'
  
  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    }
  }

  -- LSP Support
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',    -- LSP completion
      'hrsh7th/cmp-buffer',      -- Buffer completion
      'hrsh7th/cmp-path',        -- Path completion
      'L3MON4D3/LuaSnip',        -- Snippet engine
      'saadparwaiz1/cmp_luasnip' -- Snippet completion
    }
  }
  
  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Theme Setup
require("tokyonight").setup({
  style = "night",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  dim_inactive = false,
  lualine_bold = false,
})

-- Apply the colorscheme
vim.cmd[[colorscheme tokyonight-night]]

-- Disable netrw (vim's built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Nvim-Tree Setup (File Explorer)
require('nvim-tree').setup({
  sort_by = "case_sensitive",
  view = {
    width = 25,
    signcolumn = "no",
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        folder = {
          arrow_closed = "▸",
          arrow_open = "▾",
        },
      }
    },
    special_files = {},
    symlink_destination = false,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})

-- File Explorer Keymaps
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>fe', ':NvimTreeFocus<CR>', {noremap = true, silent = true})

-- Window navigation keymaps
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true, silent = true}) -- Move left
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true, silent = true}) -- Move right
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true, silent = true}) -- Move down
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true, silent = true}) -- Move up

-- Quick escape from NvimTree
vim.keymap.set('n', '<leader>w', '<C-w>l', {noremap = true, silent = true}) -- Quick jump to editor

-- Telescope Setup (Fuzzy Finder)
require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".git",
      "target",
      "vendor",
    },
    layout_config = {
      horizontal = {
        width = 0.9,
        preview_width = 0.6,
      },
    },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<Esc>"] = "close",
      },
    },
    prompt_prefix = "🔍 ",  -- Add a search icon to the prompt
    selection_caret = "❯ ",  -- Add a nice arrow for selection
  },
})

-- Telescope Keymaps
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {desc = 'Find files'})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {desc = 'Live grep'})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {desc = 'Find buffers'})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {desc = 'Help tags'})
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, {desc = 'Find files'})

-- Print a message to remind about running :PackerSync
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    print("Remember to run :PackerSync to install/update plugins!")
  end,
})

-- Mason Setup (LSP installer)
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',     -- Python
    'zls',         -- Zig
    'gopls',       -- Go
  },
  automatic_installation = true,
})

-- Autocompletion Setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- LSP Setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP Keybindings
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Configure LSP servers
local lspconfig = require('lspconfig')

-- Python LSP
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Zig LSP
lspconfig.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Go LSP
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}) 