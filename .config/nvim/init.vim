let vimrc=expand('~/.vimrc')
if !filereadable(vimrc)
    if !executable('curl')
        echoerr 'You have to install curl or download .vimrc yourself!'
        finish
    endif
    echo 'Download .vimrc...'
    echo ''
    silent !\curl -fLo ~/.vimrc --create-dirs https://tarrex.github.io/dotfiles/.vimrc
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" ----> nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
}
EOF
