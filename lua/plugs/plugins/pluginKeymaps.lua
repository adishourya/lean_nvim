local map = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Put it in a box
map('n', '\\-', '<cmd>.!toilet -f term -F border <cr> <cmd>Commentary<cr> jVj:Commentary<cr>',{noremap=true})
map('v', '\\-', '<cmd>.!toilet -f term -F border <cr> <cmd>Commentary<cr> jVj:Commentary<cr>',{noremap=true})

map('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>rf', ':Telescope oldfiles<CR>', { noremap = true })
map('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true })
map('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true })
map('n', '<leader>km', ':Telescope keymaps <CR>', { noremap = true })

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

