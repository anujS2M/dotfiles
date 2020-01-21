" indent guides enabled by default
let g:indent_guides_enable_on_vim_startup = 1
let g:airline_theme='molokai'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""" NERD Tree """"""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Close nvim if it is the only window available
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Toggle NERDTree with Control-N
map <C-n> :NERDTreeToggle<CR>

" Refresh NERDTree and CtrlP
nmap <Leader>nr :NERDTreeFocus<cr>R<c-w><c-p>:CtrlPClearCache<cr>

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" Pressing Leader with ga(git annotate) opens/closes annotate window
nnoremap <silent><leader>ga :call GitAnnotateToggle()<cr>

" Function to handle toggle
let s:annotate_is_open = 0
function! GitAnnotateToggle()
    if s:annotate_is_open
        :q
        let s:annotate_is_open = 0
    else
        :Gblame
        let s:annotate_is_open = 1
    endif
endfunction

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" ALE """"""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_linters = {
\   'proto': ['prototool-lint'],
" \   'ruby': ['standardrb', 'rubocop'],
\}
let g:ale_lint_on_text_changed = 'never'

" <leader>f will format and fix your current file.
" Change to PrototoolFormat to only format and not fix.
nnoremap <leader>pf :call PrototoolFormatFix()<CR>

let g:startify_custom_header = [
    \ ' /$$   /$$ /$$$$$$$$  /$$$$$$  /$$    /$$ /$$$$$$ /$$      /$$',
    \ '| $$$ | $$| $$_____/ /$$__  $$| $$   | $$|_  $$_/| $$$    /$$$',
    \ '| $$$$| $$| $$      | $$  \ $$| $$   | $$  | $$  | $$$$  /$$$$',
    \ '| $$ $$ $$| $$$$$   | $$  | $$|  $$ / $$/  | $$  | $$ $$/$$ $$',
    \ '| $$  $$$$| $$__/   | $$  | $$ \  $$ $$/   | $$  | $$  $$$| $$',
    \ '| $$\  $$$| $$      | $$  | $$  \  $$$/    | $$  | $$\  $ | $$',
    \ '| $$ \  $$| $$$$$$$$|  $$$$$$/   \  $/    /$$$$$$| $$ \/  | $$',
    \ '|__/  \__/|________/ \______/     \_/    |______/|__/     |__/',
    \ ]


" Enable the list of buffers

let g:airline#extensions#tabline#enabled = 1

" Use the silver searcher with ack
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

cnoreabbrev Ack Ack!
nnoremap <C-F> :Ack!<Space>