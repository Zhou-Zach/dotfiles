" HOW TO DO 90% OF WHAT PLUGINS DO (WITH JUST VIM)



" FEATURES TO COVER:
" - Fuzzy File Search
" - Tag jumping
" - Autocomplete
" - File Browsing
" - Snippets
" - Buid Integration (if we have time)

" BASIC SETUP ------------------------ {{{
" no compatible with vi
set nocompatible

set t_Co=256

filetype plugin indent on
syntax on

set shiftwidth=4
set tabstop=4
autocmd FileType python setlocal sw=4 ts=4
autocmd FileType ruby   setlocal sw=2 ts=2
set smartindent
set expandtab autoindent

set langmenu=en_US
let $LANG='en_US'

" Switch between buffers without having to save first.
set hidden

set incsearch
set hlsearch

set nu
set ignorecase
set background=light
colo default
let mapleader=","
set guifont=Menlo:h13
" }}}

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
" command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" FILE BROWSING:

" Tweaks for browsing
" let g:netrw_banner=0       " disable annoying banner
" let g:netrw_browse_split=4 " open in prior window
" let g:netrw_altv=1         " open splits to the right
" let g:netrw_liststyle=3    " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings


" SNIPPETS ------------------------- {{{
" Read an empty HTML template and move cursor to title
nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)
" }}}

" BUILD INTEGRATION:

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
" set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back

" Download this file at:
" github.com/mcantor/no_plugins

" TRICKS -------------- {{{
nnoremap <leader>n :%s///gn<CR>
nnoremap <leader>/ :%s/\v/gc<Left><Left><Left>
nnoremap <leader>a :AsyncRun 
nnoremap <leader>al :exe 'AsyncRun'.getline('.')<CR>
" NOW WE CAN:
" after <leader>/, type something like search/replace and hit enter.
" }}}

nmap <silent><Leader>d :!open dict://<cword><CR><CR>

" PLUGINS: vim-plug ------------------ {{{
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/skywind3000/asyncrun.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'NLKNguyen/papercolor-theme'
Plug 'https://github.com/wakatime/vim-wakatime/'

call plug#end()
" }}}

" AsyncRun Tools ----------------- {{{
let g:asyncrun_exit = "silent call system('afplay ~/.vim/notify.wav &')"

augroup vimrc
    autocmd!
    autocmd QuickFixCmdPost * botright copen 8
augroup END

:noremap <F8> :call asyncrun#quickfix_toggle(8)<cr>
" }}}

" Learn Vimscript the hard way:
nnoremap <space> za
inoremap <c-u> <esc>viwUea
inoremap <c-d> <esc>ddi

let maplocalleader="\\"

" Edit Vimrc
:nnoremap <leader>ev :split $MYVIMRC<cr>
" Source Vimrc
:nnoremap <leader>sv :source $MYVIMRC<cr>

:iabbrev k8s kubernetes
:iabbrev ssig -- <cr>Steve Losh<cr>steve@stevelosh.com

:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
:vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`<lv`>l

" <esc> <c-c> <c-]> by default:
:inoremap jk <esc>

" clear search reg:
:nnoremap <leader>, :let @/=''<cr>

" auto indent before write html files --------------- {{{
augroup filetype_html
    autocmd!
    autocmd BufWritePre *.html :normal gg=G
    autocmd BufNewFile,BufRead *.html setlocal nowrap
augroup END
" }}}

" source ~/.vimrc after write ~/.vimrc.
autocmd BufWritePost ~/.vimrc :so ~/.vimrc
" Vimscript file settings ----------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" little snippets ------------------------------ {{{
augroup snippets
    autocmd!
    autocmd FileType python     :iabbrev <buffer> iff if:<left>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    autocmd FileType javascript :iabbrev <buffer> r; return ;<left>
    autocmd FileType javascript :iabbrev <buffer> return NOPE
    autocmd FileType javascript :iabbrev <buffer> fnc return function () {<enter>}<Up><End><Left><Left><Left>
    autocmd FileType javascript :iabbrev <buffer> function NOPE
augroup END
" }}}

" markdown head object ------------------------------- {{{
:onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
:onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
" }}}
