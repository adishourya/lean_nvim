-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
	{ command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager

	-- Keep this before any other plugin
	-- for reducing startup time
	use { 'lewis6991/impatient.nvim',
		config = function()
			require('impatient')
		end
	}

	-- UI stuff (Aesthetics)
	use {'adishourya/shade.nvim',config=function ()
		require'shade'.setup({
			overlay_opacity = 70,
		})
	end}

	use {'stevearc/dressing.nvim',
	config = function ()
		require("dressing").setup()
	end}

	use({
		'rcarriga/nvim-notify',
		config = function()
			require('notify').setup({
				stages = 'slide',
				timeout = 1000,
			})
			vim.notify = require('notify')
		end,
	})

	-- animates cursor , scroll , window resizing
	use { 'echasnovski/mini.animate',config =function ()
		require('mini.animate').setup()
	end}

	-- Use "gc" to toggle and untoggle comments
	use { 'tpope/vim-commentary'}

	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup {}
		end
	}

	-- UI to select things (files, grep results, open buffers...)
	use { 'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim','nvim-tree/nvim-web-devicons'},
		config = function()
			-- settings
			require('telescope').setup {
				defaults = require('telescope.themes').get_ivy {
					selection_caret = "->  ",
				},
			}
		end
	}

	use { "nvim-telescope/telescope-file-browser.nvim" ,
	config = function()
		-- settings
		require("telescope").setup {
			extensions = {
				file_browser = {
					theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
				},
			},
		}
		require("telescope").load_extension "file_browser"
	end}

	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
		config = function()
			-- settings
			require('telescope').setup {
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case" ,the default case_mode is "smart_case"
					}
				}
			}
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require('telescope').load_extension('fzf')
		end
	}
	-- use{"elihunter173/dirbuf.nvim",config=function ()
	-- 	require("dirbuf").setup {
	-- 		hash_padding = 2,
	-- 		show_hidden = false,
	-- 		sort_order = "directories_first",
	-- 		write_cmd = "DirbufSync",
	-- 	}
	-- end}


	-- Get Colorscheme
	-- Install without configuration
	use({ "adishourya/catppuccin_chocolatey", as = "chocolatey" })
	-- Others
	use({
		"projekt0n/github-nvim-theme",
		"Shatur/neovim-ayu",
		"shaunsingh/nord.nvim",
		"neanias/everforest-nvim",
		"catppuccin/nvim",
		"sainnhe/everforest",
		"sainnhe/gruvbox-material",
		"sainnhe/edge",
		"sainnhe/sonokai",
		"adishourya/monokaipro",
			})

	-- resize buffers / splits
	use {
		"kwkarlwang/bufresize.nvim",
		config = function()
			require("bufresize").setup()
		end
	}

	-- Colors my hex and rgbs
	use { 'norcalli/nvim-colorizer.lua',
		config = function()
			require 'colorizer'.setup()
		end }

	-- Add indentation guides even on blank lines
	use { 'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('indent_blankline').setup({
				-- settings
				-- vim.g:indent_blankline_char_list = {'|', '¦', '┆', '┊'}
				char = '│', --,'┆','┊',
				show_foldtext = false,
				context_char = '┃',
				filetype_exclude = {
					"help",
					"terminal",
					"alpha",
					"packer",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
					"mason",
					"",
				},
				buftype_exclude = { "terminal" },
				show_trailing_blankline_indent = false,
				show_first_indent_level = true,
				show_current_context = true,
				show_current_context_start = false,
			})
		end
	}


	-- Add git related info in the signs columns and popups
	use { 'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup({
				signcolumn = true,
				numhl = false,
				linehl = false
			})
		end,
		event = 'BufRead'
	}

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use { 'nvim-treesitter/nvim-treesitter',commit="4cccb6f"}
	use { "nvim-treesitter/playground",after="nvim-treesitter"  }
	use { "nvim-treesitter/nvim-treesitter-textobjects" , after = "nvim-treesitter"}

	-- change/add surrounding around selection
	use({ 'tpope/vim-surround', event = 'BufRead' })
	-- Clean Ntrw
	use { 'tpope/vim-vinegar' }

	-- LSP Stuff
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
	use { 'j-hui/fidget.nvim',
		config = function()
			require 'fidget'.setup({
				text = { spinner = "bouncing_ball" }
			})
		end }
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				-- your configuration
				symbol_in_winbar = {
					in_custom = true
				},
			})
		end,
	})

	-- Completion stuff
	--
	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require "lsp_signature".setup({
				wrap = true,
			})
		end,
	})

	-- completion and sources

	use{
		"hrsh7th/nvim-cmp",
		module = "cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		config = function() require("plugs.completion") end,
	}
	use{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", module = "cmp_nvim_lsp" }
	use{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
	use{ "hrsh7th/cmp-buffer", after = "nvim-cmp" }
	use{ "hrsh7th/cmp-path", after = "nvim-cmp" }
	use{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
	use{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }
	-- use{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
	use{ "lukas-reineke/cmp-under-comparator", after = "nvim-cmp", module = "cmp-under-comparator" }

	use{
		"windwp/nvim-autopairs",
		event = { "InsertEnter", "CmdLineEnter" },
		module = "nvim-autopairs.completion.cmp",
		after = "nvim-cmp",
		config = function() require("nvim-autopairs").setup({}) end,
	}
	use{
		"l3mon4d3/luasnip",
		after = "nvim-cmp",
		module = "luasnip",
		event = "InsertEnter",
		config = function()
			require("luasnip").config.setup({
				enable_autosnippets = true,
				history = true,
				updateevents = "TextChanged,TextChangedI,InsertLeave",
			})
			require("luasnip.loaders.from_vscode").load()
		end,
	}
	use{ "rafamadriz/friendly-snippets", after = "luasnip", event = "InsertEnter" }
	use{
		"danymat/neogen",
		module = "neogen",
		ft = {
			"sh",
			"c",
			"cpp",
			"go",
			"lua",
			"python",
			"rust",
		},
		config = function() require("neogen").setup({}) end,
	}

end)
