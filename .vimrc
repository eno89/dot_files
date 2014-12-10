"-------------------------------------------------------------------------------
" OS : Ubuntu 12.04
" kbd : HHKB (英語)
" Vim : 7.4.347
"  ./configure --with-features=huge --enable-gui=gnome2 --enable-perlinterp
"  --enable-pythoninterp  --enable-python3interp --enable-rubyinterp
"  --enable-luainterp  --with-luajit --enable-fail-if-missing
"
"-------------------------------------------------------------------------------
" 参考にしたもの
"
" Vim の構築 {{{
" vimにluajitを対応させてみた作業ログ
" http://saihoooooooo.hatenablog.com/entry/2013/12/02/122005
" }}}

" Vim でC++ {{{
" Vim で C++ を書くときの逆引きリファレンス
" http://rhysd.hatenablog.com/entry/2013/12/10/233201
" Vim で C++ のコーディングを行うAdd Starfa11enprince
" http://d.hatena.ne.jp/osyo-manga/20131219/1387465034
" それのgit
" https://github.com/osyo-manga/cpp-vimrc/blob/master/vimrc
" }}}
"
"-------------------------------------------------------------------------------
" 実践Vim メモ
" Pragmatic Bookshelf
" http://pragprog.com/titles/dnvim/source_code
" vim -u NONE -N
" path, suffixesadd
"
"-------------------------------------------------------------------------------
" .vimrc で書きたいこと
"   環境が正しいか
"     git のインストールがあるか
"     NeoBundle がインストールされていなかったらインストールする
"      " 上手く行かない
"   初期化
"   プラグインの設定
"   set などの設定
"   Map の設定
"   C++  include ファイルを開く
"
"   http://blog.papix.net/entry/2011/12/08/130431
"
"-------------------------------------------------------------------------------
"	Problem 問題点
"	 <Space>. でタイムアウト / ESC するとコマンドが実行される
"-------------------------------------------------------------------------------
" .vimrc の書き順について
"	" 最小限の初期化
"	Init
" 	" プラグインの設定
" 	Plugin
" 	" Init 以外の設定
" 	Basic
" 	"
" 	Mapping
" 	"
" 	Color
" 	GUI/Terminal
" 	" 実際の処理
" 	Main
"-------------------------------------------------------------------------------
" let &g:tabstop = 8 と set tabstop =8 は同じ
" let &l:tabstop = 8 と setlocal tabstop =8 は同じ
"-------------------------------------------------------------------------------
"

" 初期設定 Init {{{
" ファイルタイプをoff にしておく
" http://d.hatena.ne.jp/wiredool/20120618/1340019962#20120618f1
" NeoBundle 内で 行うのでコメントアウト
" http://qiita.com/rbtnn/items/39d9ba817329886e626b
" filetype off
" filetype plugin indent off
"スクリプト内で日本語を使う場合
"http://nanasi.jp/articles/code/encode/scriptencoding.html
scriptencoding utf-8
" .vimrc に書く必要性は無いのでコメントアウト
" set nocompatible
"}}}

" プラグインの読み込み
if !executable("git")
    echo "Please install git." . " Reboot Vim."
    finish
endif

let s:neobundle_plugins_dir =  '~/.vim/bundle'
" 一度だけ読まれる設定
if has('vim_starting')
    " neobundle.vim がインストールするプラグインへのパス
    " neobundle.vim もこのディレクトリにインストールが行われる
    " neobundle.vim を runtimepath に加える
    "	execute "set runtimepath+=" . s:neobundle_plugins_dir . "/neobundle.vim"
endif

" NeoBundle が存在するか
if (isdirectory(s:neobundle_plugins_dir . "/neobundle.vim") ) == 1
    "echo "Please install neobundle.vim."
    " NeoBundle のインストール
    function! s:install_neobundle()
        if input("Install neobundle.vim? [Y/N] : ") == "Y"
            if isdirectory(s:neobundle_plugins_dir) == 1
                :all mkdir(s:neobundle_plugins_dir, "p")
            endif
            execute "!git clone git://github.com/Shougo/neobundle.vim "
                        \ . s:neobundle_plugins_dir . "/neobundle.vim"
            echo "neobundle installed. Please restart vim."
        else
            echo "Canceled."
        endif
    endfunction
    augroup install-neobundle
        autocmd!
        autocmd VimEnter * call s:install_neobundle()
    augroup END
    finish
endif


" Mapping
" ショートカッ卜の設定
vnoremap [prefix] <Nop>
vmap     <Space> [prefix]
nnoremap [prefix] <Nop>
nmap     <Space> [prefix]

execute "set runtimepath+=" . s:neobundle_plugins_dir . "/neobundle.vim"
" NeoBundle の初期化
call neobundle#begin(s:neobundle_plugins_dir)
"neobundle.vim 自体を管理する
NeoBundleFetch 'Shougo/neobundle.vim'
" Use neobundle standard recipes.
"NeoBundle 'Shougo/neobundle-vim-recipes'
"
"-----------------------------
"
"AddNeoBundle
"日本語ヘルプ
NeoBundle 'vim-jp/vimdoc-ja'
"かぶるけど追加
" NeoBundle 'Align'  "テキスト整形
" http://nanasi.jp/articles/vim/align/align_vim.html
"" Alignを日本語環境で使用するための設定
" 時間がかかる
" let g:Align_xstrlen=3
"テキスト整形
NeoBundle 'h1mesuke/vim-alignta'

" Align -r .=  " +=,= などが混ざってる場合

"
NeoBundle 'vim-jp/vital.vim'

"Vimの便利な画面分割＆タブページと、それを更に便利にする方法
"http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
NeoBundle 'kana/vim-submode'

" http://d.hatena.ne.jp/itchyny/20120609/1339249777
"NeoBundle 'Lokaltog/vim-powerline'
" http://d.hatena.ne.jp/itchyny/20130824/1377351527
" NeoBundle 'itchyny/lightline.vim'
"
" http://qiita.com/soramugi/items/7014c866b705e2cd0b95
"NeoBundle 'szw/vim-tags'
"
" 日本語IME
" Vim/GVimで「日本語入力固定モード」を使用する
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control
" https://github.com/fuenor/im_control.vim
NeoBundle 'fuenor/im_control.vim'

