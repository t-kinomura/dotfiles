vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ambiwidth = "single"  -- East Asian Ambigous Width関係の設定, neovimだとsingleがいいらしい

-- nvim-treeでoffにするのをおすすめされた
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- completion
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess:append({ c = true })
vim.opt.updatetime = 300
