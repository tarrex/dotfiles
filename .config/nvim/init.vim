let vimrc=expand('~/.vimrc')
if !filereadable(vimrc)
    if !executable('curl')
        echoerr 'You have to install curl or download .vimrc yourself!'
        execute 'q!'
    endif
    echo 'Download .vimrc...'
    echo ''
    silent !\curl -fLo ~/.vimrc --create-dirs https://tarrex.github.io/dotfiles/.vimrc
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
