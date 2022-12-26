require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {"sumneko_lua"}
})

require("lspconfig").sumneko_lua.setup{}

-- grammarly
local lsp_conf = require'lspconfig'
lsp_conf.grammarly.setup {
	filetypes = { "markdown", "text" },
	init_options = {
		clientId = 'client_BaDkMgx4X19X9UxxYRCXZo',
	},
}

