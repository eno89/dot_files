
"vim700: set tw=110 ts=2 ft=vim noet fdc=1: " modeline
scriptencoding utf-8
" vim: foldmethod=marker
" 前置き "{{{1
"-------------------------------------------------------------------------------
" OS : Ubuntu 12.04
" kbd : HHKB (英字)
" Vim : 7.4.347
"  ./configure --with-features=huge --enable-gui=gnome2 --enable-perlinterp
"  --enable-pythoninterp  --enable-python3interp --enable-rubyinterp
"  --enable-luainterp  --with-luajit --enable-fail-if-missing
" OS : Windows 8.1
" kbd : ThinkPad x1 carbon (英語)
" Vim : KaoriYa vim x64
"-------------------------------------------------------------------------------
" 参考
" Vim の構築
"  vimにluajitを対応させてみた作業ログ LN_0x000
" VimでC++
"  Vim で C++ を書くときの逆引きリファレンス LN_0x001
"  Vim で C++ のコーディングを行うAdd Starfa11enprince LN_0x002
" 実践Vim メモ
"  Pragmatic Bookshelf LN_0x003
"-------------------------------------------------------------------------------
" .vimrc で書きたいこと
"   環境が正しいかチェック
"     git のインストールがあるか
"     NeoBundle がインストールされていなかったらインストールする
"   C++ の設定
"   Python の設定
"   Windows との共用
"-------------------------------------------------------------------------------
" .vimrc の書き順について
"   " コメントは主に上に書く
"	" 最小限の初期化
"	Init
"	" Git,Neobundle での管理
"	Check
" 	" プラグインの設定、主にNeoBundle
" 	Plugin
" 	" 整理前
" 	Tmp
" 	" 自作スクリプトなど
"   Script
" 	"
" 	Mapping
"   " 短縮コマンド
"   Abbreviate
" 	" Init 以外の設定
" 	Setting
" 	" GUI/Terminal の色設定 /olorschemeの設定は早めに
" 	r../c
" 	Color
" 	" 各拡張子に対する設定
" 	Syntax
" 	" 練習用
" 	Test
" 	" 以下はコメントのみ
" 	Tips
" 	Link
" 	Todo
" }}}

" Init {{{1
"スクリプト内で日本語を使う場合 LN_0x006
"}}}

" Check {{{1
" 一度だけ読まれる設定
if has('vim_starting')
		if !executable("git")
				echo "Please install git." . " Reboot Vim."
				finish
		endif
endif

" $VIMFILES 内にvimrcを置く
if has('unix')
		let $VIMFILES=expand('~/.vim')
elseif (has('win32') || has('win32'))
		let $VIMFILES=expand('~/vimfiles')
else
		echo "not 'unix','windows' "
		" 	finish
endif
"
let $BUNDLE = $VIMFILES . '/bundle'
let $MY_VIMPERATORRC = $HOME . '/.vimperatorrc'
let s:neobundle_plugins_dir = $VIMFILES . '/bundle'

let s:my_script_test_dir = $VIMFILES . '/test_script'
let $MT = s:my_script_test_dir

" プラグインの読み込み

" NeoBundle が存在するか
if ! isdirectory(s:neobundle_plugins_dir . '/neobundle.vim')
		echo "Please install neobundle.vim."
		echo  s:neobundle_plugins_dir . '/neobundle.vim'
		" NeoBundle のインストール
		function! s:install_neobundle()
				if input('Install neobundle.vim? [Y/N] : ') == 'Y'
						if isdirectory(s:neobundle_plugins_dir) == 1
								:all mkdir(s:neobundle_plugins_dir, 'p')
						endif
						execute '!git clone git://github.com/Shougo/neobundle.vim '
												\ . s:neobundle_plugins_dir . '/neobundle.vim'
						echo 'neobundle installed. Please restart vim.'
				else
						echo 'Canceled.'
				endif
		endfunction
		augroup install-neobundle
				autocmd!
				autocmd VimEnter * call s:install_neobundle()
		augroup END
		finish
endif
" }}}

" Kaoriya {{{1
if (has('win32') || has('win32'))
		" An example for a Japanese version vimrc file.
		" 日本語版のデフォルト設定ファイル(vimrc) - Vim7用試作
		"
		" Last Change: 19-Dec-2014.
		" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
		"
		" 解説:
		" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
		" かれています。GUIに関する設定はgvimrcに書かかれています。
		"
		" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
		" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
		" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
		" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
		"
		" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
		" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
		" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
		" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
		"
		" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
		" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
		" たい場合に利用して下さい。
		"
		" 参考:
		"   :help vimrc
		"   :echo $HOME
		"   :echo $VIM
		"   :version

		"---------------------------------------------------------------------------
		" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
		" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
		" ファイルの読込を中止する。
		if 1 && filereadable($VIM . '/vimrc_local.vim')
				unlet! g:vimrc_local_finish
				source $VIM/vimrc_local.vim
				if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
						finish
				endif
		endif

		"---------------------------------------------------------------------------
		" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
		" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
		" イルの読込を中止する。
		if 1 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
				unlet! g:vimrc_first_finish
				source $HOME/.vimrc_first.vim
				if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
						finish
				endif
		endif

		" plugins下のディレクトリをruntimepathへ追加する。
		for s:path in split(glob($VIM.'/plugins/*'), '\n')
				if s:path !~# '\~$' && isdirectory(s:path)
						let &runtimepath = &runtimepath.','.s:path
				end
		endfor
		unlet s:path

		"---------------------------------------------------------------------------
		" 日本語対応のための設定:
		"
		" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
		" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
		" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
		source $VIM/plugins/kaoriya/encode_japan.vim
		" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
		if !(has('win32') || has('mac')) && has('multi_lang')
				if !exists('$LANG') || $LANG.'X' ==# 'X'
						if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
								language ctype ja_JP.eucJP
						endif
						if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
								language messages ja_JP.eucJP
						endif
				endif
		endif
		" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
		if has('mac')
				set langmenu=japanese
		endif
		" 日本語入力用のkeymapの設定例 (コメントアウト)
		if has('keymap')
				" ローマ字仮名のkeymap
				"silent! set keymap=japanese
				"set iminsert=0 imsearch=0
		endif
		" 非GUI日本語コンソールを使っている場合の設定
		if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
				set termencoding=cp932
		endif

		"---------------------------------------------------------------------------
		" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
		if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
				set guioptions+=M
		endif

		"---------------------------------------------------------------------------
		" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
		" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
		let g:no_vimrc_example = 1
		if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
				if &guioptions !~# 'M'
						" vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
						" やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
						" とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
						" まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
						" 化けてしまう。
						set guioptions+=M
						source $VIMRUNTIME/vimrc_example.vim
						set guioptions-=M
				else
						source $VIMRUNTIME/vimrc_example.vim
				endif
		endif

		"" "---------------------------------------------------------------------------
		"" " 検索の挙動に関する設定:
		"" "
		"" " 検索時に大文字小文字を無視 (noignorecase:無視しない)
		"" set ignorecase
		"" " 大文字小文字の両方が含まれている場合は大文字小文字を区別
		"" set smartcase
		""
		"" "---------------------------------------------------------------------------
		"" " 編集に関する設定:
		"" "
		"" " タブの画面上での幅
		"" set tabstop=8
		"" " タブをスペースに展開しない (expandtab:展開する)
		"" set noexpandtab
		"" " 自動的にインデントする (noautoindent:インデントしない)
		"" set autoindent
		"" " バックスペースでインデントや改行を削除できるようにする
		"" set backspace=indent,eol,start
		"" " 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
		"" set wrapscan
		"" " 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
		"" set showmatch
		"" " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
		"" set wildmenu
		"" " テキスト挿入中の自動折り返しを日本語に対応させる
		"" set formatoptions+=mM
		""
		"" "---------------------------------------------------------------------------
		"" " GUI固有ではない画面表示の設定:
		"" "
		"" " 行番号を非表示 (number:表示)
		"" set nonumber
		"" " ルーラーを表示 (noruler:非表示)
		"" set ruler
		"" " タブや改行を表示 (list:表示)
		"" set nolist
		"" " どの文字でタブや改行を表示するかを設定
		"" "set listchars=tab:>-,extends:<,trail:-,eol:<
		"" " 長い行を折り返して表示 (nowrap:折り返さない)
		"" set wrap
		"" " 常にステータス行を表示 (詳細は:he laststatus)
		"" set laststatus=2
		"" " コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
		"" set cmdheight=2
		"" " コマンドをステータス行に表示
		"" set showcmd
		"" " タイトルを表示
		"" set title
		"" " 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
		"" "colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)
		""
		"" set statusline+=%=
		"" set statusline+=%y%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}

		"---------------------------------------------------------------------------
		" ファイル操作に関する設定:
		"
		" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
		"set nobackup


		"---------------------------------------------------------------------------
		" ファイル名に大文字小文字の区別がないシステム用の設定:
		"   (例: DOS/Windows/MacOS)
		"
		if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
				" tagsファイルの重複防止
				set tags=./tags,tags
		endif

		"---------------------------------------------------------------------------
		" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
		if has('unix') && !has('gui_running')
				let s:uname = system('uname')
				if s:uname =~? 'linux'
						set term=builtin_linux
				elseif s:uname =~? 'freebsd'
						set term=builtin_cons25
				elseif s:uname =~? 'Darwin'
						set term=beos-ansi
				else
						set term=builtin_xterm
				endif
				unlet s:uname
		endif

		"---------------------------------------------------------------------------
		" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
		if !has('gui_running') && has('xterm_clipboard')
				set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
		endif

		"---------------------------------------------------------------------------
		" プラットホーム依存の特別な設定

		" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
		if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
				let $PATH = $VIM . ';' . $PATH
		endif

		if has('mac')
				" Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
				set iskeyword=@,48-57,_,128-167,224-235
		endif

		"---------------------------------------------------------------------------
		" KaoriYaでバンドルしているプラグインのための設定

		" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
		set formatexpr=autofmt#japanese#formatexpr()

		" vimdoc-ja: 日本語ヘルプを無効化する.
		if kaoriya#switch#enabled('disable-vimdoc-ja')
				let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
		endif

		" vimproc: 同梱のvimprocを無効化する
		if kaoriya#switch#enabled('disable-vimproc')
				let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
		endif

		" Copyright (C) 2009-2013 KaoriYa/MURAOKA Taro

		" ==============================================================================================
endif

" if has('vim_starting')
"   let s:neobundle_plugins_dir =  '~/vimfiles/bundle'
"   execute "set runtimepath+=" . s:neobundle_plugins_dir . "/neobundle.vim"
" endif
"
" call neobundle#begin(s:neobundle_plugins_dir)
" NeoBundleFetch 'Shougo/neobundle.vim'
"
" NeoBundle 'rbtnn/game_engine.vim'
" NeoBundle 'rbtnn/mario.vim'
" NeoBundle 'rbtnn/puyo.vim'
"
" NeoBundle 'glidenote/memolist.vim'
" " cmd /c "mklink /d memo .\Dropbox\work\memo"
" "let g:memolist_path = '~/Dropbox/work/memo'
"
" NeoBundle "Shougo/unite.vim"
" " アウトラインの出力
" NeoBundle "Shougo/unite-outline"
" " 最近使ったファイル  most recursive use
" NeoBundle "Shougo/neomru.vim"
" "
" NeoBundle "Shougo/vimshell.vim"
" " MP_VIMSHELL
" NeoBundle "Shougo/vimfiler.vim"
" let g:vimfiler_as_default_explorer = 1
" "
"
" NeoBundle 'vim-jp/vital.vim'
"
" call neobundle#end()
" NeoBundleCheck
"
" set runtimepath+=$HOME/vimfiles/test
" func! s:func_copy_cmd_output(cmd)
" 	redir @">
" 	silent execute a:cmd
" 	redir END
" endfunc
" command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)
"
" set number
"
" vnoremap [prefix] <Nop>
" vmap     <Space> [prefix]
" nnoremap [prefix] <Nop>
" nmap     <Space> [prefix]
" nnoremap [prefix].r :<C-u>w<CR>:source %<CR>
" nnoremap [prefix].. :<C-u>tabedit $MYVIMRC<CR>:lcd ~<CR>
"
" syntax on

" }}}

" Plugin {{{1
" {
execute 'set runtimepath+=' . s:neobundle_plugins_dir . '/neobundle.vim'
" NeoBundle の初期化
call neobundle#begin(s:neobundle_plugins_dir)
"neobundle.vim 自体を管理する
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleLazy 'Shougo/neosnippet.vim', {
						\ 'depends': ['honza/vim-snippets'],
						\ 'autoload': {
						\   'insert': 1,
						\ }}
let s:hooks = neobundle#get_hooks('neosnippet.vim')
function! s:hooks.on_source(bundle)
		" Plugin key-mappings.
		imap [prefix]<C-k>     <Plug>(neosnippet_expand_or_jump)
		smap [prefix]<C-k>     <Plug>(neosnippet_expand_or_jump)
		xmap [prefix]<C-k>     <Plug>(neosnippet_expand_target)
		" SuperTab like snippets behavior.
		imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
								\ "\<Plug>(neosnippet_expand_or_jump)"
								\: pumvisible() ? "\<C-n>" : "\<TAB>"
		smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
								\ "\<Plug>(neosnippet_expand_or_jump)"
								\: "\<TAB>"
		" For snippet_complete marker.
		if has('conceal')
				set conceallevel=2 concealcursor=i
		endif
		" Enable snipMate compatibility feature.
		let g:neosnippet#enable_snipmate_compatibility = 1
		" Tell Neosnippet about the other snippets
		"
		let g:neosnippet#snippets_directory = s:neobundle_plugins_dir . '/vim-snippets/snippets'
endfunction
NeoBundle 'Shougo/neosnippet-snippets'

if has('unix')
		"日本語ヘルプ
		NeoBundle 'vim-jp/vimdoc-ja'
		"
		NeoBundle "Shougo/vimproc"
		NeoBundle 'Shougo/vimproc.vim', {
		\ 'build' : {
		\     'windows' : 'tools\\update-dll-mingw',
		\     'cygwin' : 'make -f make_cygwin.mak',
		\     'mac' : 'make -f make_mac.mak',
		\     'linux' : 'make',
		\     'unix' : 'gmake',
		\    },
		\ }
		" 汎用的なコード補完プラグイン
		NeoBundle "Shougo/neocomplete.vim"

		" 日本語IME
		" Vim/GVimで「日本語入力固定モード」を使用する LN_0x008
		NeoBundle 'fuenor/im_control.vim'
endif
"
" unite.vim MP_UNITE
NeoBundle "Shougo/unite.vim"
" アウトラインの出力
NeoBundle "Shougo/unite-outline"
NeoBundle "Shougo/unite-build"
NeoBundle "Shougo/echodoc.vim"

NeoBundle 'ujihsa/unite-colorscheme'

" 最近使ったファイル  most recursive use
NeoBundle "Shougo/neomru.vim"
"
NeoBundle "Shougo/vimshell.vim"
" MP_VIMSHELL

" http://www.vim.org/scripts/script.php?script_id=39
" http://nanasi.jp/articles/vim/matchit_vim.html
" NeoBundle "matchit"
" http://tech.toshiya240.com/articles/2014/06/matchit-vim/
source $VIMRUNTIME/macros/matchit.vim
" let b:match_words="begin:end"
" let b:match_words=\<fu\%[nction]\>:\<retu\%[rn]\>:\<endf\%[unction]\>,\<\(wh\%[ile]\|for\)\>:\<brea\%[k]\>:\<con\%[tinue]\>:\<end\(w\%[hile]\|fo\%[r]\)\>,\<if\>:\<el\%[seif]\>:\<en\%[dif]\>,\<try\>:\<cat\%[ch]\>:\<fina\%[lly]\>:\<endt\%[ry]\>,\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,(:)
augroup matchit
  au!
  au FileType tex let b:match_words = "begin:end"
  au FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END

" http://d.hatena.ne.jp/vimtaku/20121226/1356500063
NeoBundle 'vimtaku/hl_matchit.vim.git'
"" for hl_matchit
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'html,vim,sh,ruby'

NeoBundle "Shougo/vimfiler.vim"
let g:vimfiler_as_default_explorer = 1
"
"テキスト整形
NeoBundle 'h1mesuke/vim-alignta'
" Align -r .=  " +=,= などが混ざってる場合
"
NeoBundle 'vim-jp/vital.vim'

"
"Vimの便利な画面分割＆タブページと、それを更に便利にする方法 LN_0x007
NeoBundle 'kana/vim-submode'
" あなたの Vim は もっと Smart に Input できる http://ac-mopp.blogspot.jp/2013/07/vim-smart-input.html
" NeoBundleLazy 'kana/vim-smartchr',  { 'autoload' : {'insert' : '1'} }
" NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : {'insert' : '1'} }
" Smartinput
" let s:bundle = neobundle#get('vim-smartinput')
" function! s:bundle.hooks.on_source(bundle)
" 		call smartinput#clear_rules()
" endfunction
" " augroup cpp-smartinput
" "     autocmd!
" "     autocmd FileType cpp call  <SID>set_smartinput()
" " augroup END
" augroup cpp-smartinput
" 		autocmd!
" 		autocmd BufEnter * call smartinput#clear_rules()
" 		autocmd BufEnter *.cpp,*.hpp,*.h call <SID>set_smartinput()
" 		"     autocmd BufEnter * call <SID>set_smartinput()
" 		"     autocmd FileType cpp call  <SID>set_smartinput()
" 		"   "autocmd! BufEnter *.c,*.cc,*.cxx,*.cpp,*.h,*.hh,*.java,*.py,*.sh,*.rb,*.html,*.css,*.js :Rooter
" augroup END
"
" function! s:set_smartinput()
" 		"     call smartinput#map_to_trigger('i', '%', '%', '%')
" 		"     call smartinput#define_rule({
" 		"                 \ 'at'    : '\%([^''"][\sA-Za-z]\*\|^\|%\)\%#',
" 		"                 \ 'char'  : '%',
" 		"                 \ 'input' : "<C-R>=smartchr#one_of(' % ', '%')<CR>",
" 		"                 \ })
" 		let lst = [   ['<',     "smartchr#loop(' < ', ' << ', '<')" ],
" 								\ ['>',     "smartchr#loop(' > ', ' >> ', ' >>> ', '>')"],
" 								\ ['+',     "smartchr#loop(' + ', ' ++ ', '+')"],
" 								\ ['-',     "smartchr#loop(' - ', ' -- ', '-')"],
" 								\ ['/',     "smartchr#loop(' / ', '//', '/')"],
" 								\ ['&',     "smartchr#loop(' & ', ' && ', '&')"],
" 								\ ['%',     "smartchr#loop(' % ', '%')"],
" 								\ ['*',     "smartchr#loop(' * ', '*')"],
" 								\ ['<Bar>', "smartchr#loop(' | ', ' || ', '|')"],
" 								\ [',',     "smartchr#loop(', ', ',')"]]
"
" 		for i in lst
" 				call smartinput#map_to_trigger('i', i[0], i[0], i[0])
" 				call smartinput#define_rule({ 'char' : i[0], 'at' : '\%#',                                      'input' : '<C-R>=' . i[1] . '<CR>'})
" 				call smartinput#define_rule({'char' : i[0], 'at' : '^\([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',          'input' : i[0]})
" 				call smartinput#define_rule({ 'char' : i[0], 'at' : '^\([^'']*''[^'']*''\)*[^'']*''[^'']*\%#',  'input' : i[0] })
" 		endfor
"
" 		call smartinput#define_rule({'char' : '>', 'at' : ' < \%#', 'input' : '<BS><BS><BS><><Left>'})
"
" 		call smartinput#map_to_trigger('i', '=', '=', '=')
" 		call smartinput#define_rule({ 'char' : '=', 'at' : '\%#',                                       'input' : "<C-R>=smartchr#loop(' = ', ' == ', '=')<CR>"})
" 		call smartinput#define_rule({ 'char' : '=', 'at' : '[&+-/<>|] \%#',                             'input' : '<BS>= '})
" 		call smartinput#define_rule({ 'char' : '=', 'at' : '!\%#',                                      'input' : '= '})
" 		call smartinput#define_rule({ 'char' : '=', 'at' : '^\([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',          'input' : '='})
" 		call smartinput#define_rule({ 'char' : '=', 'at' : '^\([^'']*''[^'']*''\)*[^'']*''[^'']*\%#',   'input' : '='})
"
" 		call smartinput#map_to_trigger('i', '<BS>', '<BS>', '<BS>')
" 		call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '(\s*)\%#'   , 'input' : '<C-O>dF(<BS>'})
" 		call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '{\s*}\%#'   , 'input' : '<C-O>dF{<BS>'})
" 		call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '<\s*>\%#'   , 'input' : '<C-O>dF<<BS>'})
" 		call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '\[\s*\]\%#' , 'input' : '<C-O>dF[<BS>'})
"
" 		for op in ['<', '>', '+', '-', '/', '&', '%', '\*', '|']
" 				call smartinput#define_rule({ 'char' : '<BS>' , 'at' : ' ' . op . ' \%#' , 'input' : '<BS><BS><BS>'})
" 		endfor
" endfunction
" unlet s:bundle
" Smartchr
" let s:bundle = neobundle#get('vim-smartchr')
" function! s:bundle.hooks.on_source(bundle)
" endfunction
" unlet s:bundle

