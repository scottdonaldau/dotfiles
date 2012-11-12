" configure vim pathogen
" http://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim
filetype on " solves pathogen exit status 1 bug - http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" assigning a leader key and mapping some commands to it
let mapleader = ","
map <leader>s :%s/\s\+$//e \| :%s/\t/  /e<CR><C-o>  " use ',s' to clean trailing spaces and remove tabs
map <leader>= <Esc>:1,$!xmllint --format -<CR>  " use ',=' to xml re-indent
nnoremap <leader>k :set invwrap wrap?<CR>  " use ',l' to toggle wordwrap
nnoremap <leader>d :NERDTreeToggle<CR>  " use ',d' to toggle the NERDTree
"let g:ackprg="ack -H --nocolor --nogroup --column -a --ignore-dir log --ignore-dir coverage --ignore-dir tmp --ignore-dir public/assets --ignore-dir public/images"
let g:ackprg="ack -a -H --nocolor --nogroup --column --ignore-dir log --ignore-dir tmp --ignore-dir public"
map <leader>F :Ack<space>
set pastetoggle=<leader>;

let s:uname = system("uname")
if s:uname == "Darwin\n"
  " Do Mac stuff here
  colorscheme railscasts
  nmap <leader>p :let @* = expand("%:p")<CR> " use ',p' to copy the current path to the system clipboard
else
  " Do Linux Specifc here (gvim)
  colorscheme vibrantink " at home(linux) I can't see shit with railscast theme...
  nmap <leader>p :!echo "%:p" \|xsel -ib<CR><CR>
endif

set ignorecase " we don't the case on the search
set smartcase " in fact we do care the case unless search is all lowercased

" notepad++ style bookmarks -- bookmarking extension
:map 22 :ToggleBookmark<CR>
:map <C-2> :NextBookmark<CR>
:map <C-@> :PreviousBookmark<CR>

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
set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files
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

" activate plugin for matchit (don't really know if it's a good idea to let that here though)
filetype plugin on

" some Lusty plugins specifics
nnoremap <leader>b :LustyBufferExplorer<CR>  " use ',b' instead of default ',lb' to access the buffers fuzzy finder plugin
nnoremap <leader>j :LustyJuggler<CR>  " use ',j' instead of default ',lj' to access the recent buffers juggler plugin
" activate a mode required by lustyExplorer plugin
:set hidden

" associate specific extensions with specific filetypes
au BufRead,BufNewFile *.rc set filetype=sh
au BufRead,BufNewFile *.hamlc,*.hamstache set ft=haml
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

" Delete file from current buffer
" from http://vim.wikia.com/wiki/Delete_files_with_a_Vim_command
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

"----

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif
" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction
" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call s:Bclose('<bang>', '<args>')
nnoremap <silent> <Leader>bd :Bclose<CR>

" ---

" get rid of all non visible but open buffers
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
 
