-- Leader
vim.g.mapleader = " "

-- options
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ambiwidth = "single"  -- East Asian Ambigous Width関係の設定, neovimだとsingleがいいらしい
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- nvim-treeでoffにするのをおすすめされた
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- completion
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess:append({ c = true })
vim.opt.updatetime = 300

-- indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- 0に設定するとtabstopに従う
vim.opt.expandtab = noexpand -- tabの入力をspaceに置き換えない

