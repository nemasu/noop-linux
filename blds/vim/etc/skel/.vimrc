set smarttab
set tabstop=4
set shiftwidth=4
colorscheme lucius
syntax on
set pastetoggle=<F2>
set fileformat=unix
set backspace=indent,eol,start
set autoindent
set cindent
set foldmethod=syntax
if &term =~ "xterm"
 set t_Co=256
 if has("terminfo")
   let &t_Sf=nr2char(27).'[3%p1%dm'
   let &t_Sb=nr2char(27).'[4%p1%dm'
 else
   let &t_Sf=nr2char(27).'[3%dm'
   let &t_Sb=nr2char(27).'[4%dm'
 endif
endif
