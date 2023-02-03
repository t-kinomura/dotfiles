vim.keymap.set("n", "<CR><CR>", "<C-w>w")
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>t", ":tabnew<CR>")

-- lsp
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

