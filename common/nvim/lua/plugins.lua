local plugins = {
    -- {
    --     'rktjmp/lush.nvim'
    -- },
    -- {
    --     dir = '/home/zebu/.config/nvim-scheme',
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         vim.cmd("colorscheme gio")
    --     end,
    -- },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd("colorscheme tokyonight-moon")
    --     end,
    -- },
    {
        'uZer/pywal16.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme pywal16")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('config.lualine')
        end,
    },
    {
        'numToStr/Comment.nvim', config = function()
            require('Comment').setup({
                ignore = '^$',
                toggler = {
                    line = '<leader>cl',
                    block = '<leader>cb',
                },
                opleader = {
                    line = '<leader>cl',
                    block = '<leader>cb',
                },
            })
        end,
        lazy = false,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require('which-key')
            wk.setup({replace = { ['<leader>'] = 'SPC'}})
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = { 'c', 'lua', 'rust', 'zig', 'java', 'fish', 'markdown', 'markdown_inline', 'dart', 'glsl' },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = require('keymaps.telescope'),
        init = function()
            require('config.telescope')
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = require('keymaps.telescope_file_browser')
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = { "nvim-lua/plenary.nvim"},
        keys = require('keymaps.harpoon'),
        opts = {
            tabline = false,
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
        event = 'InsertEnter',
        config = function()
            require('config.snippets')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'glepnir/lspsaga.nvim',
                branch = 'main',
            },
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        event = { 'BufReadPre', 'BufNewFile'},
        cmd = {
            'LspInfo',
            'LspStart',
            'LspRestart',
            'Mason',
            'LspLog',
        },
        config = function()
            require('config.lsp')
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = require('keymaps.git'),
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        'mrjones2014/smart-splits.nvim',
        lazy = false,
        keys = require('keymaps.smart_splits'),
    },
    {
        'elkowar/yuck.vim',
    },
    {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
        keys = {
            {
                '<leader>nf',
                '<Cmd>Nerdy<CR>'
            },
        }
    },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(plugins)
