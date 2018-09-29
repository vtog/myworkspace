#. Install the default packages

   .. code-block:: bash
      
      apt install vim dnsutils ntp ssh make python git cloud-init curl locate elinks net-tools tree

#. Modify BASH environment

   .. code-block:: bash
   
      echo "alias cls=clear" >> ~/.bashrc

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

#. Modify GIT environment
   
   .. code-block:: bash
   
      git config --global user.name "vtog"
      git config --global user.email "v.tognaci@f5.com"
      git config --global core.editor vim

#. Install PIP

   .. code-block:: bash
      
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python get-pip.py
      pip install --upgrade pip
      
      # add misc packages
      pip install f5-sdk
      pip install ansible

#. Add Sphinx build environment

   .. code-block:: bash
   
      pip install sphinx sphinx-autobuild sphinx_rtd_theme
      
      # F5 Theme
      pip install f5_sphinx_theme sphinxjp.themes.basicstrap recommonmark 
      
