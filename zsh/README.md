# [Zsh](https://www.zsh.org/)

"Zsh is a shell designed for interactive use, although it is also a powerful scripting languageZsh is a shell designed for interactive use, although it is also a powerful scripting language"

On top of Zsh, I use also [Oh my Zsh](https://ohmyz.sh/).


Point the system to look for configs .config/zsh instead of ~
Edit /etc/zsh/zshenv or /etc/zshenv:
```bash
if [[ -z "$XDG_CONFIG_HOME" ]]
then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```
