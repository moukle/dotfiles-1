local vim = vim
local cmd = vim.cmd

cmd [[ packadd packer.nvim ]]

cmd [[ autocmd BufWritePost init.lua PackerCompile ]]

local packer = require 'packer'
local util = require 'packer.util'

-- Use Wrapper {{{
local function file_exists(filename)
    local config_path = vim.fn.expand(
                            '~/.config/nvim/lua/config/' .. filename .. '.lua')
    local config_readable = vim.fn.filereadable(config_path) == 1
    return config_readable
end

local function use_wrapper(orig_use)
    return function(opts)
        local config_name
        if type(opts) == 'string' then
            config_name = opts:gsub('.*/(.*)', '%1'):gsub('%.', '-')
            if file_exists(config_name) then
                opts = {
                    opts,
                    config = [[require 'config/]] .. config_name .. [[']]
                }
            end
        end
        if type(opts) == 'table' and type(opts[1]) == 'string' then
            config_name = opts[1]:gsub('.*/(.*)', '%1'):gsub('%.', '-')
            if file_exists(config_name) then
                opts.config = [[require 'config/]] .. config_name .. [[']]
            end
        end
        orig_use(opts)
    end
end
--}}}

local function init(use)
-- Init {{{
    local use = use_wrapper(use)
    use { 'wbthomason/packer.nvim', opt = true }
    use 'antoinemadec/FixCursorHold.nvim'
--}}}

-- UI {{{
    use 'kyazdani42/nvim-web-devicons'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mhinz/vim-startify'
    use 'gcmt/taboo.vim'
    use 'winston0410/cmd-parser.nvim'
    use 'winston0410/range-highlight.nvim'
    use 'rcarriga/nvim-notify'
    use 'folke/which-key.nvim'
    use 'folke/trouble.nvim'
--}}}

-- Actions {{{
    use 'numToStr/Comment.nvim'
    use 'tpope/vim-repeat'
    use 'machakann/vim-sandwich'
    use 'junegunn/vim-easy-align'
--}}}

-- Colors {{{
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
        }
    }
    use 'rktjmp/lush.nvim'
    use 'rktjmp/shipwright.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
--}}}

-- Languages {{{
    use {
        'Saecki/crates.nvim',
        event = {'BufRead Cargo.toml'},
        requires = 'nvim-lua/plenary.nvim'
    }
--}}}

-- Finder {{{
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'ahmedkhalf/project.nvim'
--}}}

-- Lsp / Completion {{{
    use 'neovim/nvim-lspconfig'
    use 'L3MON4D3/LuaSnip'
    use 'onsails/lspkind-nvim'

    use {
        'hrsh7th/nvim-cmp',
        after = 'LuaSnip',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'kdheepak/cmp-latex-symbols',
        },
    }

    use { 'windwp/nvim-autopairs', after = 'nvim-cmp' }
--}}}
end

-- Packer Init {{{
local config = {
    display = {
        open_fn = util.float
    }
}

packer.startup { init, config = config }
--}}}

-- vim: foldmethod=marker foldlevel=0 foldenable foldmarker={{{,}}}
