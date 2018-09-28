#. Install the default packages

   .. code-block:: bash
      
      apt install vim dnsutils ntp ssh make python git cloud-init curl locate elinks net-tools tree

#. Install PIP

   .. code-block:: bash
      
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python get-pip.py
      pip install --upgrade pip
      
      # add misc packages
      pip install f5-sdk
      pip install ansible

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
      EOF

#. Modify BASH environment

   .. code-block:: bash
   
      echo "alias cls=clear" >> ~/.bashrc
    
#. Add Sphinx build environment

   .. code-block:: bash
   
      pip install sphinx sphinx-autobuild sphinx_rtd_theme
      
      # F5 Theme
      pip install f5_sphinx_theme sphinxjp.themes.basicstrap recommonmark 
      
