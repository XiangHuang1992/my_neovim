""""""""""""""""""""""""""""""""""""""""""""""""""
" neovim初始化
" """"""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'python/black', {'for': 'python'}
Plug 'shougo/context_filetype.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'yggdroot/indentline'
Plug 'machakann/vim-highlightedyank'
Plug 'tmhedberg/SimpylFold'
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'amix/vim-zenroom2', {'for': 'markdown'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'skywind3000/asyncrun.vim', {'for': 'python'}
Plug 'w0rp/ale', {'for': ['go', 'python', 'javascript', 'html']}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'dag/vim-fish', {'for': 'fish'}
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'valloric/youcompleteme'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

source ~/.config/nvim/vimrcs/basic.vim
source ~/.config/nvim/vimrcs/filetypes.vim
source ~/.config/nvim/vimrcs/plugins_config.vim
source ~/.config/nvim/vimrcs/extended.vim


