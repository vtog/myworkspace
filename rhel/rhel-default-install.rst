Setup Debian
============

These instruction configure RHEL8 with my preferred settings.

#. Install the default packages

   .. code-block:: bash
      
      # Base requirements
      dnf install epel
      dnf install zsh neovim 
      
      # base utilities (need to double check what's already here by default)
      dnf install make curl elinks tcpdump nginx

#. Modify sshd

   .. code-block:: bash
   
      # modify following settings     
      vim /etc/ssh/sshd_config
         PermitRootLogin no
         PasswordAuthentication no
         ChallengeResponseAuthentication no
         UsePAM no
               
      # reload service
      systemctl restart sshd

#. Add user to sudo users

   .. code-block:: bash
   
      usermod -a -G sudo <user>
      
      # Modify sudo with "visudo" and change 
      %sudo   ALL=(ALL:ALL) ALL
      # to
      %sudo   ALL=(ALL:ALL) NOPASSWD:ALL

#. Modify BASH environment

   .. code-block:: bash
   
      echo "alias cls='clear'" >> ~/.bashrc
      echo "alias glog='git log --oneline --decorate'" >> ~/.bashrc
      echo "alias reload='. ~/.bashrc'" >> ~/.bashrc

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
      
#. Install docker-ce (this needs to be reworked, as its not correct)

   .. code-block:: bash
   
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
      sudo apt update && apt install docker-ce -y

      # Add user to docker group
      usermod -a -G docker <user>
