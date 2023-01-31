vim.cmd.packadd "packer.nvim"
-- external requirements
-- packer
-- - (Neovim v0.5.0+)
-- nvim-telescope
-- - ripgrep (see: https://github.com/BurntSushi/ripgrep)
-- - fd (see: https://github.com/sharkdp/fd)
-- nvim-tree
-- - (Neovim v0.8.0+)
-- langage spcecified
-- rust
-- - :MasonInstall rust-analyzer codelldb
-- os specified
-- linux
-- - xclip
return require('packer').startup(function(use)
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-treesitter/nvim-treesitter'},
			{'nvim-tree/nvim-web-devicons'},
		},
		config = function()
			require("telescope").setup()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly', -- optional, updated every week. (see issue #1193)
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
					mappings = {
						list = {
							{ key = "u", action = "dir_up" },
						},
					},
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
			vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
		end
	}
	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/mason.nvim',
		config = function()
			require("mason").setup()
		end
	}
	use 'williamboman/mason-lspconfig.nvim'
	use 'simrat39/rust-tools.nvim'

	-- Completion framework:
	use 'hrsh7th/nvim-cmp'

	-- LSP completion source:
	use 'hrsh7th/cmp-nvim-lsp'

	-- Useful completion sources:
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/vim-vsnip'
	
	use 'nvim-treesitter/nvim-treesitter'
end)

