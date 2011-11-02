" configure vim pathogen
" http://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim
filetype on " solves pathogen exit status 1 bug - http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" at home(linux) I can't see shit with railscast theme...
colorscheme vibrantink

" assigning a leader key and mapping some commands to it
let mapleader = ","
map <leader>s :%s/\s\+$//e \| :%s/\t/  /e<CR><C-o>  " use ',s' to clean trailing spaces and remove tabs
map <leader>= <Esc>:1,$!xmllint --format -<CR>  " use ',=' to xml re-indent
nnoremap <leader>k :set invwrap wrap?<CR>  " use ',l' to toggle wordwrap
nnoremap <leader>d :NERDTreeToggle<CR>  " use ',d' to toggle the NERDTree
nmap <leader>p :let @* = expand("%:p")<CR> " use ',p' to copy the current path to the system clipboard
map <leader>F :Ack<space>
set pastetoggle=<leader>p

set ignorecase " we don't the case on the search
set smartcase " in fact we do care the case unless search is all lowercased

" notepad++ style bookmarks -- bookmarking extension
:map <leader>m :ToggleBookmark<CR>
:map & :NextBookmark<CR>

" mapping over the wonderful surround.vim plugin -- thx Tim
:vmap "" S"
:vmap '' S'

" :help usr05
set nocompatible
set backspace=indent,eol,start
set autoindent
set history=100
set cmdwinheight=50
if &t_Co > 2 || has("gui_running")
  syntax on
endif
set ruler
set wrap

" set options
set nobackup
set nowritebackup
set showcmd  	" display incomplete commands
set incsearch  	" do incremental searching
set number    " display line numbers
set showmatch  " show matching bracket
set foldmethod=indent   " folding is available following indentation
set nofoldenable    " disable folding by default

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" set tw=72 " when the line will wrap

" Always display the status line
set laststatus=2

imap <S-C-v> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML :call DoPrettyXML()

function! DeleteInactiveHiddenBufs()
  let i = 1
  let lastBufNr = bufnr('$')
  let nWipeouts = 0
  while i <= lastBufNr
    if bufexists(i) && ! buflisted(i) && bufwinnr(i) == -1
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
    let i = i + 1
  endwhile
  echomsg nWipeouts . ' buffer(s) wipedout'
endfunction
command! DeleteInactiveHiddenBufs :call DeleteInactiveHiddenBufs()


" activate plugin for matchit (don't really know if it's a good idea to let that here though)
filetype plugin on

" some Lusty plugins specifics
nnoremap <leader>b :LustyBufferExplorer<CR>  " use ',b' instead of default ',lb' to access the buffers fuzzy finder plugin
nnoremap <leader>j :LustyJuggler<CR>  " use ',j' instead of default ',lj' to access the recent buffers juggler plugin
" activate a mode required by lustyExplorer plugin
:set hidden
