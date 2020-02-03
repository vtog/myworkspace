#. Install the default packages

   .. code-block:: bash
      
      apt install vim ntp ssh make python3 python3-setuptools python3-distutils git curl locate tree sudo elinks net-tools dnsutils tcpdump software-properties-common lsb-release apt-transport-https nginx

#. Modify sshd

   .. code-block:: bash
   
      # modify following settings     
      vim /etc/ssh/sshd_config
         PermitRootLogin no
         PasswordAuthentication no
         ChallengeResponseAuthentication no
         UsePAM no
               
      # reload service
      service ssh reload

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

#. Set VIM default environment

   .. code-block:: bash
   
      cat <<EOF >> ~/.vimrc
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set autoindent
      set smartindent
      set copyindent
      set bg=dark
      set nowrap
      set pastetoggle=<F3>
      syntax on
      colorscheme slate
      EOF

      sudo update-alternatives --config editor

#. Modify GIT environment
   
   .. code-block:: bash
   
      git config --global user.name <user>
      git config --global user.email <email>
      git config --global core.editor vim

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
