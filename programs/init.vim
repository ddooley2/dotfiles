let mapleader =" "

set visualbell

call plug#begin()
"Prose
	Plug 'junegunn/goyo.vim'
	Plug 'matze/vim-tex-fold'
"Coding
	Plug 'heavenshell/vim-pydocstring' " this can be replaced by a snippet plugin
	Plug 'ervandew/supertab'
"	Plug 'ycm-core/YouCompleteMe' " This is for coding auto-completion features
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

"General
	Plug 'vimwiki/vimwiki'
	Plug 'skywind3000/asyncrun.vim' "Run compilation in the background

"Syntax
	Plug 'vifm/vifm.vim'

"Colors!
	Plug 'itchyny/lightline.vim'
	Plug 'morhetz/gruvbox'
	Plug 'tlhr/anderson.vim'
	Plug 'ludokng/vim-odyssey'
	Plug 'w0ng/vim-hybrid'

call plug#end()

" C stuff:
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" VSCode stuff
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
endif

set exrc
set secure


set nohlsearch
set clipboard+=unnamedplus
"let g:gruvbox_contrast_dark = 'soft'


" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	colorscheme odyssey
	set number
	set noswapfile
	set nofoldenable
	set ts=4 sw=4

" Enable autocompletion on command line:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Mappings for split windows:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Mappings for tabs:
	map tk :tabr<cr>
	map tj :tabl<cr>
	map th :tabp<cr>
	map tl :tabn<cr>
" Select one word on cursor:
	noremap <leader>c yiw
	noremap <leader>x diw
" Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l

" Toggle line number
	map <leader>1 :set invnumber invrelativenumber <CR>

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR> | hi clear SpellBad | hi SpellBad cterm=underline

" Insert new line above without going into insert mode
" (uses mark o to return to the previous cursor column)
 	nnoremap <CR> o<Esc>k
 	nnoremap <BS> O<Esc>j


" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Check file in shellcheck:
	map <leader>h :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>


" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>q :w! \| !compiler <c-r>%<CR><CR>
	"map <leader>c :AsyncRun compiler % <cr>
" Compile document, but turn modifier to 1 (e.g. compile .md as slides).
	map <leader>k :w! \| !compiler <c-r>% 1<CR><CR>
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex,*.cls set filetype=tex

	autocmd BufRead,BufNewFile *.sh set filetype=sh

" Use urlscan to choose and open a url:
	:noremap <leader>u :w<Home> !urlscan -r 'linkhandler {}'<CR>
	:noremap ,, !urlscan -r 'linkhandler {}'<CR>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	noremap <C-c> "+y
	noremap <C-p> "+p

" Delete into blackhole register to preserve clipboard contents
"	nnoremap d "_d
"	vnoremap d "_d
	"nnoremap D "_D
	"vnoremap D "_D

" Paste removing newlines (WIP)
	"nnoremap P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.bm* !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb

" Update bibliography copies when parent is modified.
	autocmd BufWritePost $BIB !bib-update

" Hotkeys for quickly saving documents and remapping
	inoremap jk <Esc>
	noremap <leader><CR> :w!<cr>
	noremap <leader><BS> :q<cr>

" Export text under the cursor
	noremap <leader>E :w! >><Space>

" Export text under the cursor and delete
	command! -range=% -nargs=1 -complete=file MoveTo
	        \ <line1>,<line2>write! >> <args> | <line1>,<line2>d_
	xnoremap <leader>e :MoveTo<Space>
	nnoremap <leader>e :MoveTo<Space>

" Map to disable vims evil autoindent (currenlty used in latex)
	nnoremap <F8> :setl noai nocin nosi inde=<CR>