" http://d.hatena.ne.jp/osyo-manga/20130717/1374069987
NeoBundle 'kana/vim-textobj-user'
" e
NeoBundle 'kana/vim-textobj-entire'
" l
NeoBundle 'kana/vim-textobj-line'
" ,w
NeoBundle 'h1mesuke/textobj-wiw'
" c
NeoBundle 'mattn/vim-textobj-cell'

" http://d.hatena.ne.jp/thinca/20140324/1395590910
" NeoBundle
" gfを拡張
NeoBundle 'kana/vim-gf-user'
" gf for git diff
NeoBundle 'kana/vim-gf-diff.git'

" " もうすこし
" " tags:30
" "foo.c:23"
" " kana/vim-gf-diff.git
" " ~/.vim/bundle/vim-gf-diff.git
" ~/.vim/bundle/vim-gf-diff
" vim-gf-diff
" " a.\{-\}s "最短マッチ
" " asasasas
" function! GfFile()
"   let path = expand('<cfile>')
" 	if path =~# '.*\/.*'
" 		if path =~# '\.git$'
" 			let path = matchstr(path, '\/\zs.*\ze.git')
" 		else
" 			let path = matchstr(path, '\/\zs.*')
" 		endif
" 	endif
" 	set path+=$BUNDLE
" "   let path = findfile(path, getcwd() . ';')  " 追加
"   if !filereadable(path)
" 		echo path
"     return 0
"   endif
" 	echo path
"   return {
"   \   'path': path,
"   \   'line': line,
"   \   'col': 0,
"   \ }
" endfunction

function! GfFile()
  let path = expand('<cfile>')
  let line = 0
  if path =~# ':\d\+:\?$'
    let line = matchstr(path, '\d\+:\?$')
    let path = matchstr(path, '.*\ze:\d\+:\?$')
  endif
  let path = findfile(path, getcwd() . ';')  " 追加
  if !filereadable(path)
    return 0
  endif
  return {
  \   'path': path,
  \   'line': line,
  \   'col': 0,
  \ }
endfunction
" call gf#user#extend('GfFile', 1000)

" 色設定 LN_0x009
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'deris/vim-wombat'

NeoBundle 'gorodinskiy/vim-coloresque'

" http://www.mk-mode.com/octopress/2014/02/10/vim-installation-of-indent-plugin/
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
" 奇数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
" 偶数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
" ガイドの幅
let g:indent_guides_guide_size = 1

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'vim-jp/autofmt'

" Yank LN_0x00a
" <C-p> or <C-n> で古/新に入れ替える
" yf の動作
" NeoBundle 'vim-scripts/YankRing.vim'
" 新型スカウターを開発した LN_0x00b
NeoBundle 'thinca/vim-scouter'
" メモツール "MP_MEMO
NeoBundle 'glidenote/memolist.vim'
" MarkDown
NeoBundleLazy 'kannokanno/previm' , { 'autoload' : { 'filetypes' : 'markdown' } }
augroup previm-settings
		autocmd!
		autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"カーソル行のURLをブラウザで開く LN_0x00c {
NeoBundle 'tyru/open-browser.vim'
function! s:HandleURI()
		let uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
		echo uri
		if uri != ""
				"exec "!open \"" . uri . "\""
				exec "OpenBrowser \"" . uri . "\""
		else
				echo "No URI found in line."
		endif
endfunction
" MP_OpenBrowser
" }
NeoBundle "mattn/webapi-vim"
" Unite
" C++ 仕様書
NeoBundle "rhysd/unite-n3337"
" キャッシュ消したら，上手く動いた
" let g:unite_n3337_pdf = $HOME . "/.vim/pdf/n3337.pdf"
let g:unite_n3337_pdf = $VIMFILES . "/pdf/n3337.pdf"
" MP_N3337
NeoBundle "ujihisa/unite-locate"
NeoBundle "osyo-manga/unite-quickfix"
NeoBundle "tsukkee/unite-tag"
NeoBundle "tsukkee/unite-help"
NeoBundle "mattn/unite-mcdonalds-vim"
NeoBundle "mattn/unite-rhythmbox"
" http://www.karakaram.com/ref-webdict
NeoBundle "thinca/vim-ref"
"webdictサイトの設定
let g:ref_source_webdict_sites = {
	\ 'je'  : { 'url': 'http://dictionary.infoseek.ne.jp/jeword/%s', },
	\ 'ej'  : { 'url': 'http://dictionary.infoseek.ne.jp/ejword/%s', },
	\ 'wiki': { 'url': 'http://ja.wikipedia.org/wiki/%s', },
	\ }
"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'
"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>
"webdictサイトの設定

NeoBundleLazy "thinca/vim-quickrun", { "autoload": {
																\ "mappings": [['nxo','<Plug>(quickrun)']] }}
" nmap <C-R> <Plug>(quickrun)
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
	let g:quickrun_config = { "_":{"runner": "remote/vimproc", 'split': ''},}
endfunction

" NeoBundleLazy "lambdalisue/shareboard.vim", {
"       \ "autoload": { "commands": ["ShareboardPreview", "ShareboardCompile"], },
"       \ "build": {   "mac": "pip install shareboard",  "unix": "pip install shareboard", }}
" function! s:shareboard_settings()
"   nnoremap <buffer>[shareboard] <Nop>
"   nmap <buffer><Leader> [shareboard]
"   nnoremap <buffer><silent> [shareboard]v :ShareboardPreview<CR>
"   nnoremap <buffer><silent> [shareboard]c :ShareboardCompile<CR>
" endfunction
" augroup MyAutoCmd
" 	autocmd!
" 	autocmd FileType rst,text,pandoc,markdown,textile call s:shareboard_settings()
" augroup END
" let s:hooks = neobundle#get_hooks("shareboard.vim")
" function! s:hooks.on_source(bundle)
"   " VimからPandocが見えないことが多々あるので念の為~/.cabal/binをPATHに追加
"   let $PATH=expand("~/.cabal/bin:") . $PATH
" endfunction

" 翻訳
" http://www.absolute-keitarou.net/blog/?p=1239
NeoBundle "mattn/excitetranslate-vim"
" http://daisuzu.hatenablog.com/entry/2013/12/22/153834
NeoBundle "daisuzu/translategoogle.vim"
" コメント切り替え MP_CAW
NeoBundle "tyru/caw.vim"
NeoBundle "tyru/Capture.vim"
" Doxygen 生成 DoxXXX
NeoBundle "vim-scripts/DoxygenToolkit.vim"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"

" NeoBundle "VOoM"
" NeoBundle "rbtnn/vimconsole.vim"
" NeoBundle "itchyny/calendar.vim"

" http://kainokikaede.hatenablog.com/entry/2013/12/28/165213
NeoBundle "chrisbra/Recover.vim"
" let g:RecoverPlugin_Edit_Unmodified = 1

" 移動
" Vim-EasyMotionでカーソル移動を爆速にして生産性をもっと向上させる LN_0x00d
NeoBundle 'Lokaltog/vim-easymotion'
" リーダーキーから変更する
let g:EasyMotion_leader_key="`"
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbASDFGHJKL;'
"
NeoBundle 'rhysd/clever-f.vim'
let g:clever_f_use_migemo = 1
let g:clever_f_fix_key = 1

" C++ シンタックス
NeoBundleLazy "vim-jp/cpp-vim" , { 'autoload' : { 'filetypes' : 'cpp' } }
" clang setting {
NeoBundleLazy 'Rip-Rip/clang_complete', {
						\ 'autoload' : {'filetypes' : ['c', 'cpp']}
						\ }
"let g:clang_periodic_quickfix = 1
let g:clang_periodic_quickfix = 0
let g:clang_complete_copen = 1
"let g:clang_use_library = 1
" this need to be updated on llvm update
" libclang.so とかがあるフォルダのパス
let g:clang_library_path = '/usr/lib/llvm-3.4/lib'
" specify compiler options
"let g:clang_user_options = '-std=c++11 -stdlib=libc++'
" }

"  VimをIDEっぽく
"  http://rcmdnk.github.io/blog/2014/07/25/computer-vim/
"   外部の構文チェッカーを利用してチェック
" NeoBundle 'scrooloose/syntastic'
" if ! empty(neobundle#get("syntastic"))
" 	let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ['vim'] }
"
"   " Disable automatic check at file open/close
"   let g:syntastic_check_on_open = 0
"   let g:syntastic_check_on_wq = 0
"   " C
"   let g:syntastic_c_check_header = 1
"   " C++
"   let g:syntastic_cpp_check_header = 1
" "   " Java
" "   let g:syntastic_java_javac_config_file_enabled = 1
" "   let g:syntastic_java_javac_config_file = "$HOME/.syntastic_javac_config"
" "
"   let g:syntastic_debug = 1
"   let g:syntastic_enable_vim_checker = 1
" endif
" NeoBundle 'airblade/vim-rooter'
" if ! empty(neobundle#get("vim-rooter"))
"   " Change only current window's directory
"   let g:rooter_use_lcd = 1
"   " files/directories for the root directory
"   let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
"   " Automatically change the directory
"   "autocmd! BufEnter *.c,*.cc,*.cxx,*.cpp,*.h,*.hh,*.java,*.py,*.sh,*.rb,*.html,*.css,*.js :Rooter
" endif

" タグのリスト表示 " MP_TAGBAR
NeoBundleLazy "majutsushi/tagbar", { "autoload": { "commands": ["TagbarToggle"] }}
if ! empty(neobundle#get("tagbar"))
		let g:tagbar_width = 20
endif

"
" 辞書 LN_0x00f
NeoBundle 'vim-scripts/cursoroverdictionary'
" CODRegistDict ~/src/eijiro-fpw/PDIC_1LINE/EIJI-136.txt
" 156M  EIJI-136.TXT 112M  REIJI136.TXT  3.7M  RYAKU136.TXT  233M  WAEI-136.TXT
" 形式に注意
" MP_COD

NeoBundle 'vim-jp/vim-sweep_trail'

" <C-G>c
NeoBundle 'tpope/vim-capslock'
imap <C-q> <C-O><Plug>CapsLockToggle
" プロジェクト管理
" project.vim は手動インストール
" NeoBundle 'vim-scripts/project.vim'
"

" 入力 ESKK LN_0x010 {
NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/skkdict.vim'
" ime を無効化
"set imdisable
" let $ESKK_DIR = expand("$HOME/.vim/eskk/")
let $ESKK_DIR = expand("$VIMFILES/eskk/")
let $ESKK_USER_DICT = $ESKK_DIR ."eskk_jisyo"
let g:eskk#debug = 0
" let g:eskk#egg_like_newline = 1
" http://d.hatena.ne.jp/tyru/20101214/vim_de_skk
let g:eskk#revert_henkan_style = "okuri-one"
let g:eskk#enable_completion = 1
let g:eskk#directory = $ESKK_DIR
let g:eskk#dictionary = { 'path': $ESKK_USER_DICT , 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': $ESKK_DIR . "dict/SKK-JISYO.L" , 'sorted': 1, 'encoding': 'euc-jp' }
let g:eskk#server = { 	'host': 'localhost', 'port': 55100,	'type': 'notfound' }
let g:eskk#cursor_color = {   'ascii': ['#8b8b83', '#bebebe'],
						\   'hira': ['#8b3e2f', '#ffc0cb'],
						\   'kata': ['#228b22', '#00ff00'],
						\   'abbrev': '#4169e1',
						\   'zenei': '#ffd700'}
" <C-g>u  で元 にもどす?
let g:eskk#set_undo_point = { 'sticky': 1,	'kakutei': 1 }

" http://hinagishi.hateblo.jp/entry/2011/12/24/194319
" http://subtech.g.hatena.ne.jp/motemen/20110527/1306485690
" https://github.com/tyru/eskk.vim/issues/149
"

let g:use_azik = 0
if g:use_azik == 0
	function! s:eskk_initial_pre()
			" こちらが使われるみたい
			let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
			call t.add_map(',', '，')
			call t.add_map('.', '．')
	"   	call t.add_map('a', 'あ')
	"   	call t.add_map('o', 'お')
	" 	call t.add_map('ho', 'ほ')
	" 	call t.add_map('wa', 'わ')
	" 	call t.add_map('wd', 'うぇん')
	" 	call t.add_map('we', 'うぇ')
				call t.add_map('whe', 'ゑ')
				call t.add_map('whi', 'ゐ')
	"   	call t.add_map('who', 'うぉ')
	"   	call t.add_map('who', 'うぉ')
			call eskk#register_mode_table('hira', t)
			"
			let t = eskk#table#new('rom_to_kata*', 'rom_to_kata')
			call t.add_map(',', '，')
			call t.add_map('.', '．')
			call t.add_map('ho', 'ホ')
			call t.add_map('wa', 'ワ')
			call t.add_map('who', 'ウォ')
			call eskk#register_mode_table('kata', t)
	endfunction