" 色設定
" http://cocopon.me/blog/?p=841
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'jpo/vim-railscasts-theme'
"NeoBundle 'altercation/vim-colors-solarized'
"
"日本語表示
"NeoBundle 'bouzuya/vim-ibus'
"
" http://easyramble.com/how-to-use-surround-vim.html
NeoBundle 'surround.vim'
NeoBundle 'tpope/vim-speeddating'

" 新型スカウターを開発した
" http://d.hatena.ne.jp/thinca/20091031/1257001194
" http://vim-jp.org/vim-users-jp/2009/07/10/Hack-39.html
NeoBundle 'thinca/vim-scouter'


NeoBundle 'glidenote/memolist.vim'
"let g:memolist_path = "
"
NeoBundleLazy 'kannokanno/previm' , { 'autoload' : { 'filetypes' : 'markdown' } }

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"カーソル行のURLをブラウザで開く {{{
"htp://d.hatena.ne.jp/shunsuk/20110508/1304865150
"URIを開くプラグイン
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
nnoremap <Leader>w :<C-u>call <SID>HandleURI()<CR>
"カーソルの下にURLがあればそれを開いてURLがなければ下にある単語を検索エンジンで検索します。
nmap <Leader>w <Plug>(openbrowser-smart-search)

"
NeoBundle "Shougo/vimproc"
" 汎用的なコード補完プラグイン
NeoBundle "Shougo/neocomplete.vim"
" unite.vim
NeoBundle "Shougo/unite.vim"
" アウトラインの出力
NeoBundle "Shougo/unite-outline"
" 最近使ったファイル  most recursive use
NeoBundle "Shougo/neomru.vim"
"
NeoBundle "Shougo/vimshell.vim"
" N3337
NeoBundle "rhysd/unite-n3337"
" キャッシュ消したら，上手く動いた
let g:unite_n3337_pdf = $HOME . "/.vim/pdf/n3337.pdf"
"let g:unite_n3337_txt = $HOME . "/.vim/bundle/unite-n3337/n3337.txt"

NeoBundle "ujihisa/unite-locate"
NeoBundle "osyo-manga/unite-quickfix"

NeoBundle "tsukkee/unite-tag"
NeoBundle "tsukkee/unite-help"


NeoBundle "mattn/webapi-vim"
NeoBundle "mattn/excitetranslate-vim"
" http://www.absolute-keitarou.net/blog/?p=1239
NeoBundle "mattn/unite-mcdonalds-vim"

" http://daisuzu.hatenablog.com/entry/2013/12/22/153834
NeoBundle "daisuzu/translategoogle.vim"

NeoBundle "tyru/caw.vim"

NeoBundle "VOoM"

NeoBundle "rbtnn/vimconsole.vim"

NeoBundle "vim-scripts/DoxygenToolkit.vim"
" Dox...

let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"

augroup UniteN3337
    autocmd!
    autocmd FileType cpp nnoremap <buffer><Space><Space>n
                \ :<C-u>Unite -auto-preview n3337<CR>
augroup END

" unite
" インサートモードで開始
" let g:unite_enable_start_inseert = 1 " 廃止 ?
" Start insert mode in unite-action buffer.
"call unite#custom#profile('default', 'context', {  'start_insert' : 1 })

"
NeoBundle "Shougo/vimfiler.vim"
let g:vimfiler_as_default_explorer = 1

