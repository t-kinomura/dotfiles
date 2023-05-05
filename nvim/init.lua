require 'color'
require 'setting'
require 'keymap'
require 'plugins'

local has = function(x)
    return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_linux = has "linux"

if is_mac then
    require 'macos'
end

if is_linux then
    require 'linux'
end

local configGrp = vim.api.nvim_create_augroup("SaveConfig", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "lua/plugins.lua" },
    command = "PackerCompile",
    group   = configGrp
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.lua" },
    command = "luafile %",
    group   = configGrp
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = { "*" },
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end
})

local phpGrp = vim.api.nvim_create_augroup("PhpIndent", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "*.php" },
    callback = function()
        vim.opt_local.autoindent = true
        vim.opt_local.smartindent = true
    end,
    group = phpGrp
})

local termGrp = vim.api.nvim_create_augroup("Terminal", { clear = true })
vim.api.nvim_create_autocmd({ "BufLeave" }, {
    pattern = { "term://*" },
    command = "stopinsert",
    group   = termGrp
})
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    pattern = { "term://*" },
    command = "startinsert",
    group   = termGrp
})
