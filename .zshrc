#If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


ZSH_THEME="robbyrussell"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Brew
export PATH=/opt/homebrew/bin:$PATH

# Aliases 
alias setshine='xrandr --output eDP-1 --brightness'
alias update='sudo apt-get update'
alias bt="upower -i $(upower -e | grep '/battery')"
alias lpdf="ls -aR | grep '/\|pdf$'"
alias chrome="google-chrome"
alias cppwd="pwd | xclip -selection clipboard"
alias localip="hostname -I | cut -d' ' -f1"
alias nvim="~/./nvim.appimage"
alias setthemedark "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"

# Reload aliases 
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

