" https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" syntax plugins
Plug 'tpope/vim-markdown', { 'for':  'markdown' }
Plug 'tpope/vim-haml', { 'for':  'haml' }
Plug 'elzr/vim-json', { 'for':  'json' }
Plug 'vim-ruby/vim-ruby', { 'for':  'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for':  'coffee' }
Plug 'moll/vim-node', { 'for':  'node' }
Plug 'chase/vim-ansible-yaml', { 'for':  'yml' }
Plug 'evanmiller/nginx-vim-syntax', { 'for':  'nginx.conf' }
" fold plugins
Plug 'nelstrom/vim-markdown-folding', { 'for':  'markdown' }
" theme plugins
Plug 'jpo/vim-railscasts-theme'
Plug 'vim-scripts/vibrantink'
" toys
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'GutenYe/json5.vim', { 'for':  'json5' }
Plug 'scrooloose/nerdcommenter'
Plug 'vimtaku/hl_matchit.vim' "enable easy jumps from/to matching bracket/tag
Plug 'dterei/VimBookmarking', { 'on': [] }
Plug 'tpope/vim-surround' "surrounding words, motion, selection with quotes or tags
Plug 'vim-scripts/upAndDown'
Plug 'Townk/vim-autoclose' "auto-close brackets for you !
Plug 'tsaleh/vim-align'
Plug 'godlygeek/tabular'
Plug 'ctrlpvim/ctrlp.vim' " FuzzySearch in tree
Plug 'tpope/vim-fugitive' "embedded git
Plug 'tpope/vim-unimpaired' "magic ]q jumps
Plug 'rking/ag.vim' " silversearcher via :Ag
Plug 'bogado/file-line' "open file at line :line
Plug 'junegunn/goyo.vim' " distraction free writing
Plug 'junegunn/limelight.vim' " Hyperfocus via paragraph contrast - nice to demo code
if has('mac')
  Plug 'junegunn/vim-xmark' " render Markdown in broswer
endif
call plug#end()

" assigning a leader key and mapping some commands to it
let mapleader = ","
" ',s' to clean trailing spaces and remove tabs
map <leader>s :%s/\s\+$//e \| :%s/\t/  /ge<CR><C-o>  
" ',=' to xml re-indent
map <leader>= <Esc>:1,$!xmllint --format -<CR>
" ',l' to toggle wordwrap
nnoremap <leader>k :set invwrap wrap?<CR>
" ',d' to toggle the NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>  
" Change few NerdTree shortcuts
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'
" ',;' to toggle paste mode
set pastetoggle=<leader>;
" ',cd' to change directory to the current file path
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" ',p' put current buffer filepath to the clipboard
let s:uname = system("uname")
if s:uname == "Darwin\n"
  " Do Mac stuff here
  colorscheme railscasts
  nmap <leader>p :let @* = expand("%:.")<CR> " use ',p' to copy the current file relative path to the system clipboard
  nmap <leader>P :let @* = expand("%:p")<CR> " use ',P' to copy the current file absolute path to the system clipboard

else
  " Do Linux Specifc here (gvim)
  colorscheme vibrantink " at home(linux) I can't see shit with railscast theme...
  nmap <leader>p :!echo "%:." \|xsel -ib<CR><CR>
  nmap <leader>P :!echo "%:p" \|xsel -ib<CR><CR>
endif

" :Ack/Ag configuration
let g:ackprg="ack -H --nocolor --nogroup --column --ignore-dir log --ignore-dir tmp --ignore-dir .sass-cache --ignore-dir build"

" notepad++ style bookmarks (nobody's perfect) -- bookmarking plugin
:map 22 :ToggleBookmark<CR>
:map <C-2> :NextBookmark<CR>
:map <C-@> :PreviousBookmark<CR>

" mapping over the wonderful surround.vim plugin -- thx Tim
:vmap "" S"
:vmap '' S'

" add mapping for json pretty print - https://pascalprecht.github.io/2014/07/10/pretty-print-json-in-vim/
map <leader>jp <Esc>:%!python -m json.tool<CR>

