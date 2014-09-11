nnoremap <silent> <F2> :A<CR>
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>
"map <F4> :silent! Tlist<CR>
nmap <F4> :TagbarToggle<CR>
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F12> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>

map <F5> :call CompileRun()<CR>
map <C-F5> :call Debug()<CR>

map <F6> :call Run()<CR>

map <C-F7> :make clean<CR><CR><CR>
map <F7> :make<CR><CR><CR> :copen<CR><CR> 
map <F8> :cp<CR> "光标移到上一个错误所在的行
map <F9> :cn<CR> "光标移到下一个错误所在的行

imap <C-F7> <ESC>:make clean<CR><CR><CR>
imap <F7> <ESC>:make<CR><CR><CR> :copen<CR><CR>
imap <F8> <ESC>:cp<CR>
imap <F9> <ESC>:cn<CR>

nmap cS :%s/\s\+$//g<CR>:noh<CR>
 
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

set term=screen
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'molokai'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'taglist.vim'
Bundle 'minibufexpl.vim'
Bundle 'OmniCppComplete'
Bundle 'echofunc.vim'
Bundle 'SuperTab'
Bundle 'a.vim'
Bundle 'The-NERD-tree'
Bundle 'STL-improved'
Bundle 'scrooloose/syntastic'
Bundle 'AutoComplPop'
Bundle 'majutsushi/tagbar'
Bundle 'std_c.zip'
Bundle 'cSyntaxAfter'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'Yggdroot/indentLine'

au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()

"let g:Powline_symbols='fancy'
set cc=80
filetype plugin indent on

syntax enable
syntax on
colorscheme molokai

let NERDTreeHighlightCursorline=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=28
let NERDChristmasTree=1
"let NERDTreeAutoCenter=1
let NERDTreeMouseMode=3
"let NERDTreeMapToggleZoom='<Space>'

" -----------------------------------------------------------------------------
"  "  < ctrlp.vim 插件配置 >
"  "
"  -----------------------------------------------------------------------------
"  " 一个全路径模糊文件，缓冲区，最近最多使用，... 检索插件；详细帮助见 :h
"  ctrlp
"  " 常规模式下输入：Ctrl + p 调用插件


" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" " <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" " <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" " <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" " <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" " <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" " <Leader>cA 行尾注释
let NERDSpaceDelims=1
" "在左注释符之后，右注释符之前留有空格
"  
"  "
"  -----------------------------------------------------------------------------

let c_cpp_comments=0

"let Tlist_Auto_Update = 1
"let Tlist_Use_Right_Window=1
"let Tlist_File_Fold_Auto_Close=1
"let Tlist_Process_File_Always=0
"let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1

let g:miniBUfExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplUseSingleClick=1
let g:miniBufExplorerMoreThanOne=0
"
nmap <Leader>tb :TagbarToggle<CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=35
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

set tags=tags
"set tags=/usr/include/tags
set tags+=~/.vim/cpptags
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"let OmniCpp_SelectFirstItem = 1
"let OmniCpp_LocalSearchDecl = 1 
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif " 自动关闭补全窗口
set completeopt=menuone,menu  ",longest


func! CompileRun()
	exec "w"
	if &filetype == 'c'
		exec "w"
		exec "!gcc % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "w"
		exec "!g++ % -o %<"
		exec "! ./%<"
	endif
endfunc


func Debug()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -g -o %<"
		exec "!gdb %<"
	elseif &filetype == 'cpp'
		exec "!g++ % -g -o %<"
		exec "!gdb %<"
	endif
endfunc


func Run()
	if &filetype == 'c' || &filetype == 'cpp'
		exec "!%<"
	endif
endfunc


set t_Co=256
set nobackup
set nocompatible
set smarttab
set noswapfile
set cursorline
set magic
set expandtab
set ignorecase
set smartcase
set autowrite
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set showmatch
set mouse=a
set number
set ruler

set incsearch
set hlsearch


autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
let g:syntastic_error_symbol = 'x'
let g:syntastic_warning_symbol = 'w'
let g:syntastic_enable_balloons = 1


if has("gui")
    set guioptions-=T
	set guifont=Monaco\ 9
	let g:indentLine_color_term = 239
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif


if has("cscope")
    "设定可以使用 quickfix 窗口来查看 cscope 结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0
    "在当前目录中添加任何数据库
    if filereadable("cscope.out")
        cs add cscope.out
    "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "快捷键设置
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
 
 nmap <leader>il :IndentLinesToggle<CR>" 开启/关闭对齐线
 

" 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色

