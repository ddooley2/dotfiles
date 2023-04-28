-- map leaders
vim.cmd([[let mapleader = " "]])
vim.cmd([[let maplocalleader = ","]])

vim.cmd('filetype plugin indent on')

vim.g.vimtex_view_method = 'zathura'
vim.cmd([[set completeopt=menuone,noinsert,noselect]])

vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]])

-- Viewer options: One may configure the viewer either by specifying a built-in
vim.g.vimtex_compiler_method = 'latexmk'
-- R Stuff
vim.cmd([[let R_nvimpager = "horizontal"]])
vim.cmd([[let R_csv_app = "terminal:vd"]])
vim.cmd([[let R_app = "radian"]])
vim.cmd([[let R_cmd = "R"]])
vim.cmd([[let R_hl_term = 0]])
vim.cmd([[let R_args = [] ]])
vim.cmd([[let R_bracketed_paste = 1]])
vim.cmd([[let R_assign = 0]])

-- disable autoindent when pasting text
-- source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
vim.cmd([[let &t_SI .= "\<Esc>[?2004h"]])
vim.cmd([[let &t_EI .= "\<Esc>[?2004l"]])
-- copy, cut and paste
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('v', '<C-x>', '"+c')
vim.keymap.set('v', '<C-v>', 'c<ESC>"+p')
vim.keymap.set('i', '<C-v>', '<ESC>"+pa')
-- restore previous place in file
vim.cmd([[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- python
vim.cmd([[autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab]])
vim.cmd([[autocmd FileType python map <buffer> ,p :w<CR>:exec '!python' shellescape(@%, 1)<CR>]])
vim.cmd([[autocmd FileType python imap <buffer> ,p <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>]])

-- code folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- always show the status bar
vim.opt.laststatus = 2

-- -- enable 256 colors
-- vim.go.t_Co = 256

-- turn on line numbering
vim.opt.number = true

-- sane text files
vim.opt.fileformat = 'unix'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- sane editing
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true


-- Disables automatic commenting on newline:
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

-- Select one word on cursor:
vim.keymap.set('n', '<leader>c', 'yiw')
vim.keymap.set('n', '<leader>x', 'diw')
              
-- Insert newline without going into insert mode
vim.keymap.set('n', '<CR>', 'o<Esc>k')
vim.keymap.set('n', '<BS>', 'O<Esc>j')

-- Replace all aliased to S
vim.keymap.set('n', 'S', ':%s//g<Left><Left>')
-- Count pattern aliased to C
vim.keymap.set('n', 'C', ':%s///gn<Left><Left><Left><Left>')

-- Copy selected text to system clipboard
vim.keymap.set('n', '<C-c>', '+y')
vim.keymap.set('n', '<C-p>', '+p')

-- Hotkeys for quickly saving and exiting documents and remapping
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader><CR>', ':wq<cr>')