else
	function! s:eskk_initial_pre()
		"{{{ rom_to_hira
		let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
		call t.add_map('-', 'ー')
		call t.add_map('~', '?')
		call t.add_map('.', '。')
		call t.add_map(',', '、')
		call t.add_map('/', '・')
		call t.add_map(':', 'ー')
		call t.add_map(';', 'っ')
		call t.add_map('tm', 'っ')
		call t.add_map('[', '「')
		call t.add_map(']', '」')
		call t.add_map('a', 'あ')
		call t.add_map('ba', 'ば')
		call t.add_map('bd', 'べん')
		call t.add_map('be', 'べ')
		call t.add_map('bh', 'ぶう')
		call t.add_map('bi', 'び')
		call t.add_map('bj', 'ぶん')
		call t.add_map('bk', 'びん')
		call t.add_map('bl', 'ぼん')
		call t.add_map('bn', 'ばん')
		call t.add_map('bo', 'ぼ')
		call t.add_map('bp', 'ぼう')
		call t.add_map('bq', 'ばい')
		call t.add_map('bt', 'びと')
		call t.add_map('bu', 'ぶ')
		call t.add_map('bv', 'びゅう')
		call t.add_map('bw', 'べい')
		call t.add_map('bx', 'びょう')
		call t.add_map('bya', 'びゃ')
		call t.add_map('byd', 'びぇん')
		call t.add_map('bye', 'びぇ')
		call t.add_map('byh', 'びゅう')
		call t.add_map('byj', 'びゅん')
		call t.add_map('byl', 'びょん')
		call t.add_map('byn', 'びゃん')
		call t.add_map('byo', 'びょ')
		call t.add_map('byp', 'びょう')
		call t.add_map('byq', 'びゃい')
		call t.add_map('byu', 'びゅ')
		call t.add_map('byw', 'びぇい')
		call t.add_map('byz', 'びゃん')
		call t.add_map('bz', 'ばん')
		call t.add_map('ca', 'ちゃ')
		call t.add_map('cd', 'ちぇん')
		call t.add_map('ce', 'ちぇ')
		call t.add_map('cf', 'ちぇ')
		call t.add_map('ch', 'ちゅう')
		call t.add_map('ci', 'ち')
		call t.add_map('cj', 'ちゅん')
		call t.add_map('ck', 'ちん')
		call t.add_map('cl', 'ちょん')
		call t.add_map('cn', 'ちゃん')
		call t.add_map('co', 'ちょ')
		call t.add_map('cp', 'ちょう')
		call t.add_map('cq', 'ちゃい')
		call t.add_map('cu', 'ちゅ')
		call t.add_map('cw', 'ちぇい')
		call t.add_map('cz', 'ちゃん')
		call t.add_map('da', 'だ')
		call t.add_map('dch', 'どぅー')
		call t.add_map('dci', 'でぃ')
		call t.add_map('dcj', 'どぅん')
		call t.add_map('dck', 'でぃん')
		call t.add_map('dcu', 'どぅ')
		call t.add_map('dd', 'でん')
		call t.add_map('de', 'で')
		call t.add_map('df', 'で')
		call t.add_map('dga', 'ぢゃ')
		call t.add_map('dge', 'ぢぇ')
		call t.add_map('dgh', 'でゅー')
		call t.add_map('dgi', 'でぃ')
		call t.add_map('dgj', 'ぢゅん')
		call t.add_map('dgl', 'ぢょん')
		call t.add_map('dgo', 'ぢょ')
		call t.add_map('dgq', 'ぢゃい')
		call t.add_map('dgu', 'ぢゅ')
		call t.add_map('dgz', 'ぢゃん')
		call t.add_map('dh', 'づう')
		call t.add_map('di', 'ぢ')
		call t.add_map('dj', 'づん')
		call t.add_map('dk', 'ぢん')
		call t.add_map('dl', 'どん')
		call t.add_map('dm', 'でも')
		call t.add_map('dn', 'だん')
		call t.add_map('do', 'ど')
		call t.add_map('dp', 'どう')
		call t.add_map('dq', 'だい')
		call t.add_map('dr', 'である')
		call t.add_map('ds', 'です')
		call t.add_map('dt', 'だち')
		call t.add_map('du', 'づ')
		call t.add_map('dv', 'ぢゅう')
		call t.add_map('dw', 'でい')
		call t.add_map('dx', 'ぢょう')
		call t.add_map('dy', 'でぃ')
		call t.add_map('dz', 'だん')
		call t.add_map('e', 'え')
		call t.add_map('fa', 'ふぁ')
		call t.add_map('fd', 'ふぇん')
		call t.add_map('fe', 'ふぇ')
		call t.add_map('fh', 'ふう')
		call t.add_map('fi', 'ふぃ')
		call t.add_map('fj', 'ふん')
		call t.add_map('fk', 'ふぃん')
		call t.add_map('fl', 'ふぉん')
		call t.add_map('fn', 'ふぁん')
		call t.add_map('fo', 'ふぉ')
		call t.add_map('fp', 'ふぉー')
		call t.add_map('fq', 'ふぁい')
		call t.add_map('fu', 'ふ')
		call t.add_map('fv', 'ふゅー')
		call t.add_map('fw', 'ふぇい')
		call t.add_map('fyh', 'ふゅー')
		call t.add_map('fyj', 'ふゅん')
		call t.add_map('fyu', 'ふゅ')
		call t.add_map('fz', 'ふぁん')
		call t.add_map('ga', 'が')
		call t.add_map('gd', 'げん')
		call t.add_map('ge', 'げ')
		call t.add_map('gh', 'ぐう')
		call t.add_map('gi', 'ぎ')
		call t.add_map('gj', 'ぐん')
		call t.add_map('gk', 'ぎん')
		call t.add_map('gl', 'ごん')
		call t.add_map('gn', 'がん')
		call t.add_map('go', 'ご')
		call t.add_map('gp', 'ごう')
		call t.add_map('gq', 'がい')
		call t.add_map('gr', 'がら')
		call t.add_map('gt', 'ごと')
		call t.add_map('gu', 'ぐ')
		call t.add_map('gv', 'ぎゅう')
		call t.add_map('gw', 'げい')
		call t.add_map('gx', 'ぎょう')
		call t.add_map('gya', 'ぎゃ')
		call t.add_map('gyd', 'ぎぇん')
		call t.add_map('gye', 'ぎぇ')
		call t.add_map('gyh', 'ぎゅう')
		call t.add_map('gyj', 'ぎゅん')
		call t.add_map('gyl', 'ぎょん')
		call t.add_map('gyn', 'ぎゃん')
		call t.add_map('gyo', 'ぎょ')
		call t.add_map('gyp', 'ぎょう')
		call t.add_map('gyq', 'ぎゃい')
		call t.add_map('gyu', 'ぎゅ')
		call t.add_map('gyw', 'ぎぇい')
		call t.add_map('gyz', 'ぎゃん')
		call t.add_map('gz', 'がん')
		call t.add_map('ha', 'は')
		call t.add_map('hd', 'へん')
		call t.add_map('he', 'へ')
		call t.add_map('hf', 'ふ')
		call t.add_map('hga', 'ひゃ')
		call t.add_map('hgd', 'ひぇん')
		call t.add_map('hge', 'ひぇ')
		call t.add_map('hgh', 'ひゅう')
		call t.add_map('hgj', 'ひゅん')
		call t.add_map('hgl', 'ひょん')
		call t.add_map('hgn', 'ひゃん')
		call t.add_map('hgo', 'ひょ')
		call t.add_map('hgp', 'ひょう')
		call t.add_map('hgq', 'ひゃい')
		call t.add_map('hgu', 'ひゅ')
		call t.add_map('hgz', 'ひゃん')
		call t.add_map('hh', 'ふう')
		call t.add_map('hi', 'ひ')
		call t.add_map('hj', 'ふん')
		call t.add_map('hk', 'ひん')
		call t.add_map('hl', 'ほん')
		call t.add_map('ho', 'ほ')
		call t.add_map('hp', 'ほう')
		call t.add_map('hq', 'はい')
		call t.add_map('hr', 'はら')
		call t.add_map('ht', 'ひと')
		call t.add_map('hu', 'ふ')
		call t.add_map('hv', 'ひゅう')
		call t.add_map('hw', 'へい')
		call t.add_map('hx', 'ひょう')
		call t.add_map('hya', 'ひゃ')
		call t.add_map('hyd', 'ひぇん')
		call t.add_map('hye', 'ひぇ')
		call t.add_map('hyh', 'ひゅう')
		call t.add_map('hyj', 'ひゅん')
		call t.add_map('hyl', 'ひょん')
		call t.add_map('hyo', 'ひょ')
		call t.add_map('hyp', 'ひょう')
		call t.add_map('hyq', 'ひゃい')
		call t.add_map('hyu', 'ひゅ')
		call t.add_map('hyz', 'ひゃん')
		call t.add_map('hz', 'はん')
		call t.add_map('i', 'い')
		call t.add_map('ja', 'じゃ')
		call t.add_map('jd', 'じぇん')
		call t.add_map('je', 'じぇ')
		call t.add_map('jf', 'じゅ')
		call t.add_map('jh', 'じゅう')
		call t.add_map('ji', 'じ')
		call t.add_map('jj', 'じゅん')
		call t.add_map('jk', 'じん')
		call t.add_map('jl', 'じょん')
		call t.add_map('jo', 'じょ')
		call t.add_map('jp', 'じょう')
		call t.add_map('jq', 'じゃい')
		call t.add_map('ju', 'じゅ')
		call t.add_map('jw', 'じぇい')
		call t.add_map('jz', 'じゃん')
		call t.add_map('ka', 'か')
		call t.add_map('kd', 'けん')
		call t.add_map('ke', 'け')
		call t.add_map('kf', 'き')
		call t.add_map('kga', 'きゃ')
		call t.add_map('kgh', 'きゅう')
		call t.add_map('kgj', 'きゅん')
		call t.add_map('kgl', 'きょん')
		call t.add_map('kgn', 'きゃん')
		call t.add_map('kgo', 'きょ')
		call t.add_map('kgp', 'きょう')
		call t.add_map('kgq', 'きゃい')
		call t.add_map('kgu', 'きゅ')
		call t.add_map('kgz', 'きゃん')
		call t.add_map('kh', 'くう')
		call t.add_map('ki', 'き')
		call t.add_map('kj', 'くん')
		call t.add_map('kk', 'きん')
		call t.add_map('kl', 'こん')
		call t.add_map('km', 'かも')
		call t.add_map('ko', 'こ')
		call t.add_map('kp', 'こう')
		call t.add_map('kq', 'かい')
		call t.add_map('kr', 'から')
		call t.add_map('kt', 'こと')
		call t.add_map('ku', 'く')
		call t.add_map('kv', 'きゅう')
		call t.add_map('kw', 'けい')
		call t.add_map('kx', 'きょう')
		call t.add_map('kz', 'かん')
		call t.add_map('la', 'ぁ')
		call t.add_map('le', 'ぇ')
		call t.add_map('li', 'ぃ')
		call t.add_map('lka', 'ヵ')
		call t.add_map('lke', 'ヶ')
		call t.add_map('lo', 'ぉ')
		call t.add_map('ltu', 'っ')
		call t.add_map('lu', 'ぅ')
		call t.add_map('lwa', 'ゎ')
		call t.add_map('lya', 'ゃ')
		call t.add_map('lye', 'ぇ')
		call t.add_map('lyi', 'ぃ')
		call t.add_map('lyo', 'ょ')
		call t.add_map('lyu', 'ゅ')
		call t.add_map('ma', 'ま')
		call t.add_map('md', 'めん')
		call t.add_map('me', 'め')
		call t.add_map('mf', 'む')
		call t.add_map('mga', 'みゃ')
		call t.add_map('mgd', 'みぇん')
		call t.add_map('mge', 'みぇ')
		call t.add_map('mgh', 'みゅう')
		call t.add_map('mgj', 'みゅん')
		call t.add_map('mgl', 'みょん')
		call t.add_map('mgn', 'みゃん')
		call t.add_map('mgo', 'みょ')
		call t.add_map('mgp', 'みょう')
		call t.add_map('mgq', 'みゃい')
		call t.add_map('mgu', 'みゅ')
		call t.add_map('mgw', 'みぇい')
		call t.add_map('mgz', 'みゃん')
		call t.add_map('mh', 'むう')
		call t.add_map('mi', 'み')
		call t.add_map('mj', 'むん')
		call t.add_map('mk', 'みん')
		call t.add_map('ml', 'もん')
		call t.add_map('mn', 'もの')
		call t.add_map('mo', 'も')
		call t.add_map('mp', 'もう')
		call t.add_map('mq', 'まい')
		call t.add_map('mr', 'まる')
		call t.add_map('ms', 'ます')
		call t.add_map('mt', 'また')
		call t.add_map('mu', 'む')
		call t.add_map('mv', 'みゅう')
		call t.add_map('mw', 'めい')
		call t.add_map('mx', 'みょう')
		call t.add_map('mz', 'まん')
		call t.add_map('na', 'な')
		call t.add_map('nb', 'ねば')
		call t.add_map('nd', 'ねん')
		call t.add_map('ne', 'ね')
		call t.add_map('nf', 'ぬ')
		call t.add_map('nga', 'にゃ')
		call t.add_map('ngd', 'にぇん')
		call t.add_map('nge', 'にぇ')
		call t.add_map('ngh', 'にゅう')
		call t.add_map('ngj', 'にゅん')
		call t.add_map('ngl', 'にょん')
		call t.add_map('ngn', 'にゃん')
		call t.add_map('ngo', 'にょ')
		call t.add_map('ngp', 'にょう')
		call t.add_map('ngq', 'にゃい')
		call t.add_map('ngu', 'にゅ')
		call t.add_map('ngw', 'にぇい')
		call t.add_map('ngz', 'にゃん')
		call t.add_map('nh', 'ぬう')
		call t.add_map('ni', 'に')
		call t.add_map('nj', 'ぬん')
		call t.add_map('nk', 'にん')
		call t.add_map('nl', 'のん')
		call t.add_map('nn', 'ん')
		call t.add_map('no', 'の')
		call t.add_map('np', 'のう')
		call t.add_map('nq', 'ない')
		call t.add_map('nr', 'なる')
		call t.add_map('nt', 'にち')
		call t.add_map('nu', 'ぬ')
		call t.add_map('nv', 'にゅう')
		call t.add_map('nw', 'ねい')
		call t.add_map('nx', 'にょう')
		call t.add_map('nz', 'なん')
		call t.add_map('o', 'お')
		call t.add_map('pa', 'ぱ')
		call t.add_map('pd', 'ぺん')
		call t.add_map('pe', 'ぺ')
		call t.add_map('pf', 'ぽん')
		call t.add_map('pga', 'ぴゃ')
		call t.add_map('pgh', 'ぴゅう')
		call t.add_map('pgj', 'ぴゅん')
		call t.add_map('pgl', 'ぴょん')
		call t.add_map('pgn', 'ぴゃん')
		call t.add_map('pgo', 'ぴょ')
		call t.add_map('pgp', 'ぴょう')
		call t.add_map('pgq', 'ぴゃい')
		call t.add_map('pgu', 'ぴゅ')
		call t.add_map('pgz', 'ぴゃん')
		call t.add_map('ph', 'ぷう')
		call t.add_map('pi', 'ぴ')
		call t.add_map('pj', 'ぷん')
		call t.add_map('pk', 'ぴん')
		call t.add_map('pl', 'ぽん')
		call t.add_map('po', 'ぽ')
		call t.add_map('pp', 'ぽう')
		call t.add_map('pq', 'ぱい')
		call t.add_map('pu', 'ぷ')
		call t.add_map('pv', 'ぴゅう')
		call t.add_map('pw', 'ぺい')
		call t.add_map('px', 'ぴょう')
		call t.add_map('pyu', 'ぴゅ')
		call t.add_map('pz', 'ぱん')
		"call t.add_map('q', 'ん')
		call t.add_map('ra', 'ら')
		call t.add_map('rd', 'れん')
		call t.add_map('re', 'れ')
		call t.add_map('rh', 'るう')
		call t.add_map('ri', 'り')
		call t.add_map('rj', 'るん')
		call t.add_map('rk', 'りん')
		call t.add_map('rl', 'ろん')
		call t.add_map('rn', 'らん')
		call t.add_map('ro', 'ろ')
		call t.add_map('rp', 'ろう')
		call t.add_map('rq', 'らい')
		call t.add_map('rr', 'られ')
		call t.add_map('ru', 'る')
		call t.add_map('rv', 'りゅう')
		call t.add_map('rw', 'れい')
		call t.add_map('rx', 'りょう')
		call t.add_map('rya', 'りゃ')
		call t.add_map('ryh', 'りゅう')
		call t.add_map('ryj', 'りゅん')
		call t.add_map('ryl', 'りょん')
		call t.add_map('ryo', 'りょ')
		call t.add_map('ryp', 'りょう')
		call t.add_map('ryq', 'りゃい')
		call t.add_map('ryu', 'りゅ')
		call t.add_map('ryz', 'りゃん')
		call t.add_map('rz', 'らん')
		call t.add_map('sa', 'さ')
		call t.add_map('sd', 'せん')
		call t.add_map('se', 'せ')
		call t.add_map('sf', 'さい')
		call t.add_map('sh', 'すう')
		call t.add_map('si', 'し')
		call t.add_map('sj', 'すん')
		call t.add_map('sk', 'しん')
		call t.add_map('sl', 'そん')
		call t.add_map('sn', 'さん')
		call t.add_map('so', 'そ')
		call t.add_map('sp', 'そう')
		call t.add_map('sq', 'さい')
		call t.add_map('sr', 'する')
		call t.add_map('ss', 'せい')
		call t.add_map('st', 'した')
		call t.add_map('su', 'す')
		call t.add_map('sv', 'しゅう')
		call t.add_map('sw', 'せい')
		call t.add_map('sx', 'しょう')
		call t.add_map('syi', 'すぃ')
		call t.add_map('syk', 'すぃん')
		call t.add_map('sz', 'さん')
		call t.add_map('ta', 'た')
		call t.add_map('tb', 'たび')
		call t.add_map('td', 'てん')
		call t.add_map('te', 'て')
		call t.add_map('tgh', 'てゅー')
		call t.add_map('tgi', 'てぃ')
		call t.add_map('tgj', 'とぅん')
		call t.add_map('tgk', 'てぃん')
		call t.add_map('tgp', 'とぅー')
		call t.add_map('tgu', 'とぅ')
		call t.add_map('th', 'つう')
		call t.add_map('ti', 'ち')
		call t.add_map('tj', 'つん')
		call t.add_map('tk', 'ちん')
		call t.add_map('tl', 'とん')
		"call t.add_map('tm', 'ため')
		call t.add_map('tn', 'たん')
		call t.add_map('to', 'と')
		call t.add_map('tp', 'とう')
		call t.add_map('tq', 'たい')
		call t.add_map('tr', 'たら')
		call t.add_map('tsa', 'つぁ')
		call t.add_map('tsd', 'つぇん')
		call t.add_map('tse', 'つぇ')
		call t.add_map('tsh', 'つう')
		call t.add_map('tsi', 'つぃ')
		call t.add_map('tsj', 'つん')
		call t.add_map('tsk', 'つぃん')
		call t.add_map('tsl', 'つぉん')
		call t.add_map('tso', 'つぉ')
		call t.add_map('tsq', 'つぁい')
		call t.add_map('tst', 'として')
		call t.add_map('tsu', 'つ')
		call t.add_map('tsz', 'つぁん')
		call t.add_map('tt', 'たち')
		call t.add_map('tu', 'つ')
		call t.add_map('tw', 'てい')
		call t.add_map('tya', 'てゃ')
		call t.add_map('tyh', 'てゅー')
		call t.add_map('tyj', 'てゅん')
		call t.add_map('tyq', 'てゃい')
		call t.add_map('tyu', 'てゅ')
		call t.add_map('tyz', 'てゃん')
		call t.add_map('tz', 'たん')
		call t.add_map('u', 'う')
		call t.add_map('va', 'ヴぁ')
		call t.add_map('vd', 'ヴぇん')
		call t.add_map('ve', 'ヴぇ')
		call t.add_map('vh', 'ヴー')
		call t.add_map('vi', 'ヴぃ')
		call t.add_map('vj', 'ヴん')
		call t.add_map('vk', 'ヴぃん')
		call t.add_map('vl', 'ヴぉん')
		call t.add_map('vn', 'ヴぁん')
		call t.add_map('vo', 'ヴぉ')
		call t.add_map('vp', 'ヴぉう')
		call t.add_map('vq', 'ヴぁい')
		call t.add_map('vu', 'ヴ')
		call t.add_map('vv', 'ヴゅー')
		call t.add_map('vw', 'ヴぇい')
		call t.add_map('vyu', 'ヴゅ')
		call t.add_map('vz', 'ヴぁん')
		call t.add_map('wa', 'わ')
		call t.add_map('wd', 'うぇん')
		call t.add_map('we', 'うぇ')
		call t.add_map('whe', 'ゑ')
		call t.add_map('whi', 'ゐ')
		call t.add_map('who', 'うぉ')
		call t.add_map('wi', 'うぃ')
		call t.add_map('wk', 'うぃん')
		call t.add_map('wl', 'うぉん')
		call t.add_map('wn', 'わん')
		call t.add_map('wo', 'を')
		call t.add_map('wp', 'うぉー')
		call t.add_map('wq', 'わい')
		call t.add_map('wr', 'われ')
		call t.add_map('wso', 'うぉ')
		call t.add_map('wt', 'わた')
		call t.add_map('ww', 'うぇい')
		call t.add_map('wz', 'わん')
		call t.add_map('xa', 'しゃ')
		call t.add_map('xd', 'しぇん')
		call t.add_map('xe', 'しぇ')
		call t.add_map('xh', 'しゅう')
		call t.add_map('xi', 'し')
		call t.add_map('xj', 'しゅん')
		call t.add_map('xk', 'しん')
		call t.add_map('xl', 'しょん')
		call t.add_map('xn', 'しゃん')
		call t.add_map('xo', 'しょ')
		call t.add_map('xp', 'しょう')
		call t.add_map('xq', 'しゃい')
		call t.add_map('xu', 'しゅ')
		call t.add_map('xw', 'しぇい')
		call t.add_map('xz', 'しゃん')
		call t.add_map('ya', 'や')
		call t.add_map('yd', 'いぇん')
		call t.add_map('ye', 'いぇ')
		call t.add_map('yf', 'ゆ')
		call t.add_map('yh', 'ゆう')
		call t.add_map('yj', 'ゆん')
		call t.add_map('yl', 'よん')
		call t.add_map('yo', 'よ')
		call t.add_map('yp', 'よう')
		call t.add_map('yq', 'やい')
		call t.add_map('yr', 'よる')
		call t.add_map('yu', 'ゆ')
		call t.add_map('yw', 'いぇい')
		call t.add_map('yz', 'やん')
		call t.add_map('za', 'ざ')
		call t.add_map('zc', 'ざ')
		call t.add_map('zd', 'ぜん')
		call t.add_map('ze', 'ぜ')
		call t.add_map('zh', 'ずう')
		call t.add_map('zi', 'じ')
		call t.add_map('zj', 'ずん')
		call t.add_map('zk', 'じん')
		call t.add_map('zl', 'ぞん')
		call t.add_map('zn', 'ざん')
		call t.add_map('zo', 'ぞ')
		call t.add_map('zp', 'ぞう')
		call t.add_map('zq', 'ざい')
		call t.add_map('zr', 'ざる')
		call t.add_map('zu', 'ず')
		call t.add_map('zv', 'ざい')
		call t.add_map('zw', 'ぜい')
		call t.add_map('zx', 'ぜい')
		call t.add_map('zz', 'ざん')
		call eskk#register_mode_table('hira', t)
		" }}}
