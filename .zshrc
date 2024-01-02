export ZSH="/home/dominik/.local/share/dabs-repos/ohmyzsh"
ZSH_THEME="bira"
plugins=(
	git
	zsh-autosuggestions
)
source $ZSH'/oh-my-zsh.sh'
source $HOME'/.config/zsh/zshrc'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
