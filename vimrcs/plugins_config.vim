""""""""""""""""""""""""""""""""""""""""""""""""""
" vim插件配置
" """"""""""""""""""""""""""""""""""""""""""""""""
" vim自动补全 {{{
" use youcompleteme
"
let g:ycm_python_binary_path = 'python3'

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_tags_files = 1
" 开启语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 回车作为选中
let g:ycm_key_list_stop_completion = ['<CR>']
" 在补全之后自动关闭窗口
let g:ycm_autoclose_preview_window_after_completion = 1

" 关闭诊断显示（使用ale进行异步语法检查）
let g:ycm_show_diagnostics_ui = 0

" for python
let g:ycm_semantic_triggers = {'python': ['re!from\s+\S+\s+import\s']}
let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开
" enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete

" 禁止缓存匹配项，每次重新生成匹配项
let g:ycm_cache_omnifunc = 0 

" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_register_as_syntastic_checker = 0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob("~/.config/nvim/plugged/youcompleteme/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim_mru_files/my_plugins/youcompleteme/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.config/nvim/plugged/youcompleteme/third_party/ycmd/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.config/nvim/plugged/youcompleteme/third_party/ycmd/.ycm_extra_conf.py"
endif
"" 异步语义补全
let g:ycm_semantic_triggers =  {
        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
        \ 'cs,lua,javascript': ['re!\w{2}'],
        \ }
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
set completeopt=menu,menuone

" 白名单设置,白名单中的文件类型才开启YCM

let g:ycm_filetype_whitelist = {
            \ 'c':1,
            \ 'cpp':1,
            \ 'python':1,
            \ 'html':1,
            \ 'go':1,
            \ 'javascript':1
            \ }

" python/black 在文件保存时自动格式化
autocmd BufWritePre *.py execute ':Black'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" }}}

" ultisnips {{{

let g:UltiSnipsExpandTrigger      = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger= "<s-tab>"
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsSnippetsDir        = '~/.config/nvim/UltiSnips'
map <leader>us :UltiSnipsEdit<CR>

" ctrl+j/k进行选择
func! g:JInYCM()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<c-j>"
    endif
endfunction

func! g:KInYCM()
    if pumvisible()
        return "\<C-p>"
    else
         return "\<c-k>"
    endif
endfunction
inoremap <c-j> <c-r>=g:JInYCM()<cr>
au BufEnter,BufRead * exec "inoremap <silent> " . g:UltiSnipsJumpBackwordTrigger . " <C-R>=g:KInYCM()<cr>"
let g:UltiSnipsJumpBackwordTrigger = "<c-k>" 

" }}}

" 状态栏设置 {{{{
let g:lightline = {
        \ 'colorscheme': 'dracula',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ]],
        \   'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'] ]
        \   },
        \ 'inactive': {
        \   'left': [ [ 'filename' ] ],
        \   'right': [ [ 'lineinfo', 'percent' ] ]
        \ },
        \ 'tabline': {
        \   'left': [ [ 'tabs' ] ],
        \   'right': []
        \ },
        \ 'tab': {
        \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
        \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
        \ },
        \ 'component': {
        \   'lineinfo': ' %3l:%-2v',
        \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
        \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
        \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
        \ },
        \ 'component_function': {
        \      'gitbranch': 'fugitive#head' ,
        \ },
        \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
        \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
    \ }

set showtabline=2
set guioptions-=e

" }}}

" vim-fugitive {{{
  nmap <silent> <leader>gs :Gstatus<cr>
  nmap <silent> <leader>ge :Gedit<cr>
  nmap <silent> <leader>gr :Gread<cr>
  nmap <silent> <leader>gb :Gblame<cr>


" }}}

" vim-gitgutter {{{
    let g:gitgutter_map_keys = 0
    let g:gitgutter_enabled = 0
    let g:gitgutter_highlight_lines = 1
    nnoremap <leader>gs :GitGutterToggle<CR>

" }}}

" 自动格式化 neoformat {{{
let g:neoformat_enable_python = ['yapf']
let g:neoformat_try_fornatprg = 1

""""没找到文件类型时默认的一些格式化""""a
let g:neoformat_try_formatprg = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" }}}

" vimroom with goyo.vim {{{
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>
"" }}}

" 高亮显示复制区域 {{{
hi HighlightedyankRegion cterm=reverse gui=reverse
let g:highlightedyank_highlight_duration = 1000 " 高亮持续时间1000毫秒
"
" }}}

" markdown 配置 {{{
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
"
" }}}

" indentline 设置 {{{
let g:indentLine_color_term = 239
let g:indentLine_char = '┆'
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 'inc'
"let g:indentLine_concealLevel = '2'
"
" }}}

" javascript {{{
    "pangloss/vim-javascript
    let g:html_indent_inctags = 'html,body,head,tbody'
    let g:html_indent_script1 = 'inc'
    let g:html_indent_style1 = 'inc'
" }}}

" easymotion {{{
    let g:EasyMotion_smartcase = 1
    "let g:EasyMotion_startofline = 0
    map <leader><leader>h <Plug>(easymotion-linebackward)
    map <leader><leader>j <Plug>(easymotion-j)
    map <leader><leader>k <Plug>(easymotion-k)
    map <leader><leader>l <Plug>(easymotion-lineforward)
    " 重复上一次的操作

    map <leader><leader>. <Plug>(easymotion-repeat)
" }}}

" surround.vim config
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

" 文件管理器nerdtree {{{
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']
let g:NERDTreewinPos = "right"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<space>
map <leader>nf :NERDTreeFind<cr>

" nerdtree git status 设置
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" }}}

" 代码检查neomake {{{
" }}}

" 多点编辑插件vim-multiple-cursors {{{
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" }}}

" asyncrun配置 {{{
nnoremap <F5> :call CompileRunGcc() <CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'python'
        if search("@profile")
            exec "AsyncRun kernprof -l -v %"
            exec "copen"
            exec "wincmd p"

        elseif search("set_trace()")
            exec "!python3 %"
        else
            exec "AsyncRun -raw python3 %"
            exec "copen"
            exec "wincmd p"
        endif
    endif
endfunc
" }}}
"
" 语法检查 ale {{{
let g:ale_linters = {
            \   'python': ['flake8'],
            \   'go': ['go', 'golint', 'errcheck']
            \ }
nmap <silent> <leader>a <Plug>(ale_next_wrap)

" disablig highlighting
let g:ale_set_highlights = 0
" only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" }}}

" vim-go {{{
let g:go_fmt_command='goimports'

" -----------------------------------
"  golang 配置
"  ----------------------------------
" let g:deoplete#sources#go#pointer = 1
" let g:deoplete#sources#go#pointer#unimported_packages = 0
" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

" Show the progress when running :GoCoverage
let g:go_echo_command_info = 1

" Show type information
let g:go_auto_type_info = 1

" Highlight variable uses
let g:go_auto_sameids = 1

" Fix for location list when vim-go is used together with Syntastic
let g:go_list_type = "quickfix"

" Add the failing test name to the output of :GoTest
let g:go_test_show_name = 1

let g:go_gocode_propose_source=1

" gometalinter configuration
let g:go_metalinter_command = ""
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_enabled = [
    \ 'deadcode',
    \ 'gas',
    \ 'goconst',
    \ 'gocyclo',
    \ 'golint',
    \ 'gosimple',
    \ 'ineffassign',
    \ 'vet',
    \ 'vetshadow'
\]

" Set whether the JSON tags should be snakecase or camelcase.
let g:go_addtags_transform = "snakecase"

" neomake configuration for Go.
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }

" }}}

" python-mode {{{
" 开启警告
let g:pymode_warnings=0
" 保存文件时删除无用空格
let g:pymode_trim_whitespaces=1
let g:pymode_options = 1
" 显示允许最大长度的列
let g:pymode_options_colorcolumn = 1
" 设置quickfix窗口的最大、最小高度
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 10
" 使用python3
let g:pymode_python = 'python3'
" 取消代码折叠
let g:pymode_folding = 0
" 开启python-mode定义的移动方式
let g:pymode_motion = 1
" 启用python-mode内置的python文档，使用K进行查找
"let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
" 虚拟环境支持
let g:pymode_virtualenv = 1
" 不使用python-mode运行代码
let g:pymode_run = 0
" 不使用python-mode设置断点
let g:pymode_breakpoint = 0
"启用python语法检查
"let g:pymode_lint = 0
" 修改后保存时进行检查
"let g:pymode_lint_on_wirte = 0
" 编辑时进行检查
"let g:pymode_lint_on_fly = 0
"let g:pymode_lint_checkers  = ['pyflakes', 'pep8']
" 发现错误时不自动打开quickfix窗口
let g:pymode_lint_cwindow = 0
" 侧边栏不显示python-mode相关的标志
let g:pymode_lint_signs = 0
"let g:pymode_lint_todo_symbol = 'WW'
"let g:pymode_lint_comment_symbol = 'CC'
"let g:pymode_lint_visual_symbol = 'RR'
"let g:pymode_lint_error_symbol = 'EE'
"let g:pymode_lint_info_symbol = 'II'
"let g:pymode_lint_pyflakes_symbol = 'FF'
" 启用重构
let g:pymode_rope = 1
"不在父目录下查找.ropeproject，能提升响应速度
let g:pymode_rope_lookup_project = 0
"光标下单词查阅文档
let g:pymode_rope_show_doc_bind = '<C-c>d'
"项目修改后重新生成缓存
let g:pymode_rope_regenerate_on_write = 1
"开启补全，并设置<C-Tab>为默认快捷键
"let g:pymode_rope_completion = 1
"let g:pymode_rope_complete_on_dot = 1
" let g:pymode_rope_completion_bind = '<C-Tab>'
"<C-c>g跳转到定义处，同时新建竖直窗口打开
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_rope_goto_definition_cmd = 'vnew'
"重命名光标下的函数，方法，变量及类名
let g:pymode_rope_rename_bind = '<C-c>rr'
"重命名光标下的模块或包
let g:pymode_rope_rename_module_bind = '<C-c>r1r'
"开启python所有的语法高亮
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
"高亮缩进错误
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"高亮空格错误
let g:pymode_syntax_space_errors = g:pymode_syntax_all


" pep8 风格
au BufNewfile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set expandtab |
            \ set fileformat=unix

" }}}

" fzf和fzf.vim配置 {{{
"
"let g: fzf_nvim_statusline = 0 " disable statusline overwriting

let g:rg_command = '
            \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
            \ -g "*.{js,json,php,md,styl,jade,html,config,vim,py,fish,cpp,c,go,hs,rb,conf}"
            \ -g "!{.git,node_modules,vendor,plugged,autoload,temp_dirs,__pycache__,migrations,.vscode}/*" '


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   g:rg_command .shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up660%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>
nnoremap <silent> <leader>. :RgIn

nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

let g:fzf_tags_command = 'ctags -R'

" [[B]Commits] 自定义被'git log'使用的选项
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let $FZF_DEFAULT_COMMAND = 'Rg --files-with-matches --files --column --line-number --no-heading  --follow --smart-case
            \ -g "*.{js,json,php,md,styl,jade,html,config,vim,py,fish,cpp,c,go,hs,rb,conf}"
            \ -g "!{.git,node_modules,vendor,plugged,temp_dirs,autoload,__pycache__,.vscode}/*" '
let $FZF_DEFAULT_OPTS = '--layout=reverse'

let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()
    let buf = nvim_create_buf(v:false, v:true)

    let height = float2nr(&lines * 0.9)
    let width = float2nr(&columns * 0.8)

    let horizontal = float2nr((&columns - width) / 2)

    let vertical = 1

    let opts = {
                \'relative': 'editor',
                \'row': vertical,
                \'col': horizontal,
                \'width': width,
                \'height': height
                \}

    call nvim_open_win(buf, v:true, opts)

endfunction

"}}}

" vim-devicons 设置 {{{

let g:webdevicons_enable=1 ""加载插件
let g:webdevicons_enable_nerdtree=1 " nerdtree启用
let g:WebDevIconsOS = 'Darwin'
let g:webdevicons_enable_startify=1 " startify启用

"}}}

" vim-startify配置 {{{

let g:startify_files_number = 5
let g:startify_changge_to_dir = 0
let g:startify_custom_header = []
let g:startify_relative_path = 1
let g:startify_use_env = 1

" }}}

" nerdcommenter 配置{{{
    let g:NERDSpaceDelims=1
    let g:NERDAltDelims_python=1

" }}}

" tagbar {{{
     nmap <F9> :TagbarToggle<CR>
     let g:tagbar_autofocus = 1
     let g:tagbar_autoshowtag = 1
     let g:tagbar_show_visibility = 1

     " for ruby
     let g:tagbar_type_ruby = {
                 \ 'kinds': [
                    \ 'm:modules',
                    \ 'c:classes',
                    \ 'd:describes',
                    \ 'C:contexts',
                    \ 'f:mothods',
                    \ 'F:singleton methods'
                 \ ]
    \ }

    " for golang
    let g:tagbar_type_go = {
        \ 'ctagstype': 'go',
        \ 'kinds': [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro': '.',
        \ 'kind2scope': {
            \ 't': 'ctype',
            \ 'n': 'ntype'
        \ },
        \ 'scope2kind': {
            \ 'ctype': 't',
            \ 'ntype': 'n'
        \ },
        \ 'ctagsbin': 'gotags',
        \ 'ctagsargs': '-sort -silent'
    \ }
" }}}

"========================================6