" 		"{{{ rom_to_kata
" 		let t = eskk#table#new('rom_to_kata*', 'rom_to_kata')
" 		call t.add_map('-', 'ー')
" 		call t.add_map('~', '?')
" 		call t.add_map('.', '。')
" 		call t.add_map(',', '、')
" 		call t.add_map('/', '・')
" 		call t.add_map(':', 'ー')
" 		"call t.add_map(';', 'ッ')
" 		call t.add_map('tm', 'ッ')
" 		call t.add_map('[', '「')
" 		call t.add_map(']', '」')
" 		call t.add_map('a', 'ア')
" 		call t.add_map('ba', 'バ')
" 		call t.add_map('bd', 'ベン')
" 		call t.add_map('be', 'ベ')
" 		call t.add_map('bh', 'ブウ')
" 		call t.add_map('bi', 'ビ')
" 		call t.add_map('bj', 'ブン')
" 		call t.add_map('bk', 'ビン')
" 		call t.add_map('bl', 'ボン')
" 		call t.add_map('bn', 'バン')
" 		call t.add_map('bo', 'ボ')
" 		call t.add_map('bp', 'ボウ')
" 		call t.add_map('bq', 'バイ')
" 		call t.add_map('bt', 'ビト')
" 		call t.add_map('bu', 'ブ')
" 		call t.add_map('bv', 'ビュウ')
" 		call t.add_map('bw', 'ベイ')
" 		call t.add_map('bx', 'ビョウ')
" 		call t.add_map('bya', 'ビャ')
" 		call t.add_map('byd', 'ビェン')
" 		call t.add_map('bye', 'ビェ')
" 		call t.add_map('byh', 'ビュウ')
" 		call t.add_map('byj', 'ビュン')
" 		call t.add_map('byl', 'ビョン')
" 		call t.add_map('byn', 'ビャン')
" 		call t.add_map('byo', 'ビョ')
" 		call t.add_map('byp', 'ビョウ')
" 		call t.add_map('byq', 'ビャイ')
" 		call t.add_map('byu', 'ビュ')
" 		call t.add_map('byw', 'ビェイ')
" 		call t.add_map('byz', 'ビャン')
" 		call t.add_map('bz', 'バン')
" 		call t.add_map('ca', 'チャ')
" 		call t.add_map('cd', 'チェン')
" 		call t.add_map('ce', 'チェ')
" 		call t.add_map('cf', 'チェ')
" 		call t.add_map('ch', 'チュウ')
" 		call t.add_map('ci', 'チ')
" 		call t.add_map('cj', 'チュン')
" 		call t.add_map('ck', 'チン')
" 		call t.add_map('cl', 'チョン')
" 		call t.add_map('cn', 'チャン')
" 		call t.add_map('co', 'チョ')
" 		call t.add_map('cp', 'チョウ')
" 		call t.add_map('cq', 'チャイ')
" 		call t.add_map('cu', 'チュ')
" 		call t.add_map('cw', 'チェイ')
" 		call t.add_map('cz', 'チャン')
" 		call t.add_map('da', 'ダ')
" 		call t.add_map('dch', 'ドゥー')
" 		call t.add_map('dci', 'ディ')
" 		call t.add_map('dcj', 'ドゥン')
" 		call t.add_map('dck', 'ディン')
" 		call t.add_map('dcu', 'ドゥ')
" 		call t.add_map('dd', 'デン')
" 		call t.add_map('de', 'デ')
" 		call t.add_map('df', 'デ')
" 		call t.add_map('dga', 'ヂャ')
" 		call t.add_map('dge', 'ヂェ')
" 		call t.add_map('dgh', 'デュー')
" 		call t.add_map('dgi', 'ディ')
" 		call t.add_map('dgj', 'ヂュン')
" 		call t.add_map('dgl', 'ヂョン')
" 		call t.add_map('dgo', 'ヂョ')
" 		call t.add_map('dgq', 'ヂャイ')
" 		call t.add_map('dgu', 'ヂュ')
" 		call t.add_map('dgz', 'ヂャン')
" 		call t.add_map('dh', 'ヅウ')
" 		call t.add_map('di', 'ヂ')
" 		call t.add_map('dj', 'ヅン')
" 		call t.add_map('dk', 'ヂン')
" 		call t.add_map('dl', 'ドン')
" 		call t.add_map('dm', 'デモ')
" 		call t.add_map('dn', 'ダン')
" 		call t.add_map('do', 'ド')
" 		call t.add_map('dp', 'ドウ')
" 		call t.add_map('dq', 'ダイ')
" 		call t.add_map('dr', 'デアル')
" 		call t.add_map('ds', 'デス')
" 		call t.add_map('dt', 'ダチ')
" 		call t.add_map('du', 'ヅ')
" 		call t.add_map('dv', 'ヂュウ')
" 		call t.add_map('dw', 'デイ')
" 		call t.add_map('dx', 'ヂョウ')
" 		call t.add_map('dy', 'ディ')
" 		call t.add_map('dz', 'ダン')
" 		call t.add_map('e', 'エ')
" 		call t.add_map('fa', 'ファ')
" 		call t.add_map('fd', 'フェン')
" 		call t.add_map('fe', 'フェ')
" 		call t.add_map('fh', 'フウ')
" 		call t.add_map('fi', 'フィ')
" 		call t.add_map('fj', 'フン')
" 		call t.add_map('fk', 'フィン')
" 		call t.add_map('fl', 'フォン')
" 		call t.add_map('fn', 'ファン')
" 		call t.add_map('fo', 'フォ')
" 		call t.add_map('fp', 'フォー')
" 		call t.add_map('fq', 'ファイ')
" 		call t.add_map('fu', 'フ')
" 		call t.add_map('fv', 'フュー')
" 		call t.add_map('fw', 'フェイ')
" 		call t.add_map('fyh', 'フュー')
" 		call t.add_map('fyj', 'フュン')
" 		call t.add_map('fyu', 'フュ')
" 		call t.add_map('fz', 'ファン')
" 		call t.add_map('ga', 'ガ')
" 		call t.add_map('gd', 'ゲン')
" 		call t.add_map('ge', 'ゲ')
" 		call t.add_map('gh', 'グウ')
" 		call t.add_map('gi', 'ギ')
" 		call t.add_map('gj', 'グン')
" 		call t.add_map('gk', 'ギン')
" 		call t.add_map('gl', 'ゴン')
" 		call t.add_map('gn', 'ガン')
" 		call t.add_map('go', 'ゴ')
" 		call t.add_map('gp', 'ゴウ')
" 		call t.add_map('gq', 'ガイ')
" 		call t.add_map('gr', 'ガラ')
" 		call t.add_map('gt', 'ゴト')
" 		call t.add_map('gu', 'グ')
" 		call t.add_map('gv', 'ギュウ')
" 		call t.add_map('gw', 'ゲイ')
" 		call t.add_map('gx', 'ギョウ')
" 		call t.add_map('gya', 'ギャ')
" 		call t.add_map('gyd', 'ギェン')
" 		call t.add_map('gye', 'ギェ')
" 		call t.add_map('gyh', 'ギュウ')
" 		call t.add_map('gyj', 'ギュン')
" 		call t.add_map('gyl', 'ギョン')
" 		call t.add_map('gyn', 'ギャン')
" 		call t.add_map('gyo', 'ギョ')
" 		call t.add_map('gyp', 'ギョウ')
" 		call t.add_map('gyq', 'ギャイ')
" 		call t.add_map('gyu', 'ギュ')
" 		call t.add_map('gyw', 'ギェイ')
" 		call t.add_map('gyz', 'ギャン')
" 		call t.add_map('gz', 'ガン')
" 		call t.add_map('ha', 'ハ')
" 		call t.add_map('hd', 'ヘン')
" 		call t.add_map('he', 'ヘ')
" 		call t.add_map('hf', 'フ')
" 		call t.add_map('hga', 'ヒャ')
" 		call t.add_map('hgd', 'ヒェン')
" 		call t.add_map('hge', 'ヒェ')
" 		call t.add_map('hgh', 'ヒュウ')
" 		call t.add_map('hgj', 'ヒュン')
" 		call t.add_map('hgl', 'ヒョン')
" 		call t.add_map('hgn', 'ヒャン')
" 		call t.add_map('hgo', 'ヒョ')
" 		call t.add_map('hgp', 'ヒョウ')
" 		call t.add_map('hgq', 'ヒャイ')
" 		call t.add_map('hgu', 'ヒュ')
" 		call t.add_map('hgz', 'ヒャン')
" 		call t.add_map('hh', 'フウ')
" 		call t.add_map('hi', 'ヒ')
" 		call t.add_map('hj', 'フン')
" 		call t.add_map('hk', 'ヒン')
" 		call t.add_map('hl', 'ホン')
" 		call t.add_map('ho', 'ホ')
" 		call t.add_map('hp', 'ホウ')
" 		call t.add_map('hq', 'ハイ')
" 		call t.add_map('hr', 'ハラ')
" 		call t.add_map('ht', 'ヒト')
" 		call t.add_map('hu', 'フ')
" 		call t.add_map('hv', 'ヒュウ')
" 		call t.add_map('hw', 'ヘイ')
" 		call t.add_map('hx', 'ヒョウ')
" 		call t.add_map('hya', 'ヒャ')
" 		call t.add_map('hyd', 'ヒェン')
" 		call t.add_map('hye', 'ヒェ')
" 		call t.add_map('hyh', 'ヒュウ')
" 		call t.add_map('hyj', 'ヒュン')
" 		call t.add_map('hyl', 'ヒョン')
" 		call t.add_map('hyo', 'ヒョ')
" 		call t.add_map('hyp', 'ヒョウ')
" 		call t.add_map('hyq', 'ヒャイ')
" 		call t.add_map('hyu', 'ヒュ')
" 		call t.add_map('hyz', 'ヒャン')
" 		call t.add_map('hz', 'ハン')
" 		call t.add_map('i', 'イ')
" 		call t.add_map('ja', 'ジャ')
" 		call t.add_map('jd', 'ジェン')
" 		call t.add_map('je', 'ジェ')
" 		call t.add_map('jf', 'ジュ')
" 		call t.add_map('jh', 'ジュウ')
" 		call t.add_map('ji', 'ジ')
" 		call t.add_map('jj', 'ジュン')
" 		call t.add_map('jk', 'ジン')
" 		call t.add_map('jl', 'ジョン')
" 		call t.add_map('jo', 'ジョ')
" 		call t.add_map('jp', 'ジョウ')
" 		call t.add_map('jq', 'ジャイ')
" 		call t.add_map('ju', 'ジュ')
" 		call t.add_map('jw', 'ジェイ')
" 		call t.add_map('jz', 'ジャン')
" 		call t.add_map('ka', 'カ')
" 		call t.add_map('kd', 'ケン')
" 		call t.add_map('ke', 'ケ')
" 		call t.add_map('kf', 'キ')
" 		call t.add_map('kga', 'キャ')
" 		call t.add_map('kgh', 'キュウ')
" 		call t.add_map('kgj', 'キュン')
" 		call t.add_map('kgl', 'キョン')
" 		call t.add_map('kgn', 'キャン')
" 		call t.add_map('kgo', 'キョ')
" 		call t.add_map('kgp', 'キョウ')
" 		call t.add_map('kgq', 'キャイ')
" 		call t.add_map('kgu', 'キュ')
" 		call t.add_map('kgz', 'キャン')
" 		call t.add_map('kh', 'クウ')
" 		call t.add_map('ki', 'キ')
" 		call t.add_map('kj', 'クン')
" 		call t.add_map('kk', 'キン')
" 		call t.add_map('kl', 'コン')
" 		call t.add_map('km', 'カモ')
" 		call t.add_map('ko', 'コ')
" 		call t.add_map('kp', 'コウ')
" 		call t.add_map('kq', 'カイ')
" 		call t.add_map('kr', 'カラ')
" 		call t.add_map('kt', 'コト')
" 		call t.add_map('ku', 'ク')
" 		call t.add_map('kv', 'キュウ')
" 		call t.add_map('kw', 'ケイ')
" 		call t.add_map('kx', 'キョウ')
" 		call t.add_map('kz', 'カン')
" 		call t.add_map('la', 'ァ')
" 		call t.add_map('le', 'ェ')
" 		call t.add_map('li', 'ィ')
" 		call t.add_map('lka', 'ヵ')
" 		call t.add_map('lke', 'ヶ')
" 		call t.add_map('lo', 'ォ')
" 		call t.add_map('ltu', 'ッ')
" 		call t.add_map('lu', 'ゥ')
" 		call t.add_map('lwa', 'ヮ')
" 		call t.add_map('lya', 'ャ')
" 		call t.add_map('lye', 'ェ')
" 		call t.add_map('lyi', 'ィ')
" 		call t.add_map('lyo', 'ョ')
" 		call t.add_map('lyu', 'ュ')
" 		call t.add_map('ma', 'マ')
" 		call t.add_map('md', 'メン')
" 		call t.add_map('me', 'メ')
" 		call t.add_map('mf', 'ム')
" 		call t.add_map('mga', 'ミャ')
" 		call t.add_map('mgd', 'ミェン')
" 		call t.add_map('mge', 'ミェ')
" 		call t.add_map('mgh', 'ミュウ')
" 		call t.add_map('mgj', 'ミュン')
" 		call t.add_map('mgl', 'ミョン')
" 		call t.add_map('mgn', 'ミャン')
" 		call t.add_map('mgo', 'ミョ')
" 		call t.add_map('mgp', 'ミョウ')
" 		call t.add_map('mgq', 'ミャイ')
" 		call t.add_map('mgu', 'ミュ')
" 		call t.add_map('mgw', 'ミェイ')
" 		call t.add_map('mgz', 'ミャン')
" 		call t.add_map('mh', 'ムウ')
" 		call t.add_map('mi', 'ミ')
" 		call t.add_map('mj', 'ムン')
" 		call t.add_map('mk', 'ミン')
" 		call t.add_map('ml', 'モン')
" 		call t.add_map('mn', 'モノ')
" 		call t.add_map('mo', 'モ')
" 		call t.add_map('mp', 'モウ')
" 		call t.add_map('mq', 'マイ')
" 		call t.add_map('mr', 'マル')
" 		call t.add_map('ms', 'マス')
" 		call t.add_map('mt', 'マタ')
" 		call t.add_map('mu', 'ム')
" 		call t.add_map('mv', 'ミュウ')
" 		call t.add_map('mw', 'メイ')
" 		call t.add_map('mx', 'ミョウ')
" 		call t.add_map('mz', 'マン')
" 		call t.add_map('na', 'ナ')
" 		call t.add_map('nb', 'ネバ')
" 		call t.add_map('nd', 'ネン')
" 		call t.add_map('ne', 'ネ')
" 		call t.add_map('nf', 'ヌ')
" 		call t.add_map('nga', 'ニャ')
" 		call t.add_map('ngd', 'ニェン')
" 		call t.add_map('nge', 'ニェ')
" 		call t.add_map('ngh', 'ニュウ')
" 		call t.add_map('ngj', 'ニュン')
" 		call t.add_map('ngl', 'ニョン')
" 		call t.add_map('ngn', 'ニャン')
" 		call t.add_map('ngo', 'ニョ')
" 		call t.add_map('ngp', 'ニョウ')
" 		call t.add_map('ngq', 'ニャイ')
" 		call t.add_map('ngu', 'ニュ')
" 		call t.add_map('ngw', 'ニェイ')
" 		call t.add_map('ngz', 'ニャン')
" 		call t.add_map('nh', 'ヌウ')
" 		call t.add_map('ni', 'ニ')
" 		call t.add_map('nj', 'ヌン')
" 		call t.add_map('nk', 'ニン')
" 		call t.add_map('nl', 'ノン')
" 		call t.add_map('nn', 'ン')
" 		call t.add_map('no', 'ノ')
" 		call t.add_map('np', 'ノウ')
" 		call t.add_map('nq', 'ナイ')
" 		call t.add_map('nr', 'ナル')
" 		call t.add_map('nt', 'ニチ')
" 		call t.add_map('nu', 'ヌ')
" 		call t.add_map('nv', 'ニュウ')
" 		call t.add_map('nw', 'ネイ')
" 		call t.add_map('nx', 'ニョウ')
" 		call t.add_map('nz', 'ナン')
" 		call t.add_map('o', 'オ')
" 		call t.add_map('pa', 'パ')
" 		call t.add_map('pd', 'ペン')
" 		call t.add_map('pe', 'ペ')
" 		call t.add_map('pf', 'ポン')
" 		call t.add_map('pga', 'ピャ')
" 		call t.add_map('pgh', 'ピュウ')
" 		call t.add_map('pgj', 'ピュン')
" 		call t.add_map('pgl', 'ピョン')
" 		call t.add_map('pgn', 'ピャン')
" 		call t.add_map('pgo', 'ピョ')
" 		call t.add_map('pgp', 'ピョウ')
" 		call t.add_map('pgq', 'ピャイ')
" 		call t.add_map('pgu', 'ピュ')
" 		call t.add_map('pgz', 'ピャン')
" 		call t.add_map('ph', 'プウ')
" 		call t.add_map('pi', 'ピ')
" 		call t.add_map('pj', 'プン')
" 		call t.add_map('pk', 'ピン')
" 		call t.add_map('pl', 'ポン')
" 		call t.add_map('po', 'ポ')
" 		call t.add_map('pp', 'ポウ')
" 		call t.add_map('pq', 'パイ')
" 		call t.add_map('pu', 'プ')
" 		call t.add_map('pv', 'ピュウ')
" 		call t.add_map('pw', 'ペイ')
" 		call t.add_map('px', 'ピョウ')
" 		call t.add_map('pyu', 'ピュ')
" 		call t.add_map('pz', 'パン')
" 		call t.add_map('q', 'ン')
" 		call t.add_map('ra', 'ラ')
" 		call t.add_map('rd', 'レン')
" 		call t.add_map('re', 'レ')
" 		call t.add_map('rh', 'ルウ')
" 		call t.add_map('ri', 'リ')
" 		call t.add_map('rj', 'ルン')
" 		call t.add_map('rk', 'リン')
" 		call t.add_map('rl', 'ロン')
" 		call t.add_map('rn', 'ラン')
" 		call t.add_map('ro', 'ロ')
" 		call t.add_map('rp', 'ロウ')
" 		call t.add_map('rq', 'ライ')
" 		call t.add_map('rr', 'ラレ')
" 		call t.add_map('ru', 'ル')
" 		call t.add_map('rv', 'リュウ')
" 		call t.add_map('rw', 'レイ')
" 		call t.add_map('rx', 'リョウ')
" 		call t.add_map('rya', 'リャ')
" 		call t.add_map('ryh', 'リュウ')
" 		call t.add_map('ryj', 'リュン')
" 		call t.add_map('ryl', 'リョン')
" 		call t.add_map('ryo', 'リョ')
" 		call t.add_map('ryp', 'リョウ')
" 		call t.add_map('ryq', 'リャイ')
" 		call t.add_map('ryu', 'リュ')
" 		call t.add_map('ryz', 'リャン')
" 		call t.add_map('rz', 'ラン')
" 		call t.add_map('sa', 'サ')
" 		call t.add_map('sd', 'セン')
" 		call t.add_map('se', 'セ')
" 		call t.add_map('sf', 'サイ')
" 		call t.add_map('sh', 'スウ')
" 		call t.add_map('si', 'シ')
" 		call t.add_map('sj', 'スン')
" 		call t.add_map('sk', 'シン')
" 		call t.add_map('sl', 'ソン')
" 		call t.add_map('sn', 'サン')
" 		call t.add_map('so', 'ソ')
" 		call t.add_map('sp', 'ソウ')
" 		call t.add_map('sq', 'サイ')
" 		call t.add_map('sr', 'スル')
" 		call t.add_map('ss', 'セイ')
" 		call t.add_map('st', 'シタ')
" 		call t.add_map('su', 'ス')
" 		call t.add_map('sv', 'シュウ')
" 		call t.add_map('sw', 'セイ')
" 		call t.add_map('sx', 'ショウ')
" 		call t.add_map('syi', 'スィ')
" 		call t.add_map('syk', 'スィン')
" 		call t.add_map('sz', 'サン')
" 		call t.add_map('ta', 'タ')
" 		call t.add_map('tb', 'タビ')
" 		call t.add_map('td', 'テン')
" 		call t.add_map('te', 'テ')
" 		call t.add_map('tgh', 'テュー')
" 		call t.add_map('tgi', 'ティ')
" 		call t.add_map('tgj', 'トゥン')
" 		call t.add_map('tgk', 'ティン')
" 		call t.add_map('tgp', 'トゥー')
" 		call t.add_map('tgu', 'トゥ')
" 		call t.add_map('th', 'ツウ')
" 		call t.add_map('ti', 'チ')
" 		call t.add_map('tj', 'ツン')
" 		call t.add_map('tk', 'チン')
" 		call t.add_map('tl', 'トン')
" 		"call t.add_map('tm', 'タメ')
" 		call t.add_map('tn', 'タン')
" 		call t.add_map('to', 'ト')
" 		call t.add_map('tp', 'トウ')
" 		call t.add_map('tq', 'タイ')
" 		call t.add_map('tr', 'タラ')
" 		call t.add_map('tsa', 'ツァ')
" 		call t.add_map('tsd', 'ツェン')
" 		call t.add_map('tse', 'ツェ')
" 		call t.add_map('tsh', 'ツウ')
" 		call t.add_map('tsi', 'ツィ')
" 		call t.add_map('tsj', 'ツン')
" 		call t.add_map('tsk', 'ツィン')
" 		call t.add_map('tsl', 'ツォン')
" 		call t.add_map('tso', 'ツォ')
" 		call t.add_map('tsq', 'ツァイ')
" 		call t.add_map('tst', 'トシテ')
" 		call t.add_map('tsu', 'ツ')
" 		call t.add_map('tsz', 'ツァン')
" 		call t.add_map('tt', 'タチ')
" 		call t.add_map('tu', 'ツ')
" 		call t.add_map('tw', 'テイ')
" 		call t.add_map('tya', 'テャ')
" 		call t.add_map('tyh', 'テュー')
" 		call t.add_map('tyj', 'テュン')
" 		call t.add_map('tyq', 'テャイ')
" 		call t.add_map('tyu', 'テュ')
" 		call t.add_map('tyz', 'テャン')
" 		call t.add_map('tz', 'タン')
" 		call t.add_map('u', 'ウ')
" 		call t.add_map('va', 'ヴァ')
" 		call t.add_map('vd', 'ヴェン')
" 		call t.add_map('ve', 'ヴェ')
" 		call t.add_map('vh', 'ヴー')
" 		call t.add_map('vi', 'ヴィ')
" 		call t.add_map('vj', 'ヴン')
" 		call t.add_map('vk', 'ヴィン')
" 		call t.add_map('vl', 'ヴォン')
" 		call t.add_map('vn', 'ヴァン')
" 		call t.add_map('vo', 'ヴォ')
" 		call t.add_map('vp', 'ヴォウ')
" 		call t.add_map('vq', 'ヴァイ')
" 		call t.add_map('vu', 'ヴ')
" 		call t.add_map('vv', 'ヴュー')
" 		call t.add_map('vw', 'ヴェイ')
" 		call t.add_map('vyu', 'ヴュ')
" 		call t.add_map('vz', 'ヴァン')
" 		call t.add_map('wa', 'ワ')
" 		call t.add_map('wd', 'ウェン')
" 		call t.add_map('we', 'ウェ')
" 		call t.add_map('whe', 'ヱ')
" 		call t.add_map('whi', 'ヰ')
" 		call t.add_map('who', 'ウォ')
" 		call t.add_map('wi', 'ウィ')
" 		call t.add_map('wk', 'ウィン')
" 		call t.add_map('wl', 'ウォン')
" 		call t.add_map('wn', 'ワン')
" 		call t.add_map('wo', 'ヲ')
" 		call t.add_map('wp', 'ウォー')
" 		call t.add_map('wq', 'ワイ')
" 		call t.add_map('wr', 'ワレ')
" 		call t.add_map('wso', 'ウォ')
" 		call t.add_map('wt', 'ワタ')
" 		call t.add_map('ww', 'ウェイ')
" 		call t.add_map('wz', 'ワン')
" 		call t.add_map('xa', 'シャ')
" 		call t.add_map('xd', 'シェン')
" 		call t.add_map('xe', 'シェ')
" 		call t.add_map('xh', 'シュウ')
" 		call t.add_map('xi', 'シ')
" 		call t.add_map('xj', 'シュン')
" 		call t.add_map('xk', 'シン')
" 		call t.add_map('xl', 'ション')
" 		call t.add_map('xn', 'シャン')
" 		call t.add_map('xo', 'ショ')
" 		call t.add_map('xp', 'ショウ')
" 		call t.add_map('xq', 'シャイ')
" 		call t.add_map('xu', 'シュ')
" 		call t.add_map('xw', 'シェイ')
" 		call t.add_map('xz', 'シャン')
" 		call t.add_map('ya', 'ヤ')
" 		call t.add_map('yd', 'イェン')
" 		call t.add_map('ye', 'イェ')
" 		call t.add_map('yf', 'ユ')
" 		call t.add_map('yh', 'ユウ')
" 		call t.add_map('yj', 'ユン')
" 		call t.add_map('yl', 'ヨン')
" 		call t.add_map('yo', 'ヨ')
" 		call t.add_map('yp', 'ヨウ')
" 		call t.add_map('yq', 'ヤイ')
" 		call t.add_map('yr', 'ヨル')
" 		call t.add_map('yu', 'ユ')
" 		call t.add_map('yw', 'イェイ')
" 		call t.add_map('yz', 'ヤン')
" 		call t.add_map('za', 'ザ')
" 		call t.add_map('zc', 'ザ')
" 		call t.add_map('zd', 'ゼン')
" 		call t.add_map('ze', 'ゼ')
" 		call t.add_map('zh', 'ズウ')
" 		call t.add_map('zi', 'ジ')
" 		call t.add_map('zj', 'ズン')
" 		call t.add_map('zk', 'ジン')
" 		call t.add_map('zl', 'ゾン')
" 		call t.add_map('zn', 'ザン')
" 		call t.add_map('zo', 'ゾ')
" 		call t.add_map('zp', 'ゾウ')
" 		call t.add_map('zq', 'ザイ')
" 		call t.add_map('zr', 'ザル')
" 		call t.add_map('zu', 'ズ')
" 		call t.add_map('zv', 'ザイ')
" 		call t.add_map('zw', 'ゼイ')
" 		call t.add_map('zx', 'ゼイ')
" 		call t.add_map('zz', 'ザン')
" 		call eskk#register_mode_table('kata', t)
" 		" }}}
	endfunction
