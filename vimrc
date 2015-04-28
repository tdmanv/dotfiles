""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" => General 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Sets how many lines of history VIM has to remember set history=700 
" Enable filetype plugin filetype plugin on filetype indent on " Set to auto read when a file is changed from the outside set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :tabnew! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  set background=dark
  "colorscheme peaksea
  colorscheme zellner
  set nonu
else
  colorscheme zellner
  set background=dark
  set nonu
endif

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
"map <space> /
"map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. split windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> gt<cr>
map <left> gT<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab,newtab
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.java :call DeleteTrailingWS()
autocmd BufWrite *.sh :call DeleteTrailingWS()
autocmd BufWrite *.pp :call DeleteTrailingWS()
autocmd BufWrite *.rb :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
"autocmd FileType python set omnifunc=jedi#complete

au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def


""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
"let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc,*.class,*.html,*.xml
noremap <leader>j :CommandT<cr>
noremap <leader>y :CommandTFlush<cr>

"actually, lets use ctrlP
noremap <leader>j :CtrlP<cr>
"this means ctrlp won't change its directory
let g:ctrlp_working_path_mode = ''


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

vmap b :!git blame =expand("%:p")  \| sed -n =line("',=line("'>") p 

autocmd BufRead .git/COMMIT_EDITMSG setlocal spell
autocmd BufRead .git/COMMIT_EDITMSG set tw=70
map Y y$

map <f12> :!grep -nr <C-r>" ./*
map gf <C-w>gf
imap jj <Esc>jj
noremap <f9> :wa<cr>:make clean; make<cr>
nmap <leader>s :tab split<cr>
nmap <leader>x :%!xxd<cr>

set tabpagemax=50
"map <f1> ^yEIcout << "<ESC>pi: " << <ESC>pi << endl;

map <space> za
set foldnestmax=2
set expandtab


au FileType python set expandtab
au FileType python set shiftwidth=4
au FileType python set tabstop=4
au FileType python set foldmethod=manual
let python_version_2 = 1

au FileType cpp set foldmethod=syntax


au BufNewFile * silent! 0r /home/tdmanv/.vim/templates/%:e.tpl

au BufNewFile,BufRead *.r set filetype=r
au BufNewFile,BufRead *.R set filetype=r
au BufNewFile,BufRead *.tex set filetype=tex

au! BufNewFile,BufRead *.csv setf csv



"La Tex
"IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.

set grepprg=grep\ -nH\ $*


"set errorformat=%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-Gfrom %f:%l:%c,%-Gfrom %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\, line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory `%f',%X%*\a[%*\d]: Leaving directory `%f',%D%*\a: Entering directory `%f',%X%*\a: Leaving directory `%f',%DMaking %*\a in %f,%f|%l| %m
"set errorformat=%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-Gfrom %f:%l:%c,%-Gfrom %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\, line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory `%f',%X%*\a[%*\d]: Leaving directory `%f',%D%*\a: Entering directory `%f',%X%*\a: Leaving directory `%f',%DMaking %*\a in %f,%f|%l| %m

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""r
" => html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType html set tabstop=2
au FileType html set shiftwidth=2
au FileType javascript set tabstop=2
au FileType javascript set shiftwidth=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""r
" => ruby
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.pp set syntax=ruby
au FileType ruby set expandtab
au FileType ruby set shiftwidth=2
au FileType ruby set tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""r
" => java
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType java set expandtab
au FileType java set shiftwidth=4
au FileType java set tabstop=4
au FileType java set foldmethod=syntax

"let g:EclimCompletionMethod = 'omnifunc'

noremap <f8> :!bash -c -i mvn_check \| tee /tmp/mvn_check.txt<cr> :cf /tmp/mvn_check.txt<cr>
noremap <f7> :tabnew<cr>:!mvn compile \| tee /tmp/mvn_compile.txt<cr> :cf /tmp/mvn_compile.txt<cr>

set errorformat=[ERROR]\ %f:[%l\\,%v]\ %m
set errorformat+=[WARNING]\ %f:[%l\\,%v]\ %m
set errorformat+=%f:%l:%v:\ %m
set errorformat+=%f:%l:\ %m

autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')

autocmd FileType java set tags=~/.java-ctags

set complete=.,w,k
set dictionary=~/.vimKeywords

"let g:vjde_completion_key='<C-h>'
let g:vjde_ctags_exts='java'
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"

set number



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""r
" => vimgdb
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable					" enable syntax highlighting
set previewheight=12			" set gdb window initial height
run macros/gdb_mappings.vim		" source key mappings listed in this document
"set asm=0						" don't show any assembly stuff
"set gdbprg=/usr/bin/gdb



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!

"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'aperezdc/vim-template'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'godlygeek/tabular' 
Bundle 'vim-scripts/Vim-JDE'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/git-time-lapse'
Bundle 'vim-scripts/autoload_cscope.vim'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'salsifis/vim-transpose'


filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabular shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <leader>= Tabularize /^[^=]*/l0<CR>
vmap <leader>] Tabularize /^[^\[]*/l0<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Powerline setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline_theme = 'badwolf'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree / Taglist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> :NERDTreeToggle<CR>
map <F3> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

set cscopequickfix=g-,s-,c-,d-,i-,t-,e-
nmap <leader>cc lb"tye:cs f c <C-r>t<CR>
nmap <leader>cg lb"tye:cs f g <C-r>t<CR>
nmap <leader>cd lb"tye:cs f d <C-r>t<CR>
nmap <leader>ct lb"tye:cs f t <C-r>t<CR>
nmap <leader>a lb"tye:Ag <C-r>t<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => git-time-lapse
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gt :call TimeLapse() <cr> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.md set syntax=markdown
autocmd BufWrite *.md :call DeleteTrailingWS()

