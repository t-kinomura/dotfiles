vim.cmd.packadd "packer.nvim"

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
			vim.keymap.set('v', '<S-f>', "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", {}) -- FIXME: 検索語句に空白が含まれてると何故か失敗する
		end
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly',
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					-- width = { -- not working why?
					--   min = 30,
					--   max = 70,
					--   padding = 2
					-- },
					width = 50,
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
	use {
		'neovim/nvim-lspconfig',
		config = function()
			require('lspconfig')['tsserver'].setup {
				on_attach = on_attach,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
				cmd = { "typescript-language-server", "--stdio" }
			}
		end
	}
	use { -- TODO: lazy load
		'williamboman/mason.nvim',
		config = function()
			require("mason").setup()
		end
	}
	use 'williamboman/mason-lspconfig.nvim'
	use {
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require('null-ls')
			null_ls.setup {
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.eslint.with({
						prefer_local = "node_modules/.bin",
					}),
					null_ls.builtins.formatting.prettier.with({
						prefer_local = "node_modules/.bin"
					})
				},
				debug = false
			}
		end
	}
	use {
		'simrat39/rust-tools.nvim',
		config = function()
			local rt = require("rust-tools")
			rt.setup({
			  server = {
				on_attach = function(_, bufnr)
				  -- Hover actions
				  vim.keymap.set("n", "<leader>,", rt.hover_actions.hover_actions, { buffer = bufnr })
				  -- Code action groups
				  vim.keymap.set("n", "<C-space>", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
			  },
			})
		end
	}

	-- Completion framework:
	use "hrsh7th/cmp-nvim-lsp" -- HACK: 本当はInsertEnterで他の依存プラグインと一緒に読み込みたいが、できない(module 'cmp-nvim-lsp' not found)ためstartプラグインとして読み込む
	use {
		'hrsh7th/nvim-cmp',
		module = {"cmp"},
		requires = {
			-- LSP completion source:
			use {'hrsh7th/cmp-nvim-lsp-signature-help', event = {"InsertEnter"}},

			-- Useful completion sources:
			use {'hrsh7th/cmp-buffer', event = {"InsertEnter"}},
			use {'hrsh7th/cmp-path', event = {"InsertEnter"}},
			use {'hrsh7th/cmp-cmdline', event = {"InsertEnter"}},
			use {'hrsh7th/cmp-nvim-lua', event = {"InsertEnter"}},
			use {'hrsh7th/cmp-vsnip', event = {"InsertEnter"}},
			use {'hrsh7th/vim-vsnip', event = {"InsertEnter"}},
			use {'hrsh7th/cmp-calc', event = {"InsertEnter"}},

			-- some sources of nvim-cmp 
			use {
				'petertriho/cmp-git',
				requires = "nvim-lua/plenary.nvim"
			}
		},
		config = function()
			-- 全部readmeからコピペ
			local cmp = require'cmp'
			cmp.setup({
			        snippet = {
			      	  expand = function(args)
			      		  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			      	  end,
			        },
			        window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			        mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					})
			        }),
			        sources = cmp.config.sources({
					{ name = 'path' },
					{ name = 'nvim_lsp', keyword_length = 2},
					{ name = 'cmdline', keyword_length = 2},
					{ name = 'nvim_lsp_signature_help'},
					{ name = 'nvim_lua', keyword_length = 2},
					{ name = 'calc'},
					{ name = 'vsnip' },
			        }, {
			      	  { name = 'buffer' },
			        }),
				formatting = { -- TODO: menu_iconをいい感じにする
					fields = {'menu', 'abbr', 'kind'},
					format = function(entry, item)
						local menu_icon ={
							nvim_lsp = 'λ',
							vsnip = '⋗',
							buffer = 'Ω',
							path = 'π',
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
			        sources = cmp.config.sources({
			      	  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
			        }, {
			      	  { name = 'buffer' },
			        })
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
			        mapping = cmp.mapping.preset.cmdline(),
			        sources = {
			      	  { name = 'buffer' }
			        }
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
			        mapping = cmp.mapping.preset.cmdline(),
			        sources = cmp.config.sources({
			      	  { name = 'path' }
			        }, {
			      	  { name = 'cmdline', keyword_length = 2 }
			        })
			})
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = [[:TSUpdate]],
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "lua", "rust", "toml", "php", "javascript", "jsdoc", "json", "typescript", "tsx", "vue", "css", "html", "go", "gomod", "gosum", "git_rebase", "gitattributes", "gitcommit", "make", "toml", "yaml", "scss", "solidity" },
				auto_install = false,
				auto_tag = {
					enable = true
				},
				highlight = {
					disable = {"php"}, -- インデントが効かなくなるのでオフにする.
					enable = true,
					additional_vim_regex_highlighting=false,
				},
				ident = { enable = true }, 
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				}
			}
		end
	}
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end,
		opt = true,
		event = {"BufRead", "BufNewFile"},
	}
	use {
		"windwp/nvim-ts-autotag",
		config = function() require("nvim-ts-autotag").setup {} end,
	}
	use {
		'j-hui/fidget.nvim',
		config = function()
			require("fidget").setup {}
		end
	}
end)