endif

augroup vimrc-eskk
		autocmd!
		autocmd User eskk-initialize-pre call s:eskk_initial_pre()
augroup END
"
" MP_ESKK
" http://hitode909.hatenablog.com/entry/20110421/1303274561
" google-ime-skk
" }

" Makeを拡張 http://ac-mopp.blogspot.jp/2014/02/vimmakemake.html
"  nargs を書き換え
NeoBundle 'mopp/makecomp.vim'
" NeoBundleLazy 'mopp/makecomp.vim', { 'autoload' : { 'commands' : [ { 'name' : 'Make', 'complete' : 'customlist,makecomp#get_make_argument' } ] } }
" MP_MAKE
" http://qiita.com/tekkoc/items/923d7a7cf124e63adab5
NeoBundle "davidhalter/jedi-vim"
" rename用のマッピングを無効にしたため、代わりにコマンドを定義
command! -nargs=0 JediRename :call jedi#rename()

" pythonのrename用のマッピングがquickrunとかぶるため回避させる
let g:jedi#rename_command = ""
" http://d.hatena.ne.jp/heavenshell/20130827/1377605777
let g:jedi#documentation_command = "K"

NeoBundle 'superbrothers/vim-vimperator'

" うまくいかない
" NeoBundle "Twinside/vim-codeoverview"

" NeoBundle "koron/minimap-vim"
NeoBundle "basyura/twibill.vim"
NeoBundle "basyura/TweetVim"
let g:tweetvim_display_icon = 1
let g:tweetvim_tweet_per_page = 50
" MP_TWEET

"NeoBundle 'rbtnn/game_engine.vim'
"NeoBundle 'rbtnn/mario.vim'
"NeoBundle 'rbtnn/puyo.vim'

" NeoBundle 'yuratomo/w3m.vim'
" } ------------------------------------------------------------------------------------------------------------
call neobundle#end()
filetype plugin indent on
syntax enable

" インストールのチェック
NeoBundleCheck
" }}}

" Tmp {{{1
" C++ 関連の補完などの設定，vimrc.osyo-manga を読み込む {

" プラグインの設定前に呼ばれる関数
" プラグインを無効にしたい場合など時に使用する

" 一番最後に呼ばれる関数
" 設定などを上書きしたい場合に使用する
function! CppVimrcOnFinish()
		" ??
		if !exists('g:quickrun_config')
				let g:quickrun_config = {}
		endif
		let g:quickrun_config.runner = "wandbox"
endfunction

"let g:neocomplete#force_overwrite_completefunc=1
if !exists('g:neocomplete#force_omni_input_patterns')
		let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
						\ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
						\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.hpp =
						\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
" https://github.com/Shougo/neosnippet.vim/issues/198

" neocomplet.vim
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
		" 補完を有効にする
		let g:neocomplete#enable_at_startup = 1
		" 補完に時間がかかってもスキップしない
		let g:neocomplete#skip_auto_completion_time = ""
endfunction
unlet s:hooks


" vimrc の読み込み
"source <sfile>:h/vimrc
" シンボリックリンクしてあってずれるかもしれないので，パスにしておく
"source $HOME/initfiles/vimrc.osyo-manga
"}
"
" vimrc の読み込み
"source <sfile>:h/vimrc
" シンボリックリンクしてあってずれるかもしれないので，パスにしておく
"source $HOME/initfiles/vimrc.osyo-manga
"}

if has('unix')
		"-------------------------------------------------------------------------------
		if exists("*CppVimrcOnPrePlugin")
				call CppVimrcOnPrePlugin()
		endif
		"
		if !has('vim_starting')
				" Call on_source hook when reloading .vimrc.
				call neobundle#call_hook('on_source')
		endif
		"
		if exists("*CppVimrcOnFinish")
				call CppVimrcOnFinish()
		endif
		" }
endif

" Script {{{1
" 場所に注意 "NeoBundle 内で定義しない
let s:V = vital#of('vital')

command! -nargs=1 -complete=custom,s:str_rc RC call <SID>edit_rc(<f-args>)
function! s:str_rc(ArgLead, CmdLine, CursorPos)
	return "vimrc\ngvimrc\nvimperatorrc"
endfunction
" command! -nargs=1 -complete=customlist,s:list_rc RC call <SID>edit_rc(<f-args>)
" function! s:list_rc(ArgLead, CmdLine, CursorPos)
" 	let l = ['vimrc', 'gvimrc', 'vimperatorrc']
" 	return l
" endfunction
function! s:edit_rc(rc)
	if a:rc == 'vimrc'
		exe 'e' . expand('$MYVIMRC')
	endif
	if a:rc == 'gvimrc'
		exe 'e' . expand('$MYGVIMRC')
	endif
	if a:rc == 'vimperatorrc'
		exe 'e' . expand('$MY_VIMPERATORRC')
	endif
endfunction


" 構文チェック用
function! s:Gcc()
		:w
		:!g++ %
endfunction
" command! Gcc call s:Gcc()
command! Gcc call <SID>Gcc()

" 失敗
command! EditNote  execute  'edit strftime("%Y-%m-%d")'
function! s:EditNoteDate()
		let l:date = strftime("%Y-%m-%d")
		echo l:date
		let l:file = "note." . l:date . ".txt"
		echo l:file
		e l:file
		"     edit "note." . l:date . ".txt"
endfunction
command! EditNote2 call <SID>EditNoteDate()
"
" 縦に連番を入力する
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips#TOC-12
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber
						\ let cl = col('.') | for nc in range(1, <count>?<count>-line('.'):1)|
								\ exe 'normal! j'.nc.<q-args>|call cursor('.', cl)|endfor|unlet cl|unlet snf

" vimコマンド出力をクリップボードへコピー
" ex :CopyCmdOutput map
command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)
func! s:func_copy_cmd_output(cmd)
		redir @">
		silent execute a:cmd
		redir END
endfunc

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
							\ | diffthis | wincmd p | diffthis

" Vimで現在日時を自動的に挿入する方法
" http://d.hatena.ne.jp/hyuki/20130714/vim
" i<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><CR>
" command! PutDateTime <Esc>i<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
" コマンドでやると失敗する
" キーを割り当て
"日付を挿入
"http://homepage3.nifty.com/keuch/cat_vim.html
command! PutDateTime r!date +\%Y-\%m-\%d\ \%H:\%M
command! PutDate r!date +\%Y-\%m-\%d

command! Utf8  e ++enc=utf-8
command! Euc   e ++enc=euc-jp
command! Sjis  e ++enc=cp932
command! Jis   e ++enc=iso-2022-jp
command! WUtf8 w ++enc=utf-8 | e
command! WEuc  w ++enc=euc-jp | e
command! WSjis w ++enc=cp932 | e
command! WJis  w ++enc=iso-2022-jp | e

"
command! Tabe1  exe 'norm ma' | tabe % | exe "norm 'a" | exe 'norm zz'
command! Tabe  call s:tabe()
fu! s:tabe()
	norm ma
	tabe %
	norm 'a
	norm zz
endfu

" quickfix
" http://d.hatena.ne.jp/thinca/20130708/1373210009
" http://d.hatena.ne.jp/ryochack/20110609/1307639604

" $VIMFILES/after/ftplugin/qf.vim に書く
" noremap <buffer> p  <CR>zz<C-w>p
"
" setlocal statusline+=\ %L
"
" nnoremap <silent> <buffer> dd :call <SID>del_entry()<CR>
" nnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
" vnoremap <silent> <buffer> d :call <SID>del_entry()<CR>
" vnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
" nnoremap <silent> <buffer> u :<C-u>call <SID>undo_entry()<CR>
"
" if exists('*s:undo_entry')
"   finish
" endif
"
" function! s:undo_entry()
"   let history = get(w:, 'qf_history', [])
"   if !empty(history)
"     call setqflist(remove(history, -1), 'r')
"   endif
" endfunction
"
" function! s:del_entry() range
"   let qf = getqflist()
"   let history = get(w:, 'qf_history', [])
"   call add(history, copy(qf))
"   let w:qf_history = history
"   unlet! qf[a:firstline - 1 : a:lastline - 1]
"   call setqflist(qf, 'r')
"   execute a:firstline
" endfunction

function! OpenModifiableQF()
        cw
        set modifiable
        set nowrap
endfunction

augroup quick-fix-1
	autocmd!
	autocmd QuickfixCmdPost vimgrep call OpenModifiableQF()
augroup END

" bundle フォルダを開く
com! OBD call OpenBundlepluginDir()
fu! OpenBundlepluginDir()
	let l = getline(".")
	if l =~ 'NeoBundle'
			let dir = matchstr(l, '\/.\{-}\ze\"')
			let path = $BUNDLE . dir
			echo path
			exe "e " . path
	endif
endfu

"}}}

" Mapping {{{1
" ショートカッ卜の設定
vnoremap [prefix] <Nop>
vmap     <Space> [prefix]
nnoremap [prefix] <Nop>
nmap     <Space> [prefix]