" Vim-Easymotionを拡張してカーソルを縦横無尽に楽々移動する
" http://haya14busa.com/vim-lazymotion-on-speed/
" 非推奨になったのでコメントアウト
" NeoBundle 'haya14busa/vim-easymotion'
" http://blog.remora.cx/2012/08/vim-easymotion.html
" ホームポジションに近いキーを使う
"""let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
"""" leaser を マッピング  (default <\Leader><\Leader>)
"""" 1 ストローク選択を優先する
"""let g:EasyMotion_grouping=1
"""" カラー設定変更
""""hi EasyMotionTarget ctermbg=none ctermfg=red
""""hi EasyMotionShade  ctermbg=none ctermfg=blue
" Vim-EasyMotionでカーソル移動を爆速にして生産性をもっと向上させる
"  http://haya14busa.com/mastering-vim-easymotion/
NeoBundle 'Lokaltog/vim-easymotion'
" リーダーキーから<Prefix>f に変更する
let g:EasyMotion_leader_key="`"
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbASDFGHJKL;'
" let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCV;'
"潰れるキー  b e f ge j k n s t w
" 'で主に使うキー a q y p

" C++ シンタックス
NeoBundleLazy "vim-jp/cpp-vim" , { 'autoload' : { 'filetypes' : 'cpp' } }

" 補完
""NeoBundleLazy 'Valloric/YouCompleteMe', {
""      \ 'build' : {
""      \   'mac' : './install.sh --clang-completer',
""      \   'unix' : './install.sh --clang-completer',
""      \ }
""      \ }

"
"NeoBundle 'Shougo/neosnippet'


" http://d.hatena.ne.jp/osyo-manga/20110210/1297328933
" http://yuttie.hatenablog.jp/entry/2014/02/11/151610
" http://qiita.com/yuttie/items/29abeb925196ab2f0d86
" http://d.hatena.ne.jp/osyo-manga/20130903/1378217305
"
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ }

" http://d.hatena.ne.jp/ampmmn/20090129/1233242044
" 重い 登録が失敗する -> できた
NeoBundle 'vim-scripts/cursoroverdictionary'
" CODRegistDict ~/src/eijiro-fpw/PDIC_1LINE/EIJI-136.txt
" 156M  EIJI-136.TXT 112M  REIJI136.TXT  3.7M  RYAKU136.TXT  233M  WAEI-136.TXT

" http://blog.craftgear.net/50165b2c048026831d000002/title/ref.vimのalcがなくなったので
" は上手く行かない

"NeoBundle 'thinca/vim-ref'

NeoBundle 'vim-jp/vim-sweep_trail'


" NeoBundle 'vim-scripts/project.vim'

"------------------------------------
" eskk.vim
"------------------------------------
" http://lingr.com/room/vim/archives/2012/12/07
" http://d.hatena.ne.jp/alwei/20111029/1319905783
NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/skkdict.vim'
" ime を無効化
"set imdisable
let $ESKK_DIR = expand("$HOME/.vim/eskk/")
let $ESKK_USER_DICT = $ESKK_DIR ."eskk_jisyo"
" "{{{
let g:eskk#debug = 0
" let g:eskk#egg_like_newline = 1
"let g:eskk#revert_henkan_style = "okuri"
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
imap <C-j> <Plug>(eskk:toggle)
" 辞書 をひらく
nnoremap [prefix].<C-j> :execute "sp $ESKK_USER_DICT"<CR>
" "}}}

call neobundle#end()
filetype plugin indent on
syntax enable

" インストールのチェック
NeoBundleCheck


"-------------------------------------------------------------------------------
" Plugin {{{
" C++ 関連の補完などの設定，vimrc.osyo-manga を読み込む {{{

" プラグインの設定前に呼ばれる関数
" プラグインを無効にしたい場合など時に使用する
function! CppVimrcPrePlugin()
    " プラグインを無効にする場合
    " 	NeoBundleDisable neocomplete.vim
endfunction

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

"}}}

"
" vimrc の読み込み
"source <sfile>:h/vimrc
" シンボリックリンクしてあってずれるかもしれないので，パスにしておく
"source $HOME/initfiles/vimrc.osyo-manga

"}}}

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
" }}}


"-------------------------------------------------------------------------------
" clang setting

"let g:clang_periodic_quickfix = 1
let g:clang_periodic_quickfix = 0
let g:clang_complete_copen = 1
"let g:clang_use_library = 1

" this need to be updated on llvm update
" libclang.so とかがあるフォルダのパス
let g:clang_library_path = '/usr/lib/llvm-3.4/lib'
" specify compiler options
"let g:clang_user_options = '-std=c++11 -stdlib=libc++'

"-------------------------------------------------------------------------------

" <Leader> \
" let mapleader = ","
"-------------------------------------------------------
" マッピング  :Mapping {{{
" map : キーシーケンスを展開した後，さらに別のマップを適用とする
" noremap : 一度だけ展開
" nmap / imap / cmap / vmap /
" map(ノーマルモードとビジュアルモード) / map!(挿入とコマンドライン)
"
"半年育てた.vimrcを眺める
" http://a-newcomer.com/11
"-------------------------------------------------------------------------------
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"
"help map-overview
" コマンド	 	ノーマル ビジュアル+選択 演算待ち状態
"	map   			@	    	@		   	@
"	nmap  			@	     	-		    -
"	vmap  			-			@		 	-
"	omap  		 	-	     	-		  	@
" コマンド 	 	ビジュアル  選択
"	vmap  			@        @
"	xmap  			@        -
"	smap  			-	     @
"
" map noremap umap mapclear
" map nmap vmap xmap smap omap map! imap lmap cmap
"
"-------------------------------------------------------------------------------
"
" <C-u> コマンドラインの入力を削除
"
" .vimrc を新しいタブで開く
nnoremap [prefix].. :<C-u>tabedit $MYVIMRC<CR>:lcd ~/initfiles<CR>
"nnoremap [prefix].. :<C-u>tabedit $MYVIMRC<CR>
" .gvimrc を開く
nnoremap [prefix].g :<C-u>tabedit $MYGVIMRC<CR>
" .vimrc / .gvimrc 用．保存して再読み込み
nnoremap [prefix].r :<C-u>w<CR>:source %<CR>
" .vimrc の読み込み
" http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
command! ReloadVimrc  source $MYVIMRC
"Vimの極め方
"http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" normal モードでは ; : を切り替える．インサートモードではそのまま使える．
"" ; よく使うので，コメントアウト
" nnoremap ;  :
" nnoremap :  ;
" Shift を押す代わりに
nnoremap [prefix];  :<C-u>
"
" Unite関連
" vimでキーマッピングする際に考えたほうがいいこと
" http://deris.hatenablog.jp/entry/2013/05/02/192415
nnoremap [unite]    <Nop>
nmap     [prefix]u [unite]
"nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]<Space>   :<C-u>Unite<Space>
nnoremap <silent> [unite]l   :<C-u>Unite line<CR>
nnoremap <silent> [unite]m   :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u   :<C-u>Unite buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tag<CR>
nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
" Unite関連
nnoremap [prefix]sT :<C-u>Unite tab<CR>
nnoremap [prefix]sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap [prefix]sB :<C-u>Unite buffer -buffer-name=file<CR>
"
"打ち間違えやすいキーを無効
"nnoremap Q  <Nop>
"nnoremap ZQ <Nop>
"nnoremap qq <Nop>

" 整形 " IndentFormat
nnoremap Q gq
vnoremap <silent> [prefix]Q !indent -linux<CR>gv=
vnoremap <silent> [prefix]= call <SID>IndentFormat()

"打ちづらいキーの割り当て
noremap  [prefix]h ^
noremap  [prefix]l $
noremap  [prefix]n *
noremap  [prefix]N #
"対応する括弧に移動 parenthesis
noremap [prefix]p %
" コメントアウトの切り替え
" ?? vmap で効かない
nmap [prefix]c  <Plug>(caw:I:toggle)
vmap [prefix]c  <Plug>(caw:I:toggle)
nmap [prefix].c <Plug>(caw:I:comment)
vmap [prefix].c <Plug>(caw:I:comment)
nmap [prefix].C <Plug>(caw:I:uncomment)
vmap [prefix].C <Plug>(caw:I:uncomment)
"編集中のファイルのディレクトリに移動 ?? local change
nnoremap [prefix].l :<C-u>lcd %:p:h<CR>
nnoremap [prefix].L :<C-u>cd %:p:h<CR>
nnoremap [prefix].h :<C-u>help<Space>
"
" 検索結果のハイライトの消去 noh[lsearch]
nnoremap [prefix]./ :nohlsearch<CR>

" cursoroverdictionary
" コマンドラインウィンドウのときの動作がおかしいので，先に閉じる
noremap <silent> q: :CODClose<CR>q:
"  オープン
noremap <silent> [prefix]oo :CODOpen<CR>
"  Close
noremap <silent> [prefix]oc :CODClose<CR>
" 選択 して，ノーマルモードに戻ってた後に実行
nnoremap <silent> [prefix]os :CODSelected<CR>
"vnoremap <silent> [prefix]ds :CODSelected<CR>
" <C-r><C-w> でカーソル下の単語をコマンドラインウィンドウにコピー
noremap <silent> [prefix]k :<C-u>CODSearch <C-r><C-w><CR>

"make を途中まで割り当てる
noremap [prefix]m :<C-u>w<CR>:<C-u>make<Space>

" オムニ補完を割り当てる
inoremap <C-s> <C-x><C-o><C-p>

" 0レジスタを簡易クリップボードにする
" 選択範囲を削除，なんか操作して，貼り付け．みたいな動作
" 削除したさいに 0レジスタに入れるようにする
vnoremap  [prefix]d ygvd
" 0レジスタからの貼付け
noremap   [prefix]p "0p

" Y を D と同じ動作にする
noremap Y y$

" 全体をフィルタ
" nnoremap [prefix]= gg<C-v>G=<C-o><C-o>
" noremap [prefix]= gg<C-v>G=<C-o><C-o>

" quick fix
"http://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b
"vimgrep
" :cn :cN :cp :cfirst :clast
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ
nnoremap [prefix]qo :<C-u>cope<CR>
nnoremap [prefix]qq :<C-u>cope<CR>
nnoremap [prefix]qc :<C-u>ccl<CR>
nnoremap [prefix]qQ :<C-u>ccl<CR>
nnoremap [prefix]qw :<C-u>cc<CR>
nnoremap [prefix]ql :<C-u>cc<CR>
nnoremap [prefix]qL :<C-u>ll<CR>
" colder cnewer

" 終了
" nnoremap [prefix].q :<C-u>q!<CR>

"------------------------------------------------------------
"矢印キーを禁止する
let s:no_cursor = 0
"if exists('s:no_cursor')
if s:no_cursor == 1
    map <Up> <Nop>
    map <Down> <Nop>
    map <Left> <Nop>
    map <Right> <Nop>
    inoremap <Up> <Nop>
    inoremap <Down> <Nop>
    " <Nop>にすると，日本語変換した時に2回挿入される
    "inoremap <Left> <Nop>
    inoremap <Right> <Nop>

    ""noremap  <Left>  <Nop>
    ""	noremap  <Right> <Nop>
    ""	noremap  <Down>  <Nop>
    ""	noremap  <Up>    <Nop>
    "	inoremap <Left>  <Nop>
    "	inoremap <Right> <Nop>
    "	inoremap <Down>  <Nop>
    "	inoremap <Up>    <Nop>
    "else
    "	noremap  <Left>  <Left>
    "	noremap  <Right> <Right>
    "	noremap  <Down>  <Down>
    "	noremap  <Up>    <Up>
    "	inoremap <Left>  <Left>
    "	inoremap <Right> <Right>
    "	inoremap <Down>  <Down>
    "	inoremap <Up>    <Up>
endif

" インサートモードで移動する
let s:insert_mode_move = 0
if s:insert_mode_move == 1
    " inoremap <silent> <C-h> <Left>
    " inoremap <silent> <C-j> <Right>
    " inoremap <silent> <C-k> <Down>
    " inoremap <silent> <C-l> <Up>
    " cnoremap <C-h> <Left>
    " cnoremap <C-j> <Right>
    " cnoremap <C-k> <Down>
    " cnoremap <C-l> <Up>
    "
    " 	inoremap <silent> <C-h> <C-o>h
    " 	inoremap <silent> <C-j> <C-o>j
    " 	inoremap <silent> <C-k> <C-o>k
    " 	inoremap <silent> <C-l> <C-o>l
endif

"----------------------------
"Vimの便利な画面分割＆タブページと、それを更に便利にする方法
"http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
"nnoremap <Space>s <Nop>
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
" nnoremap [prefix]w= <C-w>=:vert res l:procol<CR>echo s:procol<CR>
nnoremap [prefix]sO <C-w>=
"vim-submode を使って連続入力する
" <Space>を[prefix]にするとエラー

" 初めての環境でエラーになるので
if &runtimepath =~# ".*vim-submode"
    " s size_win
    " モード名、モードの種類、 マップの種類、 マップのlhs, rhs
    call submode#enter_with('size_win', 'n', '', '<Space>w>', '<C-w>>')
    call submode#enter_with('size_win', 'n', '', '<Space>w<', '<C-w><')
    call submode#enter_with('size_win', 'n', '', '<Space>w+', '<C-w>+')
    call submode#enter_with('size_win', 'n', '', '<Space>w-', '<C-w>-')
    call submode#enter_with('size_win', 'n', '', '<Space>wl', '3<C-w>>')
    call submode#enter_with('size_win', 'n', '', '<Space>wh', '3<C-w><')
    call submode#enter_with('size_win', 'n', '', '<Space>wj', '3<C-w>+')
    call submode#enter_with('size_win', 'n', '', '<Space>wk', '3<C-w>-')
    call submode#map('size_win', 'n', '', '>', '<C-w>>')
    call submode#map('size_win', 'n', '', '<', '<C-w><')
    call submode#map('size_win', 'n', '', '+', '<C-w>+')
    call submode#map('size_win', 'n', '', '-', '<C-w>-')
    call submode#map('size_win', 'n', '', 'l', '3<C-w>>')
    call submode#map('size_win', 'n', '', 'h', '3<C-w><')
    call submode#map('size_win', 'n', '', 'j', '3<C-w>+')
    call submode#map('size_win', 'n', '', 'k', '3<C-w>-')
    " undo/redo
    call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
    call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
    call submode#leave_with('undo/redo', 'n', '', '<Esc>')
    call submode#map('undo/redo', 'n', '', '-', 'g-')
    call submode#map('undo/redo', 'n', '', '+', 'g+')
    " タブ
    function! s:SIDP()
        return '<SNR>' . matchstr(expand('<sfile>'), '<SNR>\zs\d+\ze_SIDP$') . '_'
    endfunction
    function! s:movetab(nr)
        execute 'tabmove' g:V.modulo(tabpagenr() + a:nr - 1, tabpagenr('$'))
    endfunction
    let s:movetab = ':<C-u>call ' . s:SIDP() . 'movetab(%d)<CR>'
    call submode#enter_with('movetab', 'n', '', '<Space>gt', printf(s:movetab, 1))
    call submode#enter_with('movetab', 'n', '', '<Space>gT', printf(s:movetab, -1))
    call submode#map('movetab', 'n', '', 't', printf(s:movetab, 1))
    call submode#map('movetab', 'n', '', 'T', printf(s:movetab, -1))
    unlet s:movetab
endif

"-----------------------------------------------------
" 自作関数 {{{
" 構文チェック用
function! s:Gcc()
    :w
    :!g++ %
    ":!g++ % -o %.out
    ":!%.out
endfunction
" command! Gcc call s:Gcc()
command! Gcc call <SID>Gcc()
"}}}



"-------------------------------------------------------------------------------
"" 短縮コマンド abbreviate  mabbreviate {{{
" http://blog.ize-serve.net/archive/200903/20090324084210.html
" vim line short
inorea VS "---------------------------------------
inorea VL "-------------------------------------------------------------------------------
inorea CS //--------------------------------------
inorea CL //------------------------------------------------------------------------------
inorea CCS //======================================
inorea CCL //==============================================================================
inorea SS #---------------------------------------
inorea SL #-------------------------------------------------------------------------------
inorea AB_CF int Func( ) { }
"---------------------------------------
inorea TEXI \begin{itemize}<CR>\item <CR>\end{itemize}<CR>
"---------------------------------------
"" Vim テクニックバイブル 5-3
" 数が合わない 77になる
inoreabbrev <expr> DL repeat('*', 80 - col('.'))
" Expression レジスタ
" "=repeat('*', 80 - virtcol('.'))<CR>p
"}}}

"-------------------------------------------------------------------------------
" 基本設定 BasicSetting {{{
" 文字エンコーディングの自動認識
"https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-utf8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8,utf-16le
set fileformats=unix,dos,mac
" クリップボードを連携
" yank したテキストが無名レジスタだけでなく，*レジスタにも入るようにする
"set clipboard+=unnamed,unnamedplus
set clipboard +=unnamed
"set clipboard+=unnamedplus
" タブを表示するときの幅 (default 8)
set tabstop=4
" インデント時に使用するスペースの幅 (default 8)
set shiftwidth=4
" 行番号の表示
set number
" 行番号の相対表示
set relativenumber
" 折り返して表示する
set wrap
" 基本設定2 {{{
" 検索系 :search {{{
" http://a-newcomer.com/11
" 大文字小文字はデフォルトは無視にする
set ignorecase
" 大文字が含めた場合はそのとおり検索する
set smartcase
" インクリメンタルサーチを行う
set incsearch
" コマンドラインの履歴を増やす (default 20)
set history=2000
" 検索時にハイライトする
set hlsearch

" 検索に使うメモリ(KB) (1BM -> 128MB)
set maxmempattern=128000
"}}}

" define 定義 "C++ 用にする
set def=^\\(#\\s*define\\|[a-z]*\\s*const\\s*[a-z]*\\)

" '[i', ']I', '[d'
"set include

" formatoptions 関連 {{{
" デフォルト : formatoptions=croql
" 挿入モードで改行した時に # を自動挿入しない
" ノーマルモードで o や O をした時に # を自動挿入しない
"setlocal formatoptions-=r
"setlocal formatoptions-=o
" }}}
"
"-------------------------------------------------------------------------------
" 日本語切り替え IME の設定 {{{
" vim テクニックバイッブル 1-10
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control/ibus#TOC-IBus-Python-1.5
" 「日本語入力固定モード」切替キー
let IM_CtrlMode = 1
" 自動生成するファイルの保存場所
let IM_CtrlIBusPythonFileDir = '~/.ibus'
"inoremap <silent> <C-s> <C-r>=IMState('FixMode')<CR>
" PythonによるIBus制御指定
let IM_CtrlIBusPython = 1
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
"}}}
"-------------------------------------------------------------------------------
"" ステータスバー関連 {{{
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
"}}}
"-------------------------------------------------------------------------------
" 色設定 :colorscheme {{{
" *** mydarkで設定する ***
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
"`colorscheme mydark
colorscheme darkblue
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
au InsertEnter * hi StatusLine guifg=blue guibg=DarkYellow  gui=none ctermfg=Blue ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGrey cterm=none
"au ColorScheme * hi CusorLine ctermfg=22 guifg=#0088ff
"}}}
"------------------------------------------------------------
" 他 {{{
" Vim テクニックバイブル 1-11
"set list listchars=tab:>-,trail:_
" set list だけだと,Tabが1文字になって見づらいので
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,
" http://qiita.com/quenhulu/items/34ff426744a8c20d3604
" expand コマンドで　タブとスペース(8個)を変換できる
" Tab2Space :%!expand -t 4
" Space->Tab :%!unexpand -a or -t 4
" ファイル全体の場合
" Space -> Tab
" setl expandtab
" [range]retab!
" Tab -> Space
" setl noexpandtab
" retab 4 " tabstop が変更される
"
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
" }}}
"}}}

setlocal expandtab

"-------------------------------------------------------------------------------
" Tips {{{
" http://ppworks.hatenablog.jp/entry/sendagayarb25
"zt or z<CR>  " top にスクロールする
"zz or z. " 現在の位置が中止になるようにスクロール
"zb or z- " bottom にスクロール
"
"" http://d.hatena.ne.jp/vimtaku/20121117/1353138802
" nnoremap : q:a
" nnoremap / q/a
" q/ q: q? でコマンドライン履歴ウィンドウとかが開く
" そこで，aで挿入モードに入ってコマンド打って<CR>
"}}}

"メモ {{{
"Vim でわかってないこと
"タグジャンプでファイル間の移動ができるのか
"Unite の使い方
"出力の grep や検索
"レコード周辺
"コマンドラインでのコピペや移動
" vglobal g! v inverse
" help の intro と develop と tips を読む
"}}}

" TODO {{{
"0x のインクリメントを直す
" 日本語を変換する変換すると2個2個打たれる打たれる
" vmap が効かない効かない　コメント切り替え
"}}}

" Vim script と vimrc の正しい書き方
"http://www.slideshare.net/cohama/vim-script-vimrc-nagoyavim-1
" set cursorline!
" set cursorline&
" 全選択
nnoremap g<C-a> ggVG
"nnoremap <Tab> >>
"nnoremap <Leader><C-i> <C-i>

"" コマンドラインでのカーソル移動
"" http://stackoverflow.com/questions/6920943/navigating-in-vims-command-mode
"" <C-B> cursor to beginning of comand line
"" <C-E> cursor to end of comand line
"" <C-H> or <BS> Delete the character
"" <C-W> Delete word
"" <C-U> Delte all
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>
"cnoremap <C-p> <Up>
"cnoremap <C-n> <Down>
"cnoremap <C-b> <Left>
"cnoremap <C-f> <Right>
"cnoremap <M-b> <S-Left>


" ホームディレクトリのファイル構成
" http://nanasi.jp/articles/howto/user-manual/user-manual-user-dir.html
"(Linux) 環境
"$HOME/
"├─ .vimrc           vimエディタ設定ファイル（共通）
"├─ .gvimrc          vimエディタ設定ファイル（GUI用）
"├─ .viminfo         履歴情報などがvimエディタによって格納される。環境移行時などには消してもほぼ問題ないファイル。
"└─ .vim/             vimエディタの設定ファイルディレクトリ
"   ├─ filetype.vim  ファイル名パターンごとに、ファイルタイプを設定したい場合に用意する。
"   ├─ scripts.vim   ファイルのデータによって、ファイルタイプを設定したい場合に用意する。
"   ├─ colors/       カラースキーマ用のファイルは、このディレクトリに入れる。
"   ├─ doc/          ドキュメント用のディレクトリ。
"   ├─ ftplugin/     ファイルタイププラグイン用のディレクトリ。
"   ├─ indent/       インデントスクリプト用のディレクトリ。
"   ├─ plugin/       プラグイン用のディレクトリ。このサイトで紹介しているプラグインは、大抵このディレクトリに入れると動作する。
"   ├─ syntax/       シンタックスファイル用のディレクトリ。
"   └─ after/        このディレクトリ以下のスクリプトは、システムのスクリプトが読み込まれた後、読み込まれる。
"      ├─ftplugin
"      ├─indent/
"      └─ ....
"-------------------------------------------------------

" vimコマンド出力をクリップボードへコピー {{{
" http://d.hatena.ne.jp/hide04/20111223/1324621495
" map をクリップボードへコピーするには,3つのコマンドを実行
"	 :redir @*>
"	 :silent map
"	 :redir END
"	 "*p
" 上を矩形選択して(<C-v>，レジスタに入れて("yy)，それをマクロとして実行(@y)
"
func! s:func_copy_cmd_output(cmd)
    redir @">
    silent execute a:cmd
    redir END
endfunc
command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)


" tips
" :g/serch-word/d or :g/serch-word/normal dd
" :v/serch-word/d or :g!/serch-word/d " grep -v --invert-match
" :g//d とかすると全開検索した結果に対して削除ができる
"
" Vimでパターン検索するなら知っておいたほうがいいこと
" http://deris.hatenablog.jp/entry/2013/05/15/024932
" Hack #55: 正規表現のメタ文字の扱いを制御する
" http://vim-jp.org/vim-users-jp/2009/08/11/Hack-55.html
nnoremap /  /\v
" magic .*^$ <--> \をつけるもの ()|+?
" magic /\(foo\|bar\)
" very magic /\v(foo|bar)
" very nomagic \V
" 末尾がaを探す
"	/\va$
" 先頭がaを探す
" 	/\v^a
"


" Vimで現在日時を自動的に挿入する方法
" http://d.hatena.ne.jp/hyuki/20130714/vim
" i<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><CR>
" command! PutDateTime <Esc>i<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
" コマンドでやると失敗する
" キーを割り当て
nnoremap [prefix].pp <Esc>i<C-r>=strftime("%Y-%m-%d %H:%M")<CR>
nnoremap [prefix].pt <Esc>i<C-r>=strftime("%H:%M")<CR>
nnoremap [prefix].pd <Esc>i<C-r>=strftime("%Y-%m-%d")<CR>
"日付を挿入
"http://homepage3.nifty.com/keuch/cat_vim.html
command! PutDateTime r!date +\%Y-\%m-\%d\ \%H:\%M
command! PutDate r!date +\%Y-\%m-\%d

"
"function! Scouter(file, ...)
"  let pat = '^\s*$\|^\s*"'
"  let lines = readfile(a:file)
"  if !a:0 || !a:1
"    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
"  endif
"  return len(filter(lines,'v:val !~ pat'))
"endfunction
"command! -bar -bang -nargs=? -complete=file Scouter
"\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
"
"
"intro.jax
"		移動先のモード					    ~
"		Normal	Visual	Select	Insert	  Replace   Cmd-line  Ex ~
"現在のモード								 ~
"ノーマル		v V ^V	  *4	 *1	   R gR     : / ? !   Q
"ビジュアル	 *2		  ^G	 c C	    --	      :       --
"選択		 *5	^O ^G		 *6	    --	      --      --
"挿入		 <Esc>	  --	  --		  <Insert>    --      --
"置換		 <Esc>	  --	  --	<Insert>	      --      --
"コマンドライン	 *3	  --	  --	 :start	    --		      --
"Ex		 :vi	  --	  --	 --	    --	      --
"*1 ノーマルモードから挿入モードへは、コマンド "i"、"I"、"a"、"A"、"o"、"O"、
"   "c"、"C"、"s"、"S" で入ります。
"*2 ビジュアルモードからノーマルモードへは非移動コマンドで入れますが、そのコマ
"   ンドは実行されてしまいます。<Esc>、"v"、"V"、"CTRL-V" (|v_v|を参照) を入力
"   すれば、副作用なしにビジュアルモードから出られます。
"*3 コマンドラインモードからノーマルモードへ移行するには次のようにします:
"   - <CR> か <NL> を入力する。入力途中のコマンドは実行されます。
"   - 行の全てを削除し (例、CTRL-Uを使う)、そして、<BS> を入力する。
"   - CTRL-C または <Esc> を入力する、入力途中のコマンドを実行せずに終了できま
"     す。
"   最後の方法ですが、<Esc> が 'wildchar' に設定されている場合があります。その
"   場合、コマンドライン補完が実行されますが、それを無視して、再び <Esc> を入力
"   してください。{Vi では、<Esc> を入力すると、そのコマンドラインが実行されま
"   す。これは多くの人が期待するような動作ではないので、Vim では変更されまし
"   た。しかし、その <Esc> がマップの一部であるような場合には、コマンドラインは
"   実行されます。<Esc> を入力したときに、Vi と同じように動作して欲しいときは、
"   ":cmap ^V<Esc> ^V^M" を使ってください}
"*4 ノーマルモードから選択モードに移行するには次のようにします:
"   - 'selectmode' が "mouse" を含んでいるときは、マウスでテキストを選択する。
"   - 'selectmode' が "key" を含んでいるときは、シフトキーを押しながら、特殊
"     キーでカーソルを動かします。(:set keymodel+=startsel が必要)
"   - 'selectmode' が "cmd" を含んでいるときは、"v"、"V"、"CTRL-V" を使う。
"   - "gh"、"gH"、"g CTRL-H" を使う。|g_CTRL-H|
"*5 選択モードからノーマルモードに移行するには、シフトキーを押さずに特殊キーで
"   カーソルを動かします。(:set keymodel+=stopsel が必要)
"*6 選択モードから挿入モードへ移行するには、印字可能文字 (普通の文字) を入力し
"   ます。選択範囲は削除され、入力した文字が挿入されます。
"


" @a
" 単語を\vert++で囲む surround.vim ver
" ysiw+i\vert?kbb
" qaysiw+i\vertq
" マクロだけでもできる
" qjdiWi\vert++<ESC>Pq



" http://www.mazn.net/blog/2009/01/06/170.html
" oldxxxnew  .... oldooonew を置換する
" :%s/\vold(.*)new/new\1new/g
"  文全体を使う場合は & を使う
" :%s/\vold(.*)new/new&new/g
"   最短マッチにならない
" http://d.hatena.ne.jp/JDX/20100213/1266025131
" /\vold.{-}new
"
" http://blog.kjirou.net/p/75
" vimで改行を超えて置換する
" aaa111
" 222bbb
" ccc333
" 444ddd
" :s/\d\+\n\d\+/@@@/c
" /\v\d+\n\d\+
"
" foo bar fizz bizz foo bar fizz bizz foo bar fizz bizz
"
"vimで行末の空白を除去
" http://taiwadou.com/726
" vimのヘルプファイルの12.7に書いてあるのをみつけました。
" :%s/\s\+$//g

" clipboard
"  xclip: --help: No such file or directory
"  [n-inoue@uva vim]$ xclip -h
"  Usage: xclip [OPTION] [FILE]...
"  Access an X server selection for reading or writing.
"
"    -i, -in          read text into X selection from standard input or files
"                     (default)
"    -o, -out         prints the selection to standard out (generally for
"                     piping to a file or program)
"    -l, -loops       number of selection requests to wait for before exiting
"    -d, -display     X display to connect to (eg localhost:0")
"    -h, -help        usage information
"        -selection   selection to access ("primary", "secondary", "clipboard" or "buffer-cut")
"        -noutf8      don't treat text as utf-8, use old unicode
"        -silent      errors only, run in background (default)
"        -quiet       run in foreground, show what's happening
"        -verbose     running commentary
"
"  Report bugs to <astrand@lysator.liu.se>
"  [n-inoue@uva vim]$ xclip -selection
"  xclip: -selection: No such file or directory
"  [n-inoue@uva vim]$ xclip -o -selection
"   caw di"  o O p P y r u <C-r> marks jumps C-3 C-[ C-h C-m zt zz zb map
"  [n-inoue@uva vim]$ xclip -o -selection primary
"   caw di"  o O p P y r u <C-r> marks jumps C-3 C-[ C-h C-m zt zz zb map
"  [n-inoue@uva vim]$ xclip -o -selection secondary
"  [n-inoue@uva vim]$ xclip -o -selection clipboard
"  http://taiwadou.com/726[n-inoue@uva vim]$
"  [n-inoue@uva vim]$ xclip -o -selection buffer-cut
"  q{0-9a-zA-Z"}	[n-inoue@uva vim]$

" :redir @*>
" :silent map
" :silent map!
" :redir END
" redir @*>
" set clipboard
" redir END
" "*p
"    clipboard=autoselect,exclude:cons\|linux,unnamed
" x11-selection
" この 3 つの内、Vim は "* レジスタを読み書きするときにはプライマリを使う (X11
" セレクションが利用可能なとき、Vim は |'clipboard'| にデフォルトとして
" "autoselect" を設定する)。"+ レジスタを読み書きするときにはクリップボードを
" 使う。Vim はセカンダリを使わない。
" http://cohama.hateblo.jp/entry/20130108/1357664352
"
" http://superuser.com/questions/436890/cant-copy-to-clipboard-from-vim?answertab=votes#tab-top
" set mouse=v
set mouse=a

" changes.jax
"レジスタには 9 種類ある:				*registers* *E354*
"1. 無名レジスタ ""
"2. 10個の番号付きレジスタ "0 から "9
"3. 小削除用レジスタ "-
"4. 26個の名前付きレジスタ "a から "z または "A から "Z
"5. 4個の読み取り専用レジスタ ": と ". と "% と "#
"6. expression 用レジスタ "=
"7. 選択領域用レジスタ "* と "+ と "~
"8. 消去専用レジスタ "_
"9. 最終検索パターン用レジスタ "/


"直前のコマンドを実行する
":<C-u><C-r>:<CR> "@:"に等しい 一度@:した後は @@ で繰り返せる

" Vim からみた Emacs
" http://www.slideshare.net/Shougo/vimemacs
"
" 「Vimrcリーディングに役立ちそうな」vimrcの設定とplugin管理
" http://www.slideshare.net/gu4/vimrcvimrcplugin
"
"Vim,vi,ex,sed,そしてed
" http://taiwadou.com/733



" 入力キーの表示 " ステータスラインの設定より後ろに書く必要がある(多分)
set showcmd

" 縦に連番を入力する
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips#TOC-12
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber
            \ let cl = col('.') | for nc in range(1, <count>?<count>-line('.'):1)|
                \ exe 'normal! j'.nc.<q-args>|call cursor('.', cl)|endfor|unlet cl|unlet snf
" <C-a> の際にどうインクリメントさせるか "16進のみ，英字，8進は使わない
" set nrformats =alpha,hex,octal
set nrformats =hex



"---------------------------------------
" ターミナルオプション
"   set termcap
" 端末のカラーの設定 "256色を使う
set t_Co=256
"---------------------------------------


" 文字化けした時，文字コードを変えて開き直す
" e ++enc=sjis
" 保存時の，フォーマットを変える
" set fileencoding=utf-8
" 改行コードの変更
" set fileformat=unix
" 読み取り専用を外す
" set noreadonly

" tags
" :!ctags -R
" set tags=
"  tags=./tags,./TAGS,tags,TAGS
" q:
"  redir @"
"  set tags
"  redir END
" G<CR>
"  C-] カーソル位置のタグにジャンプ
"  C-t 直前のタグに踊る
"  g C-] 複数候補に対して
"  C-w } カーソル位置の単語の定義を開く
"  C-w C-z プレビューウィンドウを閉じる :pc
"
"	http://akito.wiki.fc2.com/wiki/vim
"	変数の定義に移動
"		gd 				ローカル変数定義に移動
"		[d 				defineの値コマンドバーに表示
"	関数へ移動
"		Ctrl + ]   		関数先に移動
"		Ctrl + t   		元に戻る
"		Ctrl + w + ]	Windowを分割して移動
"  インクルードファイルを開く
"   gf
"  vi-difference vi_diff

" unipared.vim
"

" :e ++enc=utf-8

" GUI 用の設定について
" http://d.hatena.ne.jp/yayugu/20110918/1316363220


"-------------------------------------------------------------------------------
" 各拡張子に対する設定
"
" C++ の標準ライブラリへのパス
" $VIM_CPP_INCLUDE_DIR とは別に設定しておく
let $VIM_CPP_STDLIB = "/usr/include/c++/4.6,/usr/local/include,usr/include"
" C++ のインクルードディレクトリ
" 複数の場合は , 区切りで設定
"  $ gcc -print-search-dirs
let $VIM_CPP_INCLUDE_DIR = ".,/usr/include,usr/local/include,/usr/include/boost,/usr/local/include/opencv,/opt/cv/include"
" neo_complete の path はどこまで通せばよいか

" :h ft-c-syntax
" コメント内の文字列と数値
let c_comment_strings=1
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

" " http://d.hatena.ne.jp/osyo-manga/20120205/1328368314
" " neocomplcache が作成した tag ファイルのパスを tags に追加する
" function! s:TagsUpdate()
"     " include している tag ファイルが毎回同じとは限らないので毎回初期化
"     setlocal tags=
"     for filename in neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
"         execute "setlocal tags+=".neocomplcache#cache#encode_name('tags_output', filename)
"     endfor
" endfunction
"
" command! -nargs=? PopupTags call <SID>TagsUpdate() | Unite tag:<args>
"
" function! s:get_func_name(word)
"     let end = match(a:word, '<\|[\|(')
"     return end == -1 ? a:word : a:word[ : end-1 ]
" endfunction
"
"
" " カーソル下のワード(word)で絞り込み
" noremap <silent> g<C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>
"
" " カーソル下のワード(WORD)で ( か < か [ までが現れるまでで絞り込み
" " 例)
" " boost::array<std::stirng... → boost::array で絞り込み
" noremap <silent> G<C-]> :<C-u>execute "PopupTags "
"     \.substitute(<SID>get_func_name(expand('<cWORD>')), '\:', '\\\:', "g")<CR>


" cpp に関する設定
augroup vimrc-cpp
    autocmd!
    " filetype=cpp が設定された場合に関数を呼ぶ
    autocmd FileType cpp call s:cpp()
    autocmd FileType c call s:cpp()
augroup END

" キーワード補完 	C-p or C-n
" 局所キーワード  	C-x C-p
" オムニ			C-x C-o
" 辞書				C-x C-k
" パスパターン		C-x C-i
" ファイル名		C-x C-i
" clang complete	C-x C-u


" プラグイン案
" - 行数を 上下 が nH nL で移動できる数はその数で表示する
" - 翻訳用にファイルを読み込んだら，その下に一行のスペース行を追加する
" - csv として振る舞うタブを持つvim
"    START CSV -- END CSV 間　は　CSVモードみたいな感じ

" エコーエリア
"
" csv の2番目でソート
" :'<,'>!sort -t, -k 2
"
command! EditNote  execute  'edit strftime("%Y-%m-%d %H:%M")'

function! g:EditNoteDate()
    let date = strftime("%Y-%m-%d %H:%M")
    echo date
    edit "note." . date . "txt"
endfunction

" テスト用
set runtimepath+=~/.vim/account_diary.vim

" Vimですべてのバッファをタブ化する
" :bufdo tab split
" :tab ball
" 全てのバッファをウィンドウに表示 垂直
" :vert ball
" スクロールを同期
" :set scrollbind
" :set noscb
"
" vim echo の出力をバッファに書きこみたい

" 他のvim のバッファを使う
" yank  (vim A)
" :wv
" :rv!  (vim B)
" paste
"
" set si

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
function! IndentFormat() range
    !indent - linux
	normal =
endfunction
command! -count -nargs=1 IndentFormat

" vim:tw=78:ts=4:ft=vim:noet
