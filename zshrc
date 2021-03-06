# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# oh-my-zsh configs

plugins=(zsh-autosuggestions)

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set Spaceship ZSH as a prompt
# autoload -U promptinit; promptinit
# prompt spaceship

SPACESHIP_PROMPT_ORDER=(
  git
  char
)
SPACESHIP_PROMPT_ADD_NEWLINE=false

ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export LC_ALL=en_US.UTF-8
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/Applications/

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export TF_LOG=INFO
export PATH=$PATH:/Applications/flutter/bin

export CONFIG_DIR="${HOME}/.config/lazygit/"
