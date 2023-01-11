-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = {'clangd','pyright', 'sumneko_lua', 'gopls' ,"grammarly"}

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
  }
end


-- grammarly
local lsp_conf = require'lspconfig'
lsp_conf.grammarly.setup {
	filetypes = { "markdown", "text" },
	init_options = {
		clientId = 'client_BaDkMgx4X19X9UxxYRCXZo',
	},
}

