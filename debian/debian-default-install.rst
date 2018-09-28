#. Install the default packages

   .. code-block:: bash
      
      apt install vim dnsutils ntp ssh python git cloud-init curl locate elinks net-tools tree

#. Install PIP

   .. code-block:: bash
      
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python get-pip.py
      pip install --upgrade pip
      
      # add misc packages
      pip install f5-sdk
      pip install ansible

#. Set VIM default properites

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
      EOF
