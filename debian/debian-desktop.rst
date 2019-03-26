#. Update/Upgrade Debian

   .. code-block:: bash
   
      apt update
      apt upgrade

#. Setup mate for all users

   .. code-block:: bash
   
      sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
      systemctl restart xrdp.service

#. Install XRDP

   .. code-block:: bash
   
      apt install xrdp

#. Install Mate

   .. code-block:: bash
   
      #apt install mate-core (don't think i need this one)
      apt install ubuntu-mate-desktop
