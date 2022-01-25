Setup Fedora/RHEL
=================

These instruction configure RHEL8 with my preferred settings.

#. Install the default packages

   .. code-block:: bash

      #Setup fusion free and non-free
      dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
      dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

      # Base requirements
      dnf install zsh neovim noefetch alacritty gnome-tweaks
      
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

#. Modify LDAP shell attribute (IF needed RHEL required this.)

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
      sudo ln -sf ~/git/spaceship-prompt/spaceship.zsh /usr/local/share/zsh/site-functions/prompt_spaceship_setup      
      source ~/.zshrc

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
      pip install ansible
      pip install awscli
      

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

