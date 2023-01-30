-- Leader
vim.g.mapleader = " "

-- Normal Mode
-- Window間移動
vim.keymap.set("n", "<CR><CR>", "<C-w>w")
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>")


-- Inert Mode
-- Escape
vim.keymap.set("i", "jk", "<ESC>")
-- 現在行を強調
vim.o.cursorline = true


-- nvim-treeでoffにするのをおすすめされた
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


