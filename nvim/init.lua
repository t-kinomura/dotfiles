require'color'
require'setting'
require'keymap'
require'plugins'

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "lua/plugins.lua" },
  command = "PackerCompile",
})

local has = function(x) 
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_linux = has "linux"

if is_mac then
  require'macos'
end

if is_linux then
  require'linux'
end


-- rust tools seting
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
-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.api.nvim_create_autocmd({"CursorHold"}, {
  pattern = { "*" },
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end
})

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = { "*.php" },
  callback = function()
	  vim.opt_local.autoindent = true
	  vim.opt_local.smartindent = true
  end
})

