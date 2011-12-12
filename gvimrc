" gvimrc is used by gvim under Linux but also by mvim under Mac... pain!

set guioptions-=T " hide toolbar

let s:uname = system("uname")
if s:uname == "Darwin\n"

  " Do Mac stuff here

  set guifont=Monaco:h14

else

  " Do Linux Specifc here

  set guifont=Monospace\ 14

  " forcing terminal style Copy/Paste shortcuts to work the same
  map <S-C-x> "+x
  map <S-C-c> "+y
  map <S-C-v> "+gP
  imap <S-C-v> <Esc>"+gPa

endif

