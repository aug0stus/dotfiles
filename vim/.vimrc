if !exists('*InstallPlug') 
  function InstallPlug()
    if empty(filter(split(&rtp,','), 'filereadable(v:val."/autoload/plug.vim")'))
      let rtp = split(&rtp,',')
      let idx = confirm(
                        \ "Where do you want to install plug.vim ?", 
                        \ join(map( rtp, { idx, val -> nr2char(char2nr('a') + idx) . ". " . val } ) + ['Skip'], "\n" ), 
                        \ len(rtp) 
                        \ ) - 1 "confirm()'s return are indexed from 1.
      if idx != len(rtp)
        let plugfile = split(&rtp,',')[idx] . "/autoload/plug.vim"
        exec "!curl -fLo " . plugfile . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        execute 'source' plugfile
        source $MYVIMRC | PlugInstall --sync 
      endif
    endif
  endfunction
endif

autocmd VimEnter * call InstallPlug()

if !empty(filter(split(&rtp,','), 'filereadable(v:val."/autoload/plug.vim")'))
  call plug#begin()
    Plug 'junegunn/vim-plug'

    " workflow related
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    Plug 'kshenoy/vim-signature'
    Plug 'ptzz/lf.vim'
    Plug 'rbgrouleff/bclose.vim'

    " language support
    Plug 'PProvost/vim-ps1' " powershell
    Plug 'davidhalter/jedi-vim' " python
    Plug 'maxmellon/vim-jsx-pretty' " jsx
    Plug 'fatih/vim-go' " go
    Plug 'dense-analysis/ale'


    " theme-related plugins
    Plug 'itchyny/lightline.vim'
    Plug 'srcery-colors/srcery-vim'
  call plug#end()
endif

" theme configuration
try
  colorscheme srcery
  let g:lightline = { 'colorscheme': 'srcery' }
catch
  echom "some of the theme plugins failed to load."
endtry

" configure UI
set laststatus=2 " always display the status line

" configure GUI options
set guioptions=e " only interested in tabs.

" enhanced command-line completion
set wildmenu
set wildmode=longest:full

" configure editing environment
set number
set relativenumber
set ignorecase

set expandtab
set tabstop=2
set shiftwidth=2

"" override plugin overrides
"autocmd filetype python setlocal shiftwidth=2 tabstop=2 expandtab list listchars=space:-,eol:$
autocmd filetype python setlocal list listchars=space:-,eol:$

set hlsearch

syntax enable

autocmd BufNewFile,BufRead * setlocal formatoptions-=cro " disables automatic inserts of comments on newlines

set backspace=indent,eol,start " allows backspacing through vim's autoindent

" configure editing workflow
set splitbelow
set splitright

" overloading plugins
"" fzf
if filereadable("C:\\Program Files\\Git\\cmd\\git.exe")
  let $PATH .= ";C:\\\Program Files\\Git\\bin;"
endif

"" jedi-vim
let g:jedi#show_call_signatures = 0
let g:jedi#completions_enabled = 1


" configure utilities
if filereadable("C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")
  set shell=C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe
  if has('nvim')
    set shell=powershell shellquote=( shellpipe=\| shellxquote=
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
  endif
endif

" OS specifics

if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        set termguicolors
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

"configure backup, swap and undo files.
"set backupdir=~/.vim/.backup//
"set directory=~/.vim/.swp//
"set undodir=~/.vim/.undo//
