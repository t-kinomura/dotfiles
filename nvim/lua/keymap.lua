vim.keymap.set("n", "<CR><CR>", "<C-w>w")
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>t", ":tabnew<CR>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>:bp<CR>:bw! term://*<C-a><CR>")
vim.keymap.set("n", "<leader>g", ":term GIT_EDITOR=nvr tig<CR>i")

-- lsp
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-space>', vim.lsp.buf.code_action)
vim.keymap.set('n', 'fff', function()
    vim.lsp.buf.format { async = true }
end, opts)


-- bufferline
vim.keymap.set("n", "<C-n>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-p>", ":BufferLineCyclePrev<CR>")
