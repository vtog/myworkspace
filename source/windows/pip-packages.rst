Default PIP Setup
=================

#. Install PIP

   .. code-block:: bash
      
      download https://bootstrap.pypa.io/get-pip.py
      python get-pip.py
      pip install --upgrade pip
      
      # add misc packages
      pip install doc8
      pip install f5-sdk
      
#. Add Sphinx build environment

   .. code-block:: bash
   
      pip install sphinx==1.7.9 sphinx-autobuild sphinx_rtd_theme
      
      # F5 Theme
      pip install f5_sphinx_theme sphinxjp.themes.basicstrap recommonmark sphinxcontrib.addmetahtml sphinxcontrib.nwdiag sphinxcontrib.blockdiag
      