" set options
set nocompatible " needed by some plugins
set backspace=indent,eol,start
set autoindent sw=2 et " auto-indend at new line
set copyindent " copy the previous indentation on autoindenting
set list " show special characters
set history=1000 " default is 20
set undolevels=1000 " use many muchos levels of undo
set cmdwinheight=50 " number of line of the Command Window (used by :Ack results)
set ruler " show <row>,<column> position on the right of the status bar
set wrap " word wrapping is on by default
syntax on "syntax highlighting
set nobackup       " no backup files
set ignorecase " we don't the case on the search
set hlsearch      " highlight search terms
set smartcase " in fact we do care the case unless search is all lowercased
set nowritebackup  " only in case you don't want a backup file while editing
set hidden " non-visible buffers are just hidden, not closed (keep buffer history)
set noswapfile     " no swap files
set showcmd  " display incomplete commands
set incsearch  " do incremental searching
set number    " display line numbers
set showmatch  " show matching bracket
set foldmethod=manual   " folding like a nerd
set nofoldenable    " disable folding by default
set laststatus=2 " Always display the status line
set tabstop=2 shiftwidth=2 expandtab " tabs are converted into 2 spaces
set wildignore=log/**,tmp/cache,BUILD/**,BUILDROOT/*,RPMS,SOURCES,*.xcodeproj/**,CordovaLib/**,www/**,*.png,*.gif,*.jpg,*.jpeg,*.ico " ignore some files (used by command-t plugin)
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Setup some specifics for CtrlP
let g:ctrlp_cmd = 'CtrlPMixed'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Shift-K searchs with ag
nnoremap K :Ag <C-R><C-W><CR>

" Fugitive setups -  http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" Auto-clean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete


" -- some functions --


" DoPrettyXML beautifies an XML buffer (XML must be valid)
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
command! BeautifyXML :call DoPrettyXML()

command! PrettyJSON :%!python -m json.tool
command! BeautifyJSON :%!python -m json.tool

" RePackXML de-beautify an XML buffer (compact style)
function! RePackXML()
  " remove extra space at beginning of lines
  %s/^\s\+//e
  " same for end of line spaces
  %s/\s\+$//e
  " remove end of line return
  %s/\n//e
endfunction
command! PackXML :call RePackXML()
command! RePackXML :call RePackXML()

" mapping to change the working directory to the current file path
nnoremap ,cd :lcd %:p:h<CR>

" associate specific extensions with specific filetypes
autocmd BufRead,BufNewFile *.rc set filetype=sh
autocmd BufRead,BufNewFile *.hamlc,*.hamstache set filetype=haml
autocmd BufRead,BufNewFile *.template,*.json set filetype=json foldmethod=syntax
let g:vim_json_syntax_conceal = 0 " specific to vim-json plugin (to keep the double quotes visible)
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

" Delete file from current buffer - from http://vim.wikia.com/wiki/Delete_files_with_a_Vim_command
function! DeleteFile(...)
  if(exists('a:1'))
    let theFile=a:1
  elseif ( &ft == 'help' )
    echohl Error
    echo "Cannot delete a help buffer!"
    echohl None
    return -1
  else
    let theFile=expand('%:p')
  endif
  let delStatus=delete(theFile)
  if(delStatus == 0)
    echo "Deleted " . theFile
  else
    echohl WarningMsg
    echo "Failed to delete " . theFile
    echohl None
  endif
  return delStatus
endfunction
"delete the current file
com! Rm call DeleteFile()
"delete the file and quit the buffer (quits vim if this was the last file)
com! RM call DeleteFile() <Bar> q!

" Let's stay lazy !
" Force write the file using sudo permissions
command! Sudow w !sudo tee % > /dev/null
" Often type W instead of w
command! W w
" Ex is not Explore only anymore... - http://stackoverflow.com/questions/14367440/map-e-to-explore-in-command-mode
command! Ex Explore
" Why not just E for Explore
command! E Ex
" And just V for Vertical-Explore
command! V Vex

" Show/Hide special characters (can't remember the 'list' toggle)
command! ShowSpecialCharacters set list
command! HideSpecialCharacters set nolist

" Add syntax rule
let g:ruby_heredoc_syntax_filetypes = {
        \ "xml" : {
        \   "start" : "XML",
        \},
  \}