nnoremap [prefix].pp <Esc>a<C-r>=strftime("%Y-%m-%d %H:%M")<CR>
nnoremap [prefix].pt <Esc>a<C-r>=strftime("%H:%M")<CR>
nnoremap [prefix].pd <Esc>a<C-r>=strftime("%Y-%m-%d")<CR>
"
" 拡張 {
" vimでキーマッピングする際に考えたほうがいいこと
" http://deris.hatenablog.jp/entry/2013/05/02/192415
" .vimrc を新しいタブで開く
nnoremap [prefix].. :<C-u>tabedit $MYVIMRC<CR>:lcd $VIMFILES<CR>
"nnoremap [prefix].. :<C-u>tabedit $MYVIMRC<CR>
" .gvimrc を開く
nnoremap [prefix].g :<C-u>tabedit $MYGVIMRC<CR>
let $MYVIMTIPS='~/Dropbox/work/memo/vim-tips'
nnoremap [prefix].> :<C-u>tabedit $MYVIMTIPS<CR>
" .vimrc / .gvimrc 用．保存して再読み込み
nnoremap [prefix]r :<C-u>w<CR>:e %<CR>
nnoremap [prefix].r :<C-u>w<CR>:source %<CR>
nmap [prefix].R <Plug>(quickrun)
" .vimrc の読み込み LN_0x011
command! ReloadVimrc  source $MYVIMRC

" Shift を押す代わりに
nnoremap [prefix];  :<C-u>
" -en-jp 日本語キーボード と違うもの
" 2-@-" 6-^-& 8-*-( 9-(-) 0-)-
"打ちづらいキーの割り当て
function! s:rotate_head()
    let c = col('.')
    normal! ^
    execute (c == col('.')) ? "normal! 0"  : ""
endfunction
" nnoremap  [prefix]h ^
" nnoremap <expr> [prefix]h (virtcol('.') == 1) ? '^' : '0'
" nnoremap <expr> [prefix]h (search('^\s\s*\%#', 'bcn')) ? '^' : '0'
nnoremap <silent> [prefix]h :call <SID>rotate_head()<CR>
nnoremap <expr> 0
            \ match(strpart(getline('.'), 0, col('.') - 1), '^\s\+$') >= 0 ? '0' : '^'


nnoremap  [prefix]l $
nnoremap  [prefix]n *
nnoremap <silent> [prefix]N *#
"gd に同じ かんちがい
vnoremap  [prefix]h *^
vnoremap  [prefix]l $
vnoremap  [prefix]n *
vnoremap <silent> [prefix]N *#
"対応する括弧に移動 "creaver-f
nnoremap [prefix], %
vnoremap [prefix], %
"編集中のファイルのディレクトリに移動 ?? local change
nnoremap [prefix].l :<C-u>lcd %:p:h<CR>
nnoremap [prefix].L :<C-u>cd %:p:h<CR>
nnoremap [prefix].h :<C-u>help<Space>
" 検索結果のハイライトの消去 noh[lsearch]
nnoremap [prefix]./ :nohlsearch<CR>
" 終了
" nnoremap [prefix].q :<C-u>q!<CR>
" 0レジスタを簡易クリップボードにする
" 選択範囲を削除，なんか操作して，貼り付け．みたいな動作
" 削除したさいに 0レジスタに入れるようにする
vnoremap  [prefix]d ygvd
" 0レジスタからの貼付け
nnoremap   [prefix]p "0p
nnoremap   [prefix]P "0P
" 全体をフィルタ
" nnoremap [prefix]= gg<C-v>G=<C-o><C-o>
" noremap [prefix]= gg<C-v>G=<C-o><C-o>

" quick fix LN_0x013
" vimgrep cn cN cp cfirst clast colder cnewer
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-U>cfirst<CR> " 最初へ
nnoremap ]Q :<C-U>clast<CR>  " 最後へ
nnoremap [prefix]qo :<C-U>cope<CR>
nnoremap [prefix]qq :<C-U>cope<CR>
nnoremap [prefix]qc :<C-U>ccl<CR>
nnoremap [prefix]qQ :<C-U>ccl<CR>
nnoremap [prefix]qw :<C-U>cc<CR>
nnoremap [prefix]ql :<C-U>cc<CR>
nnoremap [prefix]qL :<C-U>ll<CR>

" nnoremap [prefix]

