-- This file should contain ** ALL ** the basic keymappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Edit Vimrc
vim.keymap.set('n','\\ev',":Telescope find_files cwd=~/.config/nvim <cr>")
vim.keymap.set('n','\\ed',":Telescope find_files cwd=~/.config <cr>")

-- Autochdir breaks many plugins and is not really a good habbit
vim.keymap.set('n','<Leader>cd',":cd %:p:h<CR> :lua vim.notify('changed Dir')<cr>")

-- Buffer
vim.keymap.set('n', '<Leader><Esc>', ':bd<CR>', { noremap = true })
vim.keymap.set('n', '<C-l>', ':noh<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>]', ':bnext<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>[', ':bprev<CR>', { noremap = true })

-- Escape terminal like a human
vim.cmd [[tnoremap <Esc> <C-\><C-N>]]

-- Window navigation
vim.keymap.set('n', '\\a', ':wincmd h<CR>', { noremap = true })
vim.keymap.set('n', '\\s', ':wincmd j<CR>', { noremap = true })
vim.keymap.set('n', '\\w', ':wincmd k<CR>', { noremap = true })
vim.keymap.set('n', '\\d', ':wincmd l<CR>', { noremap = true })

-- Tab Navigation
vim.keymap.set('n','\\1','1gt',{noremap=true})
vim.keymap.set('n','\\2','2gt',{noremap=true})
vim.keymap.set('n','\\3','3gt',{noremap=true})
vim.keymap.set('n','\\4','4gt',{noremap=true})
vim.keymap.set('n','\\5','5gt',{noremap=true})
vim.keymap.set('n','\\6','6gt',{noremap=true})
vim.keymap.set('n','\\7','7gt',{noremap=true})

-- Make splits
vim.keymap.set('n', '_', ':sp<CR>', { noremap = true })
vim.keymap.set('n', '|', ':vsp<CR>', { noremap = true })

-- resize splits
vim.keymap.set('n', '<A-l>', ':vertical resize -20 <CR>', { noremap = true })
vim.keymap.set('n', '<A-h>', ':vertical resize +20 <CR>', { noremap = true })
vim.keymap.set('n', '<A-j>', ':resize +10 <CR>', { noremap = true })
vim.keymap.set('n', '<A-k>', ':resize -10 <CR>', { noremap = true })

vim.keymap.set('n', '<A-L>', ':vertical resize -200 <CR>', { noremap = true })
vim.keymap.set('n', '<A-H>', ':vertical resize +200 <CR>', { noremap = true })
vim.keymap.set('n', '<A-J>', ':resize +200 <CR>', { noremap = true })
vim.keymap.set('n', '<A-K>', ':resize -200 <CR>', { noremap = true })


-- Force of habbit mappings
vim.keymap.set('n','<C-a>','<Esc>^',{noremap=true})
vim.keymap.set('i','<C-a>','<Esc>^',{noremap=true})
vim.keymap.set('n','<C-e>','<Esc>$',{noremap=true})
vim.keymap.set('i','<C-e>','<Esc>A',{noremap=true})

-- Insert new lines from normal mode
-- vim.keymap.set('n','<CR>','m`o<Esc>``')
-- vim.keymap.set('n','<S-CR>','m`O<Esc>``')

-- scroll paragraph with ctrl-f and ctrl-b without polluting the jump list
vim.cmd[[
nnoremap <C-f> :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <C-b> :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
]]
