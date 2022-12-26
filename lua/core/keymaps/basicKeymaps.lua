-- This file should contain ** ALL ** the basic keymappings
local map = vim.keymap.set

-- Edit Vimrc
map('n','\\ev',":tabnew ~/.config/nvim/init.lua<CR>")

-- Autochdir breaks many plugins and is not really a good habbit
map('n','<Leader>cd',":cd %:p:h<CR> :lua vim.notify('changed Dir')<cr>")

-- Buffer
map('n', '<Leader><Esc>', ':bd<CR>', { noremap = true })
map('n', '<C-l>', ':noh<CR>', { noremap = true })
map('n', '<Leader>]', ':bnext<CR>', { noremap = true })
map('n', '<Leader>[', ':bprev<CR>', { noremap = true })

-- Escape terminal like a human
vim.cmd [[tnoremap <Esc> <C-\><C-N>]]

-- Window navigation
map('n', '\\a', ':wincmd h<CR>', { noremap = true })
map('n', '\\s', ':wincmd j<CR>', { noremap = true })
map('n', '\\w', ':wincmd k<CR>', { noremap = true })
map('n', '\\d', ':wincmd l<CR>', { noremap = true })

-- Tab Navigation
map('n','\\1','1gt',{noremap=true})
map('n','\\2','2gt',{noremap=true})
map('n','\\3','3gt',{noremap=true})
map('n','\\4','4gt',{noremap=true})
map('n','\\5','5gt',{noremap=true})
map('n','\\6','6gt',{noremap=true})
map('n','\\7','7gt',{noremap=true})

-- Make splits
map('n', '_', ':sp<CR>', { noremap = true })
map('n', '|', ':vsp<CR>', { noremap = true })

-- resize splits
map('n', '<A-l>', ':vertical resize -10 <CR>', { noremap = true })
map('n', '<A-h>', ':vertical resize +10 <CR>', { noremap = true })
map('n', '<A-j>', ':resize +5 <CR>', { noremap = true })
map('n', '<A-k>', ':resize -5 <CR>', { noremap = true })


vim.cmd [[
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
inoremap <M-f> <ESC><Space>Wi
inoremap <M-b> <Esc>Bi
inoremap <M-d> <ESC>cW
]]

map('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>rf', ':Telescope oldfiles<CR>', { noremap = true })
map('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true })
map('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true })
map('n', '<leader>h', ':Telescope keymaps <CR>', { noremap = true })

-- Change word
map('n', '<Leader><F2>', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', { noremap = true })

-- git signs
map('n',"\\gs",':Gitsigns toggle_signs <CR>')
map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

map('n', '<leader>sh', ':Gitsigns stage_hunk<CR>', { noremap = true })
map('v', '<leader>sh', ':Gitsigns stage_hunk<CR>', { noremap = true })
map('n', '<leader>sb', ':Gitsigns stage_buffer<CR>', { noremap = true })

map('n', '<leader>rh', ':Gitsigns reset_hunk<CR>', { noremap = true })
map('v', '<leader>rb', ':Gitsigns reset_buffer<CR>', { noremap = true })

map('n', '<leader>uh', ':Gitsigns undo_stage_hunk<CR>', { noremap = true })
map('n', '<leader>ph', ':Gitsigns preview_hunk<CR>', { noremap = true })
map('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true })
map('n', '<leader>hd', ':Gitsigns diffthis<CR>', { noremap = true })
map('n', '<leader>td', ':Gitsigns toggle_deleted<CR>', { noremap = true })

--lsp stuff

local lspconfig_keybinds = {
	outline ="<leader>o",
	finder = "gh",
	declaration = "gD",
	definition = "gd",
	preview_definition = "<leader>pd",
	hover = "K",
	implementation = "gi",
	signature_help = "gk",
	add_workspace_folder = "<leader>wa",
	remove_workspace_folder = "<leader>wr",
	list_workspace_folders = "<leader>wl",
	type_definition = "<leader>D",
	rename = "<leader>rn",
	code_action = "<leader>ca",
	references = "gr",
	float_diagnostics = "ge",
	goto_prev = "[d",
	goto_next = "]d",
	goto_err_prev = "[E",
	goto_err_next = "]E",
	set_loclist = "<leader>q",
	formatting = "<leader>fm",
}



local ok_saga, saga = pcall(require, 'lspsaga')
if ok_saga then
	-- lspsaga
	saga.init_lsp_saga()
	map("n",lspconfig_keybinds.outline, "<cmd>LSoutlineToggle<CR>", {silent=true})
	map("n", lspconfig_keybinds.finder, "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
	map("n", lspconfig_keybinds.code_action, "<cmd>Lspsaga code_action<CR>", { silent = true })
	map("v", lspconfig_keybinds.code_action, "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
	map("n", lspconfig_keybinds.references, "<cmd>Lspsaga rename<CR>", { silent = true })
	map("n", lspconfig_keybinds.preview_definition, "<cmd>Lspsaga peek_definition<CR>", { silent = true })
	map("n", lspconfig_keybinds.definition, "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.float_diagnostics, "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
	map("n", lspconfig_keybinds.goto_prev, "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
	map("n", lspconfig_keybinds.goto_next, "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
	map("n", lspconfig_keybinds.goto_err_prev, function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })
	map("n", lspconfig_keybinds.goto_err_next, function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })
	map("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
	map("n", lspconfig_keybinds.hover, "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	map("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
	map("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
else
	-- normal
	map("n", lspconfig_keybinds.declaration, "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.definition, "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.hover, "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.implementation, "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.signature_help, "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.add_workspace_folder, "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.remove_workspace_folder, "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.list_workspace_folders,
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { noremap = true })
	map("n", lspconfig_keybinds.type_definition, "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.rename, "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.references, "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.float_diagnostics, "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.set_loclist, "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.formatting, "<cmd>lua vim.lsp.buf.format({async=true})<CR>", { noremap = true })

end
