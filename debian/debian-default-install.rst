Setup Debian
============

These instruction configure Debian with my preferred settings.

#. Install the default packages

   .. code-block:: bash
      
      # Base requirements
      apt install zsh nvim ntp ssh git sudo net-tools dnsutils lsb-release apt-transport-https software-properties-common
      
      # base utilities
      apt install make python3 python3-setuptools python3-distutils curl locate tree elinks tcpdump nginx rsync tmux
      
      systemctl enable ntp

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

      git clone https://aur.archlinux.org/spaceship-prompt-git.git
      cd spaceship-prompt-git
      makepkg -si

      source ~/.zshrc

#. Install vim-plug (neovim)

   .. code-block:: bash

      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


#. Install PIP

   .. code-block:: bash
      
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      sudo python get-pip.py
      sudo pip install pip --upgrade
      
      # add misc packages
      sudo pip install f5-sdk
      sudo pip install ansible
      sudo pip install awscli
      

#. Add Sphinx build environment

   .. code-block:: bash
   
      sudo pip install sphinx sphinx-autobuild sphinx_rtd_theme
      
      # F5 Theme
      sudo pip install f5_sphinx_theme recommonmark sphinxcontrib.addmetahtml sphinxcontrib.nwdiag sphinxcontrib.blockdiag sphinxcontrib-websupport
      sudo apt install graphviz
      
#. Install docker-ce

   .. code-block:: bash
   
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
      sudo apt update && apt install docker-ce -y

      # Add user to docker group
      usermod -a -G docker <user>
