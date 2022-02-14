Setup Fedora/RHEL
=================

These instruction configure RHEL8 with my preferred settings.

#. Install the default packages

   .. code-block:: bash

      #Setup fusion free and non-free
      dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
      dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

      # Base requirements (build neovim and alacritty from source for RHEL)
      dnf install zsh neovim neofetch alacritty gnome-tweaks
      
      # Install Dev Tools
      sudo dnf group install "Development Tools"

#. Modify sshd

   .. code-block:: bash
   
      # modify following settings     
      vim /etc/ssh/sshd_config
         PermitRootLogin no
         PasswordAuthentication no
               
      # reload service
      systemctl restart sshd

#. Add user to wheel users

   .. code-block:: bash
   
      usermod -a -G wheel <user>
      
      # Modify sudo with "visudo" and uncomment or modify the follow line
      %wheel  ALL=(ALL)       ALL
      # to
      %wheel  ALL=(ALL)       NOPASSWD: ALL

#. Modify LDAP shell attribute (IF needed; RHEL requires this.)

   .. code-block:: bash

      getent passwd user-name
      sss_override user-add user-name -s new-shell
      systemctl restart sssd
      getent passwd user-name
      sss_override user-show user-name

#. Setup .dotfiles

   .. note:: This assumes the "dotfiles" repo exists.

   .. code-block:: bash

      git clone --separate-git-dir=$HOME/.dotfiles git@github.com:vtog/.dotfiles.git tmpdotfiles
      rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
      rm -rf ~/tmpdotfiles
      source ~/.zshrc
      dotfiles config --local status.showUntrackedFiles no

#. Setup Spaceship-prompt

   .. code-block:: bash

      git clone https://github.com/spaceship-prompt/spaceship-prompt.git --depth=1
      sudo ln -sf ~/git/spaceship-prompt/spaceship.zsh /usr/share/zsh/site-functions/prompt_spaceship_setup      
      source ~/.zshrc

#. Install Alacritty from Source (if needed)

   .. code-block:: bash

      git clone git@github.com:alacritty/alacritty.git ~/git/alacritty
      cd ~/git/alacritty
      cargo build --release
      sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
      sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

      # Create Desktop Entry
      sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
      sudo desktop-file-install extra/linux/Alacritty.desktop
      sudo update-desktop-databas

      # Create Man Page
      sudo mkdir -p /usr/local/share/man/man1
      gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
      gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

      # Create Zsh Shell Completion
      sudo cp extra/completions/_alacritty /usr/share/zsh/site-functions

#. Install NeoVIM from Source (if needed)

   .. code-block:: bash

      git clone git@github.com:neovim/neovim.git ~/git/neovim
      cd ~/git/neovim
      make CMAKE_BUILD_TYPE=Release
      sudo make install

#. Install vim-plug (neovim)

   .. code-block:: bash

      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

      # Update vim!
      vim
      : PlugInstall
      : q
      : q


#. Install PIP

   .. code-block:: bash
      
      dnf install python3-pip
      pip install pip -U
      
      # add misc packages
      pip install ansible awscli Pygments
      
#. Add Sphinx build environment

   .. code-block:: bash
   
      pip install sphinx sphinx-autobuild sphinx_rtd_theme
      
      # F5 Theme
      pip install f5_sphinx_theme recommonmark sphinxcontrib.addmetahtml sphinxcontrib.nwdiag sphinxcontrib.blockdiag sphinxcontrib-websupport
      sudo dnf install graphviz
      
#. Install docker-ce

   .. code-block:: bash

      sudo dnf install dnf-plugins-core
      sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
      sudo dnf install docker-ce docker-ce-cli containerd.io
      sudo systemctl start docker
      sudo systemctl enable docker
      
      # Add user to docker group
      usermod -a -G docker <user>
      newgrp docker

