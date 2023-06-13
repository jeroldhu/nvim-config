-- packer: plugins manager
local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require('core.global').vim_path
local data_dir = require('core.global').data_dir
local modules_dir = vim_path .. '/lua/modules'
local packer_compiled = data_dir .. 'packer_compiled.vim'
local compile_to_lua = data_dir .. 'lua/_compiled.lua'
local packer = nil

local function init_ensure_plugins()
    local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
    local state = uv.fs_stat(packer_dir)
    if not state then
        local cmd = "!git clone https://github.com/wbthomason/packer.nvim " ..
                        packer_dir
        api.nvim_command(cmd)
        uv.fs_mkdir(data_dir .. 'lua', 511,
                    function() assert("make compile path dir faield") end)
    end
end

local function startup_plugins()
    if not packer then
        api.nvim_command('packadd packer.nvim')
        packer = require('packer')
    end
    packer.startup(function(use)
        -- Packer can manage itself
        use {'wbthomason/packer.nvim', opt = true}

        use {
            -- Tab页签功能
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require("bufferline").setup {} end
        }

        -- 美化页面
        use {'nvim-lualine/lualine.nvim'}
        use {
            'eddyekofo94/gruvbox-flat.nvim',
            config = require('pconfigs.gruvbox_flat')
        }

        -- use {
        --     'neovim/nvim-lspconfig',
        --     event = 'BufReadPre',
        --     config = require('pconfigs.lsp_config')
        -- }

        -- use {
        --     'tami5/lspsaga.nvim',
        --     branch = 'nvim51',
        --     cmd = 'Lspsaga',
        --     config = require('pconfigs.lspsaga')
        -- }

        use {
            -- 全文检索
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/plenary.nvim'}}
        }

        -- use {
        --     'nvim-treesitter/nvim-treesitter',
        --     event = 'BufRead',
        --     after = 'telescope.nvim',
        --     config = require('pconfigs.nvim_treesitter')
        -- }

        -- use {
        --     "hrsh7th/nvim-cmp",
        --     requires = {
        --     'hrsh7th/vim-vsnip', -- Snippets plugin
        --         'hrsh7th/cmp-nvim-lsp', -- Source nvim lsp
        --         'hrsh7th/cmp-path', -- Completion for file path
        --      'hrsh7th/cmp-buffer', -- Completion for buffer words
        --     },
        --     config = require('pconfigs.complete')
        -- }

        -- use {
        --     'ray-x/go.nvim',
        --     ft = {'go'},
        --     config = function() require('go').setup() end
        -- }

        -- use {'ray-x/lsp_signature.nvim'}

        -- use {
        --     {'nvim-lua/plenary.nvim'},
        --     {'nvim-lua/popup.nvim'},
        --     config = function()
        --         require('telescope').register_extension {
        --             exports = {goimpl = require('custom.lang.go').goimpl}
        --         }
        --     end
        -- }

        use {
            -- 文件树功能
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            opt = true,
            cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
            config = require('pconfigs.nvim_tree')
        }

        -- use {
        --     'phaazon/hop.nvim',
        --     branch = 'v1', -- optional but strongly recommended
        --     config = function()
        --         -- you can configure Hop the way you like here; see :h hop-config
        --         require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        --     end
        -- }

        -- use {
        --   'windwp/nvim-autopairs',
        --   config = function() require('nvim-autopairs').setup{} end
        -- }

        -- -- use {'kdheepak/lazygit.nvim'}

        -- TODO config
        -- use {"akinsho/toggleterm.nvim", config = function () require("toggleterm").setup{} end }

        -- use {'liuchengxu/vista.vim', config=require('pconfigs.vista')}

        -- use {'b3nj5m1n/kommentary', config=function() require('kommentary.config').use_extended_mappings() end}

        -- use {'yamatsum/nvim-cursorline'}

        -- use {'airblade/vim-rooter', config=function() vim.api.nvim_command[[autocmd BufEnter * :Rooter]] end}

        -- use {
        --     "NTBBloodbath/rest.nvim",
        --     ft={'http'},
        --     requires = { "nvim-lua/plenary.nvim" },
        --     config = require('pconfigs.rest')
        -- }
    end)
end

init_ensure_plugins()
startup_plugins()
