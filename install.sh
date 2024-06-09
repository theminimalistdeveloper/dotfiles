# Install packages
sudo apt install \
brightnessctl \
curl \
exa \
feh \
fuse3 \
fzf \
git \
i3-wm \
kitty \
pavucontrol \
apt-transport-https \
picom \
polybar \
python3-neovim \
rofi \
stow \
tmux \
unzip \
wget \
zsh \
-y

# Install Neovim latest stable
curl -O https://github.com/neovim/neovim/releases/download/stable/nvim.appimage 
chmod +x ~/Downloads/nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim

# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
# configure Zsh
rm -rf .zshrc
cd dotfiles
stow zsh
cd ~ 

# Install dot files
rm -rf dotfiles
git clone https://github.com/theminimalistdeveloper/dotfiles.git 
cd dotfiles 
stow kitty nvim i3 polybar rofi backgrounds
cd ..

# Install Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# Install JetbrainsMono Nerd Font 
cd ~/Downloads
curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
sudo mv *.ttf /usr/share/fonts
rm -rf ./JetBrainsMono.zip OFL.txt README.md
cd ~ 

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Surfshark
curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh #gets the installation script
cat surfshark-install.sh #show script’s content
sh surfshark-install.sh #installs surfshark

