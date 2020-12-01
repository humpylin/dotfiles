setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

EDITOR=vim

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# file
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# proxy
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
export no_proxy=localhost,127.0.0.1

# System Specific
case `uname` in 
Darwin)
    # commands for macOS

    # ruby
    [ -d /usr/local/opt/ruby/bin ] && export PATH="/usr/local/opt/ruby/bin:$PATH"
;;
Linux)
    # commands for Linux
;;
FreeBSD)
    # commands for FreeBSD
;;
esac

# WSL 2
if [[ `uname -a` =~ "microsoft" ]]; then
    export hostip=$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')
    export http_proxy="socks5://${hostip}:7890"
    export https_proxy="socks5://${hostip}:7890"
    export all_proxy="socks5://${hostip}:7890"
fi

# zplug
if [ ! -d ~/.zplug ]; then
    echo 'Installing zplug ... '
    git clone https://github.com/zplug/zplug.git ~/.zplug
fi
source ~/.zplug/init.zsh 
zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "dracula/zsh", as:theme
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

