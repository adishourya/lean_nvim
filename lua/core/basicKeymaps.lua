-- This file should contain ** ALL ** the basic keymappings
local map = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
map('n', '<A-l>', ':vertical resize -20 <CR>', { noremap = true })
map('n', '<A-h>', ':vertical resize +20 <CR>', { noremap = true })
map('n', '<A-j>', ':resize +10 <CR>', { noremap = true })
map('n', '<A-k>', ':resize -10 <CR>', { noremap = true })

map('n', '<A-L>', ':vertical resize -200 <CR>', { noremap = true })
map('n', '<A-H>', ':vertical resize +200 <CR>', { noremap = true })
map('n', '<A-J>', ':resize +200 <CR>', { noremap = true })
map('n', '<A-K>', ':resize -200 <CR>', { noremap = true })



vim.cmd [[
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
inoremap <M-f> <ESC><Space>Wi
inoremap <M-b> <Esc>Bi
inoremap <M-d> <ESC>cW
]]

-- scroll paragraph with ctrl-f and ctrl-b without polluting the jump list
vim.cmd[[
nnoremap <C-f> :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <C-b> :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
]]