" Replacing under the cursor
	nnoremap <leader>r :%s/\<<C-r><C-w>\>//gc<left><left><left>
	"" The line below to add external functions (lh#visual#selection()
	"" vnoremap <leader>r <c-\><c-n>:let @/ .= '\\|'.escape(lh#visual#selection(), '/\^$*.[~')<cr>n

" SuperTab pluggin
	runtime! plugin/supertab.vim
	inoremap <s-tab> <tab>
	let g:SuperTabMappingTabLiteral = '<s-tab>'
	let g:SuperTabNoCompleteAfter = ['\s', '&']
	let g:SuperTabNoCompleteBefore = ['&']

" Case insensitive search with no capital while case sensitive search when captial is present
	set smartcase
	set ignorecase

" Other
	set undofile " persitent undo
	set inccommand=nosplit " show real time changes to ex command
	set statusline=%<%f%=%-14.(%)%l\ " status
	nnoremap Q @@ " Instead of stumbling into ex mode, repeat the last macro used.
"  More intersting maps:
" https://www.hillelwayne.com/post/intermediate-vim/
" e.g., navigate long lines with j and k or set maps easily

" Indentation document
	nnoremap <leader>i mc gg=G `c

" Async run (see more useful guides at the plugin page)
" Toggle quickfix window
	"nnoremap <leader>v :call asyncrun#quickfix_toggle(10)<CR> <C-w>j G <C-w>k


"" Language-specific
"""" LaTeX
	" Word count:
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	" Folding
	autocmd FileType tex nnoremap fs <Space> za
    	let g:tex_fold_additional_envs = ['abstract']
	autocmd FileType tex setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
	" Compilation
	autocmd FileType tex map <leader>q :AsyncRun latexmk -pdf -pvc % <cr>
	map <leader>q :w! \| !compiler <c-r>%<CR><CR>

""" Python
	" Docstrings
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
	let g:pydocstring_templates_dir = '/home/sg/.vim/vim-pydocstring-templates/numpy'
	autocmd FileType python nmap <silent> <C-d> <Plug>(pydocstring) <bar> 2kA<Space>

""" C
	autocmd FileType c,h setlocal cindent shiftwidth=4 expandtab """tabstop=4 shiftwidth=4 softtabstop=4
	autocmd Filetype c,h nnoremap <C><CR> :make!<cr>
"" html
	autocmd FileType html,css,html.tmpl setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
 "____        _                  _
"/ ___| _ __ (_)_ __  _ __   ___| |_ ___
"\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 "___) | | | | | |_) | |_) |  __/ |_\__ \
"|____/|_| |_|_| .__/| .__/ \___|\__|___/
              "|_|   |_|

"""LaTeX
	" General snippets
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ci \cite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,hl \hl{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,fig \begin{figure}[h!]<Enter><Enter>\centering<Enter>\includegraphics[width=<++>\textwidth,height=<++>\textheight]{<++>}<Enter>\caption{<++>}<Enter><Enter>\end{figure}<Enter><Esc>6kfi
	" Beamer
	autocmd FileType tex inoremap ,fr \begin{frame}[t]{<++>}<Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++>
	autocmd FileType tex inoremap ,tk \begin{tikzpicture}<Enter>\draw <++><Enter>\end{tikzpicture}<Enter><++><Esc>6kf}i

	" References
	autocmd FileType tex inoremap ,rr \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,rf (Figure~\ref{fig:}<++>)<++><Esc>T:i
	autocmd FileType tex inoremap ,rt (Table~\ref{tab:})<++><Esc>T:i
	autocmd FileType tex inoremap ,rs (Section~\ref{sec:})<++><Esc>T:i
	autocmd FileType tex inoremap ,re \eqref{eq:}<++><Esc>T:i
	autocmd FileType tex inoremap ,ct \supercite{}<++><Esc>T{i
	" Not using currently
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,- \item<Space>

	function! WC()
		let filename = expand("%")
		let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
		let result = system(cmd)
		echo result . " words"
	endfunction

	command WC call WC()

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO
	autocmd Filetype markdown,rmd inoremap ,cl ``<++><Esc>F`i
	autocmd Filetype markdown,rmd inoremap ,cb ~~~<Enter><Enter>~~~<Enter><++><Esc>2ki

""" Python
	autocmd FileType python inoremap ,db __import__('pdb').set_trace()
	autocmd Filetype python inoremap ,sb #!/usr/bin/env python3<Enter>

""" (Ba)sh
	autocmd Filetype sh inoremap ,sb #!/bin/sh<Enter>
	inoremap ,sb #!/bin/sh<Enter>

""" HTML
