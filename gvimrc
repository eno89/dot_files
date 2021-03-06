" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high
set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

	" I like highlighting strings inside C comments
	"  let c_comment_strings=1

	" Switch on syntax highlighting if it wasn't on yet.
	""  if !exists("syntax_on")
	""    syntax on
	""  endif

	" Switch on search pattern highlighting.
	"  set hlsearch

	" For Win32 version, have "K" lookup the keyword in a help file
	"if has("win32")
	"  let winhelpfile='windows.hlp'
	"  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
	"endif

	" Set nice colors
	" background for normal text is light grey
	" Text below the last line is darker grey
	" Cursor is green, Cyan when ":lmap" mappings are active
	" Constants are not underlined but have a slightly lighter background
	" ighlight Normal guibg=grey90
	""  highlight Cursor guibg=Green guifg=NONE
	""  highlight lCursor guibg=Cyan guifg=NONE
	""  highlight NonText guibg=grey80
	""  highlight Constant gui=NONE guibg=grey95
	""  highlight Special gui=NONE guibg=grey95

endif


" --------------- gvim と共通
" yank したテキストが無名レジスタだけでなく，*レジスタにも入るようにする
":set clipboard+=unnamed

" http://itcweb.cc.affrc.go.jp/affrit/faq/tips/vim-enc
" 文字コード/改行コードの自動判別
":set encoding=utf-8
":set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
":set fileformats=unix,dos,mac


" タブを表示するときの幅
"set tabstop=2
" タブを挿入するときの幅
"set shiftwidth=2

"set relativenumber
"
"========================================

"Hack #120: gVim でウィンドウの位置とサイズを記憶する
"http://vim-jp.org/vim-users-jp/2010/01/28/Hack-120.html
let g:save_window_file = expand('~/.vimwinpos')
function! g:SaveWinPos()
	let l:options = [
				\ 'set columns=' . &columns,
				\ 'set lines=' . &lines,
				\ 'winpos ' . getwinposx() . ' ' . getwinposy(),
				\ ]
	call writefile(l:options, g:save_window_file)
endfunction
augroup save_win_pos
	autocmd!
	autocmd VimLeavePre * call g:SaveWinPos()
augroup END

if filereadable(g:save_window_file)
	execute 'source' g:save_window_file
endif

" ウィンドウの位置を変える
command! -nargs=+ MoveWindow call <SID>MoveWindow(<f-args>)
command!          MoveLeft   call <SID>MoveWindow(0,0)
command!          MoveRight  call <SID>MoveWindow(975,0)
function! g:MoveWindow(x, y)
	winpos a:x a:y
endfunction
function! g:RectWindow(x, y, w, h)
	winpos a:x a:y
	set columns=a:w
	set lines=a:h
endfunction
"
command! -nargs=+ SizeWindow call <SID>size_window(<f-args>)
command! -nargs=+ SW         call <SID>size_window(<f-args>)
command! 					SizeMini   call <SID>size_window(35,130)
function! s:size_window(...)
	let &lines = a:1
	if a:0 == 2
" 		set columns=b
		let &columns = a:2
	endif
endfunction
function! g:SizeLong()
	set lines=999
endfunction

" ウィンドウの大きさを変える
"位置も変える
function! g:WindowMax()
	set columns=271
	set lines=81
	winpos 0 24
endfunction
function! g:WindowRightLong()
	set columns=130
	set lines=999
	winpos 975 0
endfunction
function! g:WindowLeftLong()
	set columns=130
	set lines=999
	winpos 0 0
endfunction
function! g:WindowSubDisplayMax()
	winpos 1920 24
	set columns=177
	set lines=999
endfunction

"-------------------------------------------------------------------------------
""ステータス行を表示
"set laststatus=2
""ステータス行の指定
"set statusline=%<%f\ %m%r%h%w
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
"set statusline+=%=%l/%L,%c%V%8P

" カラー設定
""colorscheme mydark
"colorscheme torte
"colorscheme hybrid
"au InsertEnter * hi StatusLine guifg=blue guibg=DarkYellow  gui=none ctermfg=Blue ctermbg=Yellow cterm=none
"au InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGrey cterm=none
"au ColorScheme * hi CusorLine ctermfg=43 guifg=#0088ff


" -------------------------------------------------------
" set guifont=Ricty\ 10
" set guifont=Ricty\ 10
"set transparency=220