" 各種設定をトグル "
nnoremap [toggle] <Nop>
nmap [prefix]t [toggle]
nnoremap [toggle]sp :setl spell!<CR>:setl spell?<CR>
nnoremap [toggle]h :setl hlsearch!<CR>:setl hlsearch?<CR>
nnoremap [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap [toggle]w :setl wrap!<CR>:setl wrap?<CR><S-Del>
nnoremap [toggle]r :setl relativenumber!<CR>:setl relativenumber?<CR><S-Del>
nnoremap [toggle]sc :setl scrollbind!<CR>:setl scrollbind?<CR>

" トグルにしたい
" nnoremap <silent> [toggle]v :setl virtualedit=all<CR>
" nnoremap <silent> [toggle]b :setl virtualedit=block<CR>
nnoremap <expr> [toggle]v (&l:virtualedit == "block") ? ':setl virtualedit=all<CR>' : ":setl virtualedit=block<CR>"
" nnoremap <silent> [toggle]d :setl diff!<CR>:setl diff?<CR>
nnoremap <expr> [toggle]d (&l:diff == 0) ? ":diffthis<CR>" : ":diffoff<CR>""


" 全選択
nnoremap <silent> g<C-A> ggVG
"nnoremap <Tab> >>
"nnoremap <Leader><C-i> <C-i>
"
" emacs 風キーバインド
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips/vim-key-emacs
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>

" inoremap <C-3> <Esc>

" オムニ補完を割り当てる
inoremap <C-S> <C-X><C-O><C-P>
"カーソル一文字単位移動
" inoremap <silent> <C-s> <Left>
" inoremap <silent> <C-d> <Right>
"単語単位移動（行末で止まる必要がない場合）
" inoremap <silent> <C-f> <S-Right>
" inoremap <silent> <C-b> <S-Left>
"行頭 行末
" inoremap <silent> <C-a> <Home>
" inoremap <expr> <C-a> search('^\s\s*\%#', 'bcn') ? "\<C-o>0" : "\<C-o>^"
" inoremap <silent> <C-e> <End>
" http://yosugi.hatenablog.jp/entry/2013/06/29/091345

"カーソル前の文字削除
" inoremap <silent> <BS>  <C-g>u<BS>
" inoremap <silent> <C-h> <C-g>u<C-h>
"カーソル後の文字削除
" inoremap <silent> <Del> <C-g>u<Del>
" inoremap <silent> <C-g> <C-g>u<Del>
"最後に挿入した文字列を挿入
inoremap <silent> <C-z> <C-g>u<C-a>
"現在行をインデント
" inoremap <silent> <Tab>   <C-g>u<C-t>
inoremap <silent> <S-Tab> <C-g>u<C-d>

function! s:set_sticky()
	" Sticky shift in English keyboard.
	inoremap <expr> ;  <SID>sticky_func()
	cnoremap <expr> ;  <SID>sticky_func()
	snoremap <expr> ;  <SID>sticky_func()
	" だめ
	" inoremap <C-;>  ;

	function! s:sticky_func()
			let l:sticky_table = {
									\ ',' : '<', '.' : '>', '/' : '?',
									\ '1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
									\ '6' : '^', '7' : '&', '8' : '*', '9' : '(', '0' : ')', '-' : '_', '=' : '+',
									\ ';' : ':', '[' : '{', ']' : '}', '`' : '~', "'" : "\"", '\' : '|',
									\ }
			let l:special_table = {
									\ "\<ESC>" : "\<ESC>", "\<Space>" : ';', "\<CR>" : ";\<CR>"
									\ }
			if mode() !~# '^c'
					echo 'Input sticky key: '
			endif
			let l:key = nr2char(getchar())
			if l:key =~ '\l'
					return toupper(l:key)
			elseif has_key(l:sticky_table, l:key)
					return l:sticky_table[l:key]
			elseif has_key(l:special_table, l:key)
					return l:special_table[l:key]
			else
					return ';'
			endif
	endfunction
endfunction
function! s:unset_sticky()
	iunmap S
endfunction

call s:set_sticky()
command! S call s:set_sticky()
command! US call s:unset_sticky()

" http://deris.hatenablog.jp/entry/2013/10/19/165137
" うまくいかない
" capslock for US keyboard
let s:capslock_key_set = {
						\ '1': '!',
						\ '2': '@',
						\ '3': '#',
						\ '4': '$',
						\ '5': '%',
						\ '6': '^',
						\ '7': '&',
						\ '8': '*',
						\ '9': '(',
						\ '0': ')',
						\ '-': '_',
						\ '=': '+',
						\ '[': '{',
						\ ']': '}',
						\ ';': ':',
						\ '''': '"',
						\ ',': '<',
						\ '.': '>',
						\ '/': '?',
						\ '`': '~',
						\ ' ': ';',
						\ }
call submode#enter_with('capslock', 'cis', '', ';<Tab>', '<Nop>')
call submode#leave_with('capslock', 'cis', '', '<Tab>')
for s:char in range(char2nr('a'), char2nr('z'))
		call submode#map('capslock', 'cis', '', nr2char(s:char), nr2char(s:char-32))
endfor
unlet s:char
for [s:lhs, s:rhs] in items(s:capslock_key_set)
		call submode#map('capslock', 'cis', '', s:lhs, s:rhs)
endfor
unlet s:lhs
unlet s:rhs
" }

" https://github.com/magicant/settings/blob/8ee13e0af35f0dcb2de19f3bc0ebc89cdc2bfc7a/vimrc#L175-176
" これはダメ
" nmap n /<CR>
" 順方向逆方向を固定
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
"nnoremap n /<CR>zz
"nnoremap N ?<CR>zz
"nnoremap ,n ?<CR>zz
" 変更・入れ替え {
"検索の拡張
" unmap n
" nnoremap n nzz
" nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" nnoremap /  /\v
nnoremap /  /

" http://webtech-walker.com/archive/2009/01/18022957.html
" vnoremap * "zy:let @/ = @z<CR>n
vnoremap * "zy:/<C-r>"<CR>n

" http://vim-jp.org/vim-users-jp/2009/08/31/Hack-65.html
vnoremap z/ <ESC>/\%V

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" 整形 " IndentFormat
nnoremap Q gq
vnoremap <silent> [prefix]Q !indent -linux<CR>gv=
vnoremap <silent> [prefix]= call <SID>IndentFormat()
" Y を D と同じ動作にする
nnoremap Y y$

"Vimの極め方 LN_0x012
" normal モードでは ; : を切り替える．インサートモードではそのまま使える．
" コマンドラインウィンドウがおかしくなる?
nnoremap ;  :
nnoremap :  ;
nnoremap @; @:
nnoremap q; q:
vnoremap ;  :
vnoremap :  ;
vnoremap @; @:
vnoremap q; q:

" コマンドラインモード
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 変更予定
" ダイグラフ
"inoremap <C-k>
" }

"----------------------------
"{
"Vimの便利な画面分割＆タブページと、それを更に便利にする方法
"http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
" 分割したウィンドウの移動	水平分割 垂直分割 次
nnoremap [prefix]ss :<C-u>sp<CR>
nnoremap [prefix]sv :<C-u>vs<CR>
nnoremap [prefix]ww <C-w>w
nnoremap [prefix]wj <C-w>j
nnoremap [prefix]wk <C-w>k
nnoremap [prefix]wl <C-w>l
nnoremap [prefix]wh <C-w>h
" 分割したウィンドウ自体を移動
nnoremap [prefix]wr <C-w>r
nnoremap [prefix]wJ <C-w>J
nnoremap [prefix]wK <C-w>K
nnoremap [prefix]wL <C-w>L
nnoremap [prefix]wH <C-w>H
"バッファ 表示 /移動 / 閉じる
nnoremap [prefix]bs :<C-u>ls<CR>
nnoremap [prefix]bl :<C-u>ls<CR>
nnoremap [prefix]bn :<C-u>bn<CR>
nnoremap [prefix]bp :<C-u>bp<CR>
nnoremap [prefix]bd :<C-u>bd<CR>
nnoremap [prefix]bq :<C-u>bd<CR>
nnoremap [prefix]bzz :<C-u>bd!<CR>
""直前のバッファへの切り替え
nnoremap [prefix]da :<C-u>b#<CR>
"nnoremap [prefix]da :<C-u><C-^><CR>
"タブ移動 / 作成
nnoremap [prefix]sn gt
nnoremap [prefix]sp gT
nnoremap [prefix]st :<C-u>tabnew<CR>
"ウィンドウの大きさ変更
" nnoremap [prefix]w= <C-w>=:vert res l:procol<CR>echo s:procol<CR>
nnoremap [prefix]sO <C-w>=

" prefix s : windows 's'ize change
""ウィンドウを閉じる
nnoremap [prefix]wq :<C-u>q<CR>
""縦横最大化
nnoremap [prefix]wo <C-w>_<C-w>|
""大きさを揃える

" project.vim 用
" nnoremap [prefix]w= <C-w>=<C-w>h:vert res 15<CR>
nnoremap [prefix]w= <C-w>=<C-w>h<C-w>h:vert res 15<CR>
nnoremap [prefix]== :<C-u>call <SID>ProvimCol()<CR>
" project.vimのウィンドウのみ一定幅に残して整える " うまくいかない
function! s:ProvimCol()
		" "     let s:procol = &columns - 15
		"     normal <C-w>=
		"     vert res 15
		" "     execute 'normal <C-w>='
		" "     execute 'vert res 15'
		"     execute 'normal :echo "a"\<CR>'
		normal mx
		execute "normal <C-w>=<C-w>h<C-w>h"
		vert res 15
		normal 'x
endfunction
" 初めての環境でエラーになるので
if ! empty(neobundle#get("calendar.vim"))
		" if &runtimepath =~# ".*vim-submode"
		"vim-submode を使って連続入力する
		" <Space>を[prefix]にするとエラー
		" s size_win
		" モード名,          モードの種類, マップの種類,  マップのlhs, rhs
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>w>' , '<C-w>>')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>w<' , '<C-w><')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>w+' , '<C-w>+')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>w-' , '<C-w>-')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>wl' , '3<C-w>>')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>wh' , '3<C-w><')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>wj' , '3<C-w>+')
		call submode#enter_with('size_win'  , 'n' , '' , '<Space>wk' , '3<C-w>-')
		call submode#map(       'size_win'  , 'n' , '' , '>'         , '<C-w>>')
		call submode#map(       'size_win'  , 'n' , '' , '<'         , '<C-w><')
		call submode#map(       'size_win'  , 'n' , '' , '+'         , '<C-w>+')
		call submode#map(       'size_win'  , 'n' , '' , '-'         , '<C-w>-')
		call submode#map(       'size_win'  , 'n' , '' , 'l'         , '3<C-w>>')
		call submode#map(       'size_win'  , 'n' , '' , 'h'         , '3<C-w><')
		call submode#map(       'size_win'  , 'n' , '' , 'j'         , '3<C-w>+')
		call submode#map(       'size_win'  , 'n' , '' , 'k'         , '3<C-w>-')
		" undo/redo
		call submode#enter_with('undo/redo' , 'n' , '' , 'g-'        , 'g-')
		call submode#enter_with('undo/redo' , 'n' , '' , 'g+'        , 'g+')
		call submode#leave_with('undo/redo' , 'n' , '' , '<Esc>')
		call submode#map('undo/redo'        , 'n' , '' , '-'         , 'g-')
		call submode#map('undo/redo'        , 'n' , '' , '+'         , 'g+')
		" tab
		function! s:SIDP()
				return '<SNR>' . matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SIDP$') . '_'
		endfunction
		function! s:movetab(nr)
				let l:Math = s:V.import('Math')
				execute 'tabmove' l:Math.modulo(tabpagenr() + a:nr - 1, tabpagenr('$'))
		endfunction
		let s:movetab = ':<C-u>call ' . s:SIDP() . 'movetab(%d)<CR>'
		call submode#enter_with('movetab' , 'n' , '' , '<Space>gt' , printf(s:movetab , 1))
		call submode#enter_with('movetab' , 'n' , '' , '<Space>gT' , printf(s:movetab , -1))
		call submode#map('movetab'        , 'n' , '' , 't'         , printf(s:movetab , 1))
		call submode#map('movetab'        , 'n' , '' , 'T'         , printf(s:movetab , -1))
		unlet s:movetab
endif
" }

" Unite関連 MP_UNITE {
nnoremap [unite]    <Nop>
nmap     [prefix]u [unite]
"nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap [unite]<Space>   :<C-u>Unite<Space>
nnoremap <silent> [unite]l   :<C-u>Unite line<CR>
nnoremap <silent> [unite]M   :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u   :<C-u>Unite buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tag<CR>
nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
nnoremap <silent> [unite]m   :<C-u>Unite build:make<CR>
"
nnoremap <silent> [prefix]sT :<C-u>Unite tab<CR>
nnoremap <silent> [prefix]sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap <silent> [prefix]sB :<C-u>Unite buffer -buffer-name=file<CR>
" }

" プラグインに関連 MPP {
" MP_OpenBrowser
nnoremap <Leader>w :<C-u>call <SID>HandleURI()<CR>
"カーソルの下にURLがあればそれを開いてURLがなければ下にある単語を検索エンジンで検索します。
nmap <Leader>w <Plug>(openbrowser-smart-search)


" MP_ESKK
" 入力切り替え
imap <C-j> <Plug>(eskk:toggle)
" 辞書 をひらく
nnoremap [prefix].<C-j> :execute "sp $ESKK_USER_DICT"<CR>
"
" MP_COD
" コマンドラインウィンドウのときの動作がおかしいので，先に閉じる
nnoremap <silent> q: :<C-u>CODClose<CR>q:
nnoremap <silent> q; :<C-u>CODClose<CR>q:
unmap q:
unmap q;
nnoremap <silent> [prefix]oo :<C-u>CODOpen<CR>
nnoremap <silent> [prefix]oc :<C-u>CODClose<CR>
" 選択 して，ノーマルモードに戻ってた後に実行
nnoremap <silent> [prefix]os :CODSelected<CR>
vnoremap <silent> [prefix]ds :CODSelected<CR>
" <C-r><C-w> でカーソル下の単語をコマンドラインウィンドウにコピー
nnoremap <silent> [prefix]kk :<C-u>CODSearch <C-r><C-w><CR>
nnoremap <silent> [prefix]kq :<C-u>CODClose<CR>

" MP_CAW
" コメントアウトの切り替え
nmap <silent> [prefix]c  <Plug>(caw:I:toggle)
nmap <silent> [prefix].c <Plug>(caw:I:comment)
nmap <silent> [prefix].C <Plug>(caw:I:uncomment)
vmap <silent> [prefix]c  <Plug>(caw:I:toggle)
vmap <silent> [prefix].c <Plug>(caw:I:comment)
vmap <silent> [prefix].C <Plug>(caw:I:uncomment)

" nnoremap <silent> [prefix]c  <Plug>(caw:I:toggle)
" nnoremap <silent> [prefix].c <Plug>(caw:I:comment)
" nnoremap <silent> [prefix].C <Plug>(caw:I:uncomment)
" vnoremap <silent> [prefix]c  <Plug>(caw:I:toggle)
" vnoremap <silent> [prefix].c <Plug>(caw:I:comment)
" vnoremap <silent> [prefix].C <Plug>(caw:I:uncomment)

" MP_TAGBAR
nnoremap <silent> [prefix].t :TagbarToggle<CR>

"MP_MAKE
"make を途中まで割り当てる
nnoremap [prefix]m :<C-u>w<CR>:<C-u>Make<Space>

" MP_VIMSHELL
nnoremap [prefix]v :<C-u>VimShell<CR>

" MP_MEMO
" この書き方はダメ
" command! ML :<C-u>MemoList<CR>
command! ML MemoList


" MP_TWEET
nnoremap <silent> [prefix].zs  :<C-u>TweetVimSay<CR>
nnoremap <silent> [prefix].zt  :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent> [prefix].ztm :<C-u>TweetVimMentions<CR>
" }

" http://vim.wikia.com/wiki/Reverse_selected_text
vnoremap [prefix]?ri c<C-O>:se ri<CR><C-r>"<ESC>:se nori<CR>
command! -bar -range Mirror <line1>,<line2>call setline('.', join(reverse(split(getline('.'), '\zs')), ''))
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1

" 無効 {
" 打ち間違えやすいキーを無効
" nnoremap Q  <Nop>
" nnoremap ZQ <Nop>
" nnoremap qq <Nop>
" 矢印キーを禁止する "戻すのは一回終了する
let s:no_cursor = 1
if s:no_cursor == 1
		map <Up> <Nop>
		map <Down> <Nop>
		map <Left> <Nop>
		map <Right> <Nop>
		inoremap <Up> <Nop>
		inoremap <Down> <Nop>
		" <Left>を<Nop>にすると，日本語変換した時に2回挿入される
		"inoremap <Left> <Nop>
		inoremap <Right> <Nop>
		cnoremap <Up> <Nop>
		cnoremap <Down> <Nop>
		"inoremap <Left> <Nop>
		cnoremap <Right> <Nop>
endif
" }
" }}}

" Abbreviate {{{1
" http://blog.ize-serve.net/archive/200903/20090324084210.html
" vim line short
function! s:abb_vim()
  inorea SS "---------------------------------------
  inorea SL "-------------------------------------------------------------------------------
endfunction

function! s:abb_cpp()
  inorea SS //--------------------------------------
  inorea SL //------------------------------------------------------------------------------
  inorea SSS //======================================
  inorea SSL //==============================================================================
  " Vim テクニックバイブル 5-3   数が合わない 77になる"
  inoreabbrev <expr> DL repeat('*', 80 - col('.'))
  inorea AB_CF int Func( ) { }
endfunction

function! s:abb_sh()
  inorea SS #---------------------------------------
  inorea SL #-------------------------------------------------------------------------------
endfunction

function! s:abb_tex()
  inorea TEXI \begin{itemize}<CR>\item <CR>\end{itemize}<CR>
  inorea SS %---------------------------------------
  inorea SL %-------------------------------------------------------------------------------
endfunction
" }}}

" Setting {{{
" set encoding=utf-8
"
set noesckeys
" 文字エンコーディングの自動認識
"https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-utf8
se fencs=utf-8,iso-2022-jp,euc-jp,sjis,utf-16le,ucs-bom
se ffs=unix,dos,mac
" クリップボードを連携
" yank したテキストが無名レジスタだけでなく，*レジスタにも入るようにする
se cb+=unnamed
se ts=2 sw=2
se nu rnu
" 検索系 http://a-newcomer.com/11
se ic scs is hls
se hi=5000
se mmt=128000
" 検索に使うメモリ(KB)
se mm=128000
se nf=hex
se sh=powershell
" define 定義 "C++ 用にする
se def=^\\(#\\s*define\\|[a-z]*\\s*const\\s*[a-z]*\\)
" set include
" se noet ws
" BS=C-h Del i_CTRL-U i_CTRL-W
se bs=indent,eol,start

" tags ファイルの再帰検索
if has('path_extra')
		set tags+=tags;
end

" formatoptions 関連 {
" デフォルト : formatoptions=croql
" 挿入モードで改行した時に # を自動挿入しない
" ノーマルモードで o や O をした時に # を自動挿入しない
"setlocal formatoptions-=r
"setlocal formatoptions-=o
" }
"
"-------------------------------------------------------------------------------
" 日本語切り替え IME の設定 {
" vim テクニックバイッブル 1-10
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control/ibus#TOC-IBus-Python-1.5
" 「日本語入力固定モード」切替キー
let g:IM_CtrlMode = 1
" 自動生成するファイルの保存場所
let g:IM_CtrlIBusPythonFileDir = '~/.ibus'
"inoremap <silent> <C-s> <C-r>=IMState('FixMode')<CR>
" PythonによるIBus制御指定
let g:IM_CtrlIBusPython = 1
" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
set timeout
set timeoutlen=2000
set ttimeoutlen=100

" gvim ibus vi 協調モード
" 括弧を入力した時にカーソルが移動しないように設定
set matchtime=0

" CursorHold の更新間隔
set updatetime=1000

" 移動時に自動的に保存する
" set autowrite

" GVimの時だけ「日本語入力固定モード」のvi協調モードを無効化
"let IM_vi_CooperativeMode = has('gui_running') ? 0 : 1
"set runtimepath+=~/src/master
" なんか効くようになったので解決
" .ibus か ~/bina が原因かな
"}
"-------------------------------------------------------------------------------
" ステータスバー関連 {
"set cmdheight=2
" ステータスバーを設定
set laststatus=2
" 表示項目の設定
" set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3l,%3c,%3p]
"左側の設定
set statusline=
set statusline+=%<%{expand('%:p:t')}\    " 現在のファイル名
set statusline+=%m%r%w
" 「日本語入力固定モード」の状態を表示する
"set statusline+=%{IMStatus('[日本語固定]')}
" なんか遅い
"set statusline+=<%{ibus#is_enabled()?'あ':'aA'}>
" 右側の設定
set statusline+=%=
set statusline+=%2n:%4l,%3c,\     " バッファの数:現在の行,先頭からのバイト数
set statusline+=%y%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}\    " \
"[][エンコード][改行コード]
set statusline+=%L%4p%% 	"全体の行数   %
"set statusline+=%4l,%3c,\ %L%4p%%
" 入力キーの表示 " ステータスラインの設定より後ろに書く必要がある(多分)
set showcmd
"}
"-------------------------------------------------------------------------------
" 色設定 :colorscheme {
" *** mydarkで設定する ***
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
let $MYCOLOR = $VIMFILES . '/colors' . '/mydark.vim'
if filereadable($MYCOLOR)
	if has('gui_running')
		colorscheme mydark
	else
	  colorscheme darkblue
	endif
endif


" Vim テクニックバイブル 10-2
" my-color.vim にまとめとく
"colorscheme my-color
" 設定大変なので取り合えす
"colorscheme torte
"Vim のカラースキームが微妙に気に食わないときの対処法
"http://cohama.hateblo.jp/entry/2013/08/11/020849
"上手く行かない ??
" autocmd ColorScheme * highlight! CusorLine ctermfg=22 guifg=#0088ff
"colorscheme hybrid
augroup status-line
  autocmd!
  au InsertEnter * hi StatusLine guifg=blue guibg=DarkYellow  gui=none ctermfg=Blue ctermbg=Yellow cterm=none
  au InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGrey cterm=none
augroup END
"au ColorScheme * hi CusorLine ctermfg=22 guifg=#0088ff
"---------------------------------------
"
"}
"------------------------------------------------------------
" 他 {
" Vim テクニックバイブル 1-11
"set list listchars=tab:>-,trail:_
" set list だけだと,Tabが1文字になって見づらいので
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,
" http://qiita.com/quenhulu/items/34ff426744a8c20d3604
" expand コマンドで　タブをスペース(8個)を展開できる
" Tab2Space :%!expand -t 4
" Space->Tab :%!unexpand -a or -t 4
command! Space2Tab %!unexpand -t 4
command! Tab2Space %!expand -t 4
" http://nort-wmli.blogspot.jp/2013/05/vim.html
" ファイル全体の場合
" Space -> Tab
" setl expandtab
" [range]retab!
" Tab -> Space
" setl noexpandtab
" retab 4 " tabstop が変更される
"
" スペースをタブに変換する場合
" :set noexpandtab
" :retab 4
" タブをスペースに変換する場合
" :set expandtab
" :retab
"
" :set noexpandtab
" :set tabstop=4
" :set shiftwidth=4
" :set softtabstop=0
"
" retab!


" Vim テクニックバイブル  1-12
"augroup grlcd
"	autocmd!
"	autocmd BufEnter * lcd %:p:h
"augroup EN
""2-10
":lcd %:p:h
"
"Vim テクニックバイブル 5-2
" C-v motion 0 or $ I or A
" visual モードで移動できないところに移動
set virtualedit=block
"normal モードでも移動できるようにする
"set virtualedit=all
"
"
" IME の状態の表示　ibus 1.4.*
" http://bouzuya.hatenablog.com/entry/2012/02/05/214052
" }

" ベル音が大きいからどうにかしたい
" http://vimblog.hatenablog.com/entry/vimrc_set_bell_options
set noeb
set novb
" むり
" set t_vb=^[|10f
" set visualbell t_vb=
" set noerrorbells

augroup persistence-undo
  autocmd!
	au BufWritePre /tmp/* setlocal noundofile
augroup END
"}}}

" Color {{{1
" ターミナルオプション
"   set termcap
" 端末のカラーの設定 "256色を使う
set t_Co=256
" http://superuser.com/questions/436890/cant-copy-to-clipboard-from-vim?answertab=votes#tab-top
set mouse=a
" }}}

" Syntax {{{
" C++ の標準ライブラリへのパス
" $VIM_CPP_INCLUDE_DIR とは別に設定しておく
let $VIM_CPP_STDLIB = "/usr/include/c++/4.6,/usr/local/include,usr/include"
" C++ のインクルードディレクトリ
" 複数の場合は , 区切りで設定
"  $ gcc -print-search-dirs
let $VIM_CPP_INCLUDE_DIR = ".,/usr/include,usr/local/include,/usr/include/boost,/usr/local/include/opencv,/opt/cv/include,/usr/include/flycapture"
" neo_complete の path はどこまで通せばよいか

" :h ft-c-syntax
" コメント内の文字列と数値
let g:c_comment_strings=1
" [] () 内の{}をエラーとして表示しない
"let c_no_curly_error=1
" インクルードディレクトリ
"let s:cpp_include_dirs = expand(exists("$VIM_CPP_INCLUDE_DIR") ? $VIM_CPP_INCLUDE_DIR : '')

" filetype=cpp の設定はこの関数内で行う
" set ではなくて setlocal を使用する
function! CppVimrcOnFileType_cpp()
		"タブ文字の長さ
		setlocal tabstop=2
		setlocal shiftwidth=2
		" 空白文字ではなくてタブ文字を使用する
		"setlocal noexpandtab
		" 空白文字を使用する
		setlocal expandtab
		" 自動インデントを行わない
		setlocal autoindent
		setlocal smartindent
		setlocal cindent
		" 	http://d.hatena.ne.jp/alwei/20111106/1320595940
		setlocal cinoptions+=:0,g0

		" 最後に定義された include 箇所へ移動してを挿入モードへ
		nnoremap <buffer><silent> <Space>ii :execute "?".&include<CR> :noh<CR> o
endfunction

" C++ の設定
" FileType_cpp() 関数が定義されていれば最後にそれを呼ぶ
function! s:cpp()
		" インクルードパスを設定する
		" gf などでヘッダーファイルを開きたい場合に影響する
		let &l:path = join(filter(split($VIM_CPP_STDLIB . "," . $VIM_CPP_INCLUDE_DIR, '[,;]'), 'isdirectory(v:val)'), ',')
		" 括弧を構成する設定に <> を追加する
		" template<> を多用するのであれば
		setlocal matchpairs+=<:>
		" BOOST_PP_XXX 等のハイライトを行う
		syntax match boost_pp /BOOST_PP_[A-z0-9_]*/
		highlight link boost_pp cppStatement
		nnoremap [prefix].d :<C-u>Dox<CR>
		" quickrun.vim の設定
		let b:quickrun_config = {
								\		"hook/add_include_option/enable" : 1
								\	}

		if exists("*CppVimrcOnFileType_cpp")
				call CppVimrcOnFileType_cpp()
		endif
endfunction

augroup ft_vim
		autocmd!
		autocmd FileType vim call s:abb_vim()
augroup END
augroup ft_sh
		autocmd!
		autocmd FileType sh call s:abb_sh()
augroup END
augroup ft_cpp
		autocmd!
		" filetype=cpp が設定された場合に関数を呼ぶ
		autocmd FileType cpp,c call s:cpp()
    " MP_N3337
		autocmd FileType cpp nnoremap <buffer><Space><Space>n
								\ :<C-u>Unite -auto-preview n3337<CR>
		autocmd FileType cpp call s:abb_cpp()
augroup END
augroup ft_txt
		autocmd!
		autocmd FileType txt setl norelativenumber
augroup END
augroup ft_make
		autocmd!
		autocmd FileType make setl list
augroup END
augroup ft_js
		autocmd!
		autocmd FileType javascript setl et ts=2 sw=2 list
augroup END
augroup ft_html
		autocmd!
		autocmd FileType html,xhtml,xml setl et ts=4 sw=4 list
augroup END
augroup ft_python
		autocmd!
		autocmd FileType python setl et ts=4 sw=4 list
augroup END
" 自動的にquickfix-windowを開く LN_0x013
augroup quick_fix
		autocmd!
" 		autocmd QuickFixCmdPost *grep* cwindow
augroup END
" }}}

" Test {{{
" set runtimepath+=~/.vim/account_diary.vim
execute "set runtimepath+=" . $VIMFILES . "/account_diary.vim"
" set runtimepath += $VIMFILES . '/account_diary.vim'

let s:unite_source = { 'name': 'mylines'}
function! s:unite_source.gather_candidates(args, context)
		let mylines = getbufline('#', 1, '$')
		let path = expand('#:p')
		let format = '%' . strlen(len(mylines)) . 'd:%s'
		return map(mylines, '{"word": printf(format, v:key+1, v:val), "source": "mylines",
								\ "kind": "jump_list", "action__path": path, "action__line": v:key+1}')
endfunction

call unite#define_source(s:unite_source)
unlet s:unite_source

let s:unite_source = { 'name': 'lines', }
function! s:unite_source.gather_candidates(args, context)
		let path = expand('#:p')
		echomsg path
		let lines = getbufline('#', 1, '$')
		let format = '%' . strlen(len(lines)) . 'd: %s'
		let l:mymap = map(lines, '{
								\   "word": printf(format, v:key + 1, v:val),
								\   "source": "lines",
								\   "kind": "jump_list",
								\   "action__path": path,
								\   "action__line": v:key + 1,
								\ }')
		return mymap
endfunction

" 整形 " IndentFormat
if has('unix')
	function! IndentFormat() range
			!indent - linux
			normal =
	endfunction
	command! -count -nargs=1 IndentFormat
endif
" }}}

" Tips {{{
" TI_0x000
"  vimrcなしで起動
"  vim -u NONE -N
" TI_0x001
"  pathと suffixesadd に gf で開く検索パスと拡張子を設定できる
" TI_0x002
"  let &g:tabstop = 8 と set tabstop =8 は同じ
"  let &l:tabstop = 8 と setlocal tabstop =8 は同じ
"  http://ppworks.hatenablog.jp/entry/sendagayarb25
" TI_0x003
"  zt or z<CR>  " top にスクロールする
"  zz or z. " 現在の位置が中止になるようにスクロール
"  zb or z- " bottom にスクロール
" TI_0x004
"  http://d.hatena.ne.jp/vimtaku/20121117/1353138802
"  nnoremap : q:a
"  nnoremap / q/a
"  q/ q: q? でコマンドライン履歴ウィンドウとかが開く
"  そこで，aで挿入モードに入ってコマンド打って<CR>
" TI_0x005
"  リーダーキーの変更
"  <Leader> \
"  let mapleader = ","
" TI_0x005
"  Expression レジスタ
"  =repeat('*', 80 - virtcol('.'))<CR>p
" TI_0x006
"  インクリメント<C-a>の設定
"  英字，8進，16進
"  set nrformats =alpha,hex,octal
" TI_0x007
"  キーワード補完 	C-p or C-n
"  局所キーワード  	C-x C-p
"  オムニ			C-x C-o
"  辞書				C-x C-k
"  パスパターン		C-x C-i
"  ファイル名		C-x C-i
"  clang complete	C-x C-u
" TI_0x008
"  csv の2番目でソート
"  :'<,'>!sort -t, -k 2
" TI_0x009
"  SNR の確認 :scriptnames
" TI_0x00a
"  tags
"  ソート付き
"  :!ctags --sort=foldcase -R .
"  set tags?
"  tags=./tags,./TAGS,tags,TAGS
" TI_0x00b
"  zR zr zA za zm zM
" TI_0x00c
"  複数の拡張子から
"  vimgrep /XXX/ *.glade *.h *.cpp
"  サブディレクトリも
"  vimgrep /XXX/ **/*.cpp
"  QuickFix に結果を足す
"  bufdo vimgrepadd /buttonOk/ %
" TI_0x00c
"  QuickFix をクリア
"  :cexpr ""
" TI_0x00d
"  レコーディング=マクロ
"}}}

" Link {{{1
" LN_0x000 http://saihoooooooo.hatenablog.com/entry/2013/12/02/122005
" LN_0x001 http://rhysd.hatenablog.com/entry/2013/12/10/233201
" LN_0x002 http://d.hatena.ne.jp/osyo-manga/20131219/1387465034 https://github.com/osyo-manga/cpp-vimrc/blob/master/vimrc
" LN_0x003 http://pragprog.com/titles/dnvim/source_code
" LN_0x004 http://d.hatena.ne.jp/wiredool/20120618/1340019962#20120618f1
" LN_0x005 http://qiita.com/rbtnn/items/39d9ba817329886e626b
" LN_0x006 http://nanasi.jp/articles/code/encode/scriptencoding.html
" LN_0x007 http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
" LN_0x008 https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control https://github.com/fuenor/im_control.vim
" LN_0x009 http://cocopon.me/blog/?p=841
" LN_0x00a http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" LN_0x00b http://d.hatena.ne.jp/thinca/20091031/1257001194 http://vim-jp.org/vim-users-jp/2009/07/10/Hack-39.html
" LN_0x00c htp://d.hatena.ne.jp/shunsuk/20110508/1304865150
" LN_0x00d http://haya14busa.com/mastering-vim-easymotion/
" LN_0x00e http://d.hatena.ne.jp/osyo-manga/20110210/1297328933 http://yuttie.hatenablog.jp/entry/2014/02/11/151610 http://qiita.com/yuttie/items/29abeb925196ab2f0d86 http://d.hatena.ne.jp/osyo-manga/20130903/1378217305
" LN_0x00f http://d.hatena.ne.jp/ampmmn/20090129/1233242044
" LN_0x010 http://lingr.com/room/vim/archives/2012/12/07 http://d.hatena.ne.jp/alwei/20111029/1319905783
" LN_0x011 http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" LN_0x012 http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" LN_0x013 http://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b
" }}}
"
" Todo {{{1
"  <Space>. でタイムアウト / ESC するとコマンドが実行される
"  imap,cmap の充実
"  再読み込みでvimrcにする
"    mappingの初期化
"  Python の設定
"  Windows との共用
"  function はどこに書けば良いのか
" -------------------------------------------------------------------------------
" 修正済
" 0x のインクリメントを直す
" 日本語を変換する変換すると2個2個打たれる打たれる
" vmap が効かない効かない　コメント切り替え
"}}}
"
" http://qiita.com/jnchito/items/5141b3b01bced9f7f48f
" http://g1g0.com/2012/02/1769/

let g:gaa = ''
let g:title = '初めてのVim'

function! T2()
	let list =  split(g:title,'\zs')
	for s in list
		call T1(s)
	endfor
endfunction

function! T1(s)
		let g:gaa .= a:s
		call setline(1, g:gaa)
		sleep 1
		redraw
endfunction

func! TR()
	let str = "\"ABCDEF"
	let strlist = [ '"', 'A', 'B', 'C', 'D', 'E', 'F',
	            \   '"', 'A', 'B', 'C', 'D', 'E', 'F',
	            \   '"', 'A', 'B', 'C', 'D', 'E', 'F']
	for s in strlist
		sleep 500m
		redraw
		echo s
		let str = getline(1)
		let str .= s
		call setline(1, str)
	endfor
endfunc


func! Bo()
	let line = getline('.')
	if line =~# 'NeoBundle'
.\+ ['|"]\(\w\+\/\w\+[|\.vim]\)['|"]
		line
	endif
endfunc


func! EchoNum()
	let lnum = 1
	while lnum <= 100
		echo lnum
		let lnum += 1
	endwhile
endfunc

":new | redraw | echo "there is a new window"

" ----------------------------------------------------------------------------------
scriptencoding utf-8
let seion = [
\ [
\ [ '',   '',  'k',  's',  't',  'n',  'h',  'f',  'm',  'y',  'r',  'w',  'g',  'z',  'd',  'b',  'p',  ],
\ [ 'a', 'あ', 'か', 'さ', 'た', 'な', 'は', '',   'ま', 'や', 'ら', 'わ', 'が', 'ざ', 'だ', 'ば', 'ぱ', ],
\ [ 'i', 'い', 'き', 'し', 'ち', 'に', 'ひ', '',   'み', '',   'り', '',   'ぎ', 'じ', 'ぢ', 'び', 'ぴ', ],
\ [ 'u', 'う', 'く', 'す', 'つ', 'ぬ', 'ふ', 'ふ', 'む', 'ゆ', 'る', '',   'ぐ', 'ず', 'づ', 'ぶ', 'ぷ', ],
\ [ 'e', 'え', 'け', 'せ', 'て', 'ね', 'へ', '',   'め', '',   'れ', '',   'げ', 'ぜ', 'で', 'べ', 'ぺ', ],
\ [ 'o', 'お', 'こ', 'そ', 'と', 'の', 'ほ', '',   'も', 'よ', 'ろ', 'を', 'ご', 'ぞ', 'ど', 'ぼ', 'ぽ', ], ] ,
\ [
\ [ ' ', 'z'   , ],
\ [ 'c', 'ざ'  , ],
\ [ 'v', 'ざい', ],
\ [ 'x', 'ぜい', ],] ,
\ [
\ [ '',     'k',    's',    't',    'n',    'h',    'f',      'm',    'y',    'r',  'w',      ],
\ [ 'z', 'かん', 'さん', 'たん', 'なん', 'はん', 'ふぁん', 'まん', 'やん', 'らん',  'わん',   ],
\ [ 'n', 'かん', 'さん', 'たん', 'ん',   'はん', 'ふぁん', '',     'やん', 'らん',  'わん',   ],
\ [ 'k', 'きん', 'しん', 'ちん', 'にん', 'ひん', 'ふぃん', 'みん', '',     'りん',  'うぃん', ],
\ [ 'j', 'くん', 'すん', 'つん', 'ぬん', 'ふん', 'ふん',   'むん', 'ゆん', 'るん',  '',       ],
\ [ 'd', 'けん', 'せん', 'てん', 'ねん', 'へん', 'ふぇん', 'めん', '',     'れん',  'うぇん', ],
\ [ 'l', 'こん', 'そん', 'とん', 'のん', 'ほん', 'ふぉん', 'もん', 'よん', 'ろん',  'うぉん', ],
\ [ 'q', 'かい', 'さい', 'たい', 'ない', 'はい', 'ふぁい', 'まい', 'やい', 'らい',  'わい',    ],
\ [ 'h', 'くう', 'すう', 'つう', 'ぬう', 'ふう', 'ふう',   'むう', 'ゆう', 'るう',  '',        ],
\ [ 'w', 'けい', 'せい', 'てい', 'ねい', 'へい', 'ふぇい', 'めい', '',     'れい',  '',        ],
\ [ 'p', 'こう', 'そう', 'とう', 'のう', 'ほう', 'ふぉー', 'もう', 'よう', 'ろう',  'うぉー',  ], ],
\ [
\ [ '' , 'g',    'z',    'd',    'b',    'p',     ],
\ [ 'z', 'がん', 'ざん', 'だん', 'ばん', 'ぱん',  ],
\ [ 'n', 'がん', 'ざん', 'だん', 'ばん', 'ぱん',  ],
\ [ 'k', 'ぎん', 'じん', 'ぢん', 'びん', 'ぴん',  ],
\ [ 'j', 'ぐん', 'ずん', 'づん', 'ぶん', 'ぷん',  ],
\ [ 'd', 'げん', 'ぜん', 'でん', 'べん', 'ぺん',  ],
\ [ 'l', 'ごん', 'ぞん', 'どん', 'ぼん', 'ぽん',  ],
\ [ 'q', 'がい', 'ざい', 'だい', 'ばい', 'ぱい',  ],
\ [ 'h', 'ぐう', 'ずう', 'づう', 'ぶう', 'ぷう',  ],
\ [ 'w', 'げい', 'ぜい', 'でい', 'べい', 'ぺい',  ],
\ [ 'p', 'ごう', 'ぞう', 'どう', 'ぼう', 'ぽう',  ], ],
\ [
\ [ '',  'ky',     'kg',     'sy',     'x',      'ty',     'c',      'ny',     'ng',     'hy',     'hg',     'my',     'mg',     'ry',      ],
\ [ 'a', 'きゃ',   'きゃ',   'しゃ',   'しゃ',   'ちゃ',   'ちゃ',   'にゃ',   'にゃ',   'ひゃ',   'ひゃ',   'みゃ',   'みゃ',   'りゃ',    ],
\ [ 'u', 'きゅ',   'きゅ',   'しゅ',   'しゅ',   'ちゅ',   'ちゅ',   'にゅ',   'にゅ',   'ひゅ',   'ひゅ',   'みゅ',   'みゅ',   'りゅ',    ],
\ [ 'e', 'きぇ',   'きぇ',   'しぇ',   'しぇ',   'ちぇ',   'ちぇ',   'にぇ',   'にぇ',   'ひぇ',   'ひぇ',   'みぇ',   'みぇ',   'りぇ',    ],
\ [ 'o', 'きょ',   'きょ',   'しょ',   'しょ',   'ちょ',   'ちょ',   'にょ',   'にょ',   'ひょ',   'ひょ',   'みょ',   'みょ',   'りょ',    ],
\ [ 'z', 'きゃん', 'きゃん', 'しゃん', 'しゃん', 'ちゃん', 'ちゃん', 'にゃん', 'にゃん', 'ひゃん', 'ひゃん', 'みゃん', 'みゃん', 'りゃん',  ],
\ [ 'n', 'きゃん', 'きゃん', 'しゃん', 'しゃん', 'ちゃん', 'ちゃん', 'にゃん', 'にゃん', 'ひゃん', 'ひゃん', 'みゃん', 'みゃん', 'りゃん',  ],
\ [ 'j', 'きゅん', 'きゅん', 'しゅん', 'しゅん', 'ちゅん', 'ちゅん', 'にゅん', 'にゅん', 'ひゅん', 'ひゅん', 'みゅん', 'みゅん', 'りゅん',  ],
\ [ 'd', 'きぇん', 'きぇん', 'しぇん', 'しぇん', 'ちぇん', 'ちぇん', 'にぇん', 'にぇん', 'ひぇん', 'ひぇん', 'みぇん', 'みぇん', 'りぇん',  ],
\ [ 'l', 'きょん', 'きょん', 'しょん', 'しょん', 'ちょん', 'ちょん', 'にょん', 'にょん', 'ひょん', 'ひょん', 'みょん', 'みょん', 'りょん',  ],
\ [ 'q', 'きゃい', 'きゃい', 'しゃい', 'しゃい', 'ちゃい', 'ちゃい', 'にゃい', 'にゃい', 'ひゃい', 'ひゃい', 'みゃい', 'みゃい', 'りゃい',  ],
\ [ 'h', 'きゅう', 'きゅう', 'しゅう', 'しゅう', 'ちゅう', 'ちゅう', 'にゅう', 'にゅう', 'ひゅう', 'ひゅう', 'みゅう', 'みゅう', 'りゅう',  ],
\ [ 'w', 'きぇい', 'きぇい', 'しぇい', 'しぇい', 'ちぇい', 'ちぇい', 'にぇい', 'にぇい', 'ひぇい', 'ひぇい', 'みぇい', 'みぇい', 'りぇい',  ],
\ [ 'p', 'きょう', 'きょう', 'しょう', 'しょう', 'ちょう', 'ちょう', 'にょう', 'にょう', 'ひょう', 'ひょう', 'みょう', 'みょう', 'りょう',  ], ],
\ [
\ [  '',  'gy',     'zy',     'j',      'by',     'py',     'pg',      ],
\ [  'a', 'ぎゃ',   'じゃ',   'じゃ',   'びゃ',   'ぴゃ',   'ぴゃ',    ],
\ [  'u', 'ぎゅ',   'じゅ',   'じゅ',   'びゅ',   'ぴゅ',   'ぴゅ',    ],
\ [  'e', 'ぎぇ',   'じぇ',   'じぇ',   'びぇ',   'ぴぇ',   'ぴぇ',    ],
\ [  'o', 'ぎょ',   'じょ',   'じょ',   'ぴょ',   'ぴょ',   'ぴょ',    ],
\ [  'z', 'ぎゃん', 'じゃん', 'じゃん', 'びゃん', 'ぴゃん', 'ぴゃん',  ],
\ [  'n', 'ぎゃん', 'じゃん', 'じゃん', 'びゃん', 'ぴゃん', 'ぴゃん',  ],
\ [  'j', 'ぎゅん', 'じゅん', 'じゅん', 'びゅん', 'ぴゅん', 'ぴゅん',  ],
\ [  'd', 'ぎぇん', 'じぇん', 'じぇん', 'びぇん', 'ぴぇん', 'ぴぇん',  ],
\ [  'l', 'ぎょん', 'じょん', 'じょん', 'びょん', 'ぴょん', 'ぴょん',  ],
\ [  'q', 'ぎゃい', 'じゃい', 'じゃい', 'びゃい', 'ぴゃい', 'ぴゃい',  ],
\ [  'h', 'ぎゅう', 'じゅう', 'じゅう', 'びゅう', 'ぴゅう', 'ぴゅう',  ],
\ [  'w', 'ぎぇい', 'じぇい', 'じぇい', 'びぇい', 'ぴぇい', 'ぴぇい',  ],
\ [  'p', 'ぎょう', 'じょう', 'じょう', 'びょう', 'ぴょう', 'ぴょう',  ], ],
\ [
\ [  '',  'f',    'v',    'tg',   'dc',   'w',    'ws',   'l',  'ly',  ],
\ [  'a', 'ふぁ', 'ヴぁ', '',     '',     '',     '',     'ぁ', 'ゃ',  ],
\ [  'i', 'ふぃ', 'ヴぃ', 'てぃ', 'でぃ', 'うぃ', '',     'ぃ', '',    ],
\ [  'u', '',     'ヴ',   'とぅ', 'どぅ', '',     '',     'ぅ', 'ゅ',  ],
\ [  'e', 'ふぇ', 'ヴぇ', '',     '',     'うぇ', '',     'ぇ', '',    ],
\ [  'o', 'ふぉ', 'ヴぉ', '',     '',     '',     'うぉ', 'ぉ', 'ょ',  ], ],
\ ]

" \ [ 'っ',';' ],
" \ [ 'ん','q' ],
" \ [ 'ー','-' ],
" \ [ 'ー',':' ],
" \ ]

" \ [ 'n', 'かん', 'さん', 'たん', 'ん',   'はん', 'ふぁん', 'もの', 'やん', 'らん',  'わん',    ], ],
" '<,'>s/\s\zs[^ ]\+/'&',/g

func! SetAzikRom(...)
	let child = [ 'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z', ]
	let azik_list = [ ['a', 'あ'], ['i', 'い'], ['u', 'う'], ['e', 'え'], ['o', 'お'], ]
  for c in child
		for cl in Echo50(c)
			call add(azik_list, cl)
		endfor
	endfor
	let special = [
	 \ ['kt', 'こと'],  ['st', 'した'],  ['tt', 'たち'],  ['ht', 'ひと'],
	 \ ['wt', 'わた'],  ['mn', 'もの'],  ['ms', 'ます'],  ['ds', 'です'],
	 \ ['km', 'かも'],  ['tm', 'ため'],  ['dm', 'でも'],  ['kr', 'から'],
	 \ ['sr', 'する'],  ['tr', 'たら'],  ['nr', 'なる'],  ['yr', 'よる'],
	 \ ['rr', 'られ'],  ['zr', 'ざる'],  ['mt', 'また'],  ['tb', 'たび'],
	 \ ['nb', 'ねば'],  ['bt', 'びと'],  ['gr', 'がら'],  ['gt', 'ごと'],
	 \ ['nt', 'にち'],  ['dt', 'だち'],  ['wr', 'われ'], ]
  for s in special
		call add(azik_list, s)
	endfor
	" ソート
	let azik_list = sort(azik_list)
	" 片仮名変換
	let azik_list_kata = []
	for el in  azik_list
		let k_st = ChangeHiraToKata(el[1])
		let l = [el[0], k_st]
		call add(azik_list, l)
		echo l
	endfor
	" Print
" 	for s in  sort(azik_list)
	for s in  azik_list
		echo s
	endfor
" 	for s in  azik_list_kata
" 		echo s
" 	endfor
endfunc

func! Echo50(ch)
	let st_azik = []
	for ol in g:seion
		let c=0
		while c < len(ol[0])
			if ol[0][c][0] == a:ch
" 				echo c
				break
			endif
			let c+=1
		endwhile
		if c != len(ol[0])
			for l in ol[1:]
				if l[c] != ''
					let st_z = []
					call add(st_z, ol[0][c] . l[0])
					call add(st_z, l[c])
					call add(st_azik, st_z)
				endif
			endfor
		endif
	endfor
" 	for s in st_azik
" 		echo s
" 	endfor
	return st_azik
endfunc

func! ChangeHiraToKata(h_st)
	let table = GetTableHiraToKata()
	let t_hira = []
	for e in table
		call add(t_hira, e[0])
	endfor
	let list_st = split(a:h_st,'\zs')
	let k_st = ''
	for c in split(a:h_st,'\zs')
		let i = match(t_hira, c)
		if i != -1
			let k_st .= table[i][1]
		endif
	endfor
	return k_st
endfunc

func! GetTableHiraToKata()
"ぁ 33439
"あ 33440 82a0
"ァ 33600
"ア 33601 8341
	let a=0x829f
	let pair_hira_kata=[]
	for i in range(83)
" 		echo "\u82a0"
" 		exe 'echo "\u' . a . '"'
	 " echo printf("echo \"\\u%x\"", a + i)
		let h =  nr2char(a+i)
		let k =  nr2char(a+i+161)
		echo printf("%d %s %s %x %x",i,h,k,(a+i), a+i+161)
		let l = [h,k]
		call add(pair_hira_kata, l)
	endfor
" 	echo pair_hira_kata
	return pair_hira_kata
endfunc

" 拗音、拗音互換
"
"
"
" 拗音 (外来語、他)
"   f    v    tg   dc   w    ws   l  ly
" a ふぁ ヴぁ                     ぁ ゃ
" i ふぃ ヴぃ てぃ でぃ うぃ      ぃ
" u ふ   ヴ   とぅ どぅ           ぅ ゅ
" e ふぇ ヴぇ           うぇ      ぇ
" o ふぉ ヴぉ           を   うぉ ぉ ょ
"
" 拗音については撥音拡張、二重母音拡張、撥音互換キーが原則通り適用される。（表は省略）
"
" 促音、撥音、長音符
"   促音（っ） ；（セミコロン）キー
"   撥音（ん） q キー
"   長音（ー） －（マイナス） または ：（コロン）キー
"
" 特殊拡張
" KT こと  ST した  TT たち  HT ひと
" WT わた  MN もの  MS ます  DS です
" KM かも  TM ため  DM でも  KR から
" SR する  TR たら  NR なる  YR よる
" RR られ  ZR ざる  MT また  TB たび
" NB ねば  BT びと  GR がら  GT ごと
" NT にち  DT だち  WR われ

"b
"by
"c
"d
"dc
"f
"g
"gy
"h
"hg
"hy
"j
"k
"kg
"ky
"l
"ly
"m
"mg
"my
"n
"ng
"ny
"p
"pg
"py
"r
"ry
"s
"sy
"t
"tg
"ty
"v
"w
"ws
"x
"y
"z
"zy


