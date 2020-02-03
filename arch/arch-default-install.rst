Install Arch Linux
==================

These instruction will walk you through installing Arch Linux on any device or
VM.

I also have added my default preferences.

#. Boot from ISO

   - `Download Archi Linux ISO  <https://www.archlinux.org/download/>`_
   - `Balena Etcher <https://github.com/balena-io/etcher>`_ to create bootable
     thumbdrive

#. Partition available disk drives

   .. code-block:: bash

      fdisk -l # Discover avaiable drives, we'll use "/dev/sda" as an example
      fdisk /dev/sda
         g
         n                 #New
         1                 #EFI
         <defualt>         #Default
         +300M             #Set size
         n                 #New
         2                 #Root
         <default>         #Default
         +40G              #Set size
         n                 #New
         3                 #home
         <default>         #Default
         <default>         #Default
         w                 #Write

#. Format partitions

   .. code-block:: bash

      mkfs.fat -F32 /dev/sda1
      mkfs.ext4 /dev/sda2
      mkfs.ext4 /dev/sda3

#. Mount partitions

   .. code-block:: bash

      mount /dev/sda2 /mnt
      mkdir /mnt/home
      mount /dev/sda3 /mnt/home

#. Install the base distro to new partitions

   .. code-block:: bash

      pacstrap -i base linux linux-headers linux-firmware dhcpcd grub efibootmgr dosfstools

#. Create fstab on new partition

   .. code-block:: bash

      genfstab -U -p /mnt >> /mnt/etc/fstab

#. Change arch root to new partition

   .. code-block:: bash

      arch-chroot /mnt

#. Install default packages

   .. code-block:: bash
      
      pacman -S linux-lts linux-lts-headers base-devel bash-completion net-tools lsb-release
      pacman -S openssh vim ntp make python3 git curl tree sudo elinks tcpdump nginx docker

      systemctl enable sshd
      systemctl enable nginx
      systemctl enable docker
      systemctl enable ntp

#. Update locale and timezone

   .. code-block:: bash

      vim /etc/locale.gen (find local for location... en_US.UTF)
      locale-gen
      ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
      hwclock --systohc --utc

#. Setup EFI

   .. code-block:: bash

      mkdir /boot/EFI
      mount /dev/sda1 /boot/EFI
      grub-install --target=x86_64-efi --bootloader-id=grub-uefi --recheck
      mkdir /boot/grub/locale
      cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
      grub-mkconfig -o /boot/grub/grub.cfg

#. setup SWAP file (configure appropriate size based on environment)

   .. code-block:: bash

      fallocate -l 2G /swapfile
      chmod 600 /swapfile
      mkswap /swapfile
      echo '/swapfile none swap sw 0 0' | tee -a /ets/fstab

#. Modify sshd (cert auth only)

   .. code-block:: bash
   
      # modify following settings     
      vim /etc/ssh/sshd_config
         PermitRootLogin no
         PasswordAuthentication no
         ChallengeResponseAuthentication no
         UsePAM no

#. Modify sudo with "visudo"

   .. code-block:: bash
   
      EDITOR=vim visudo
      
      # from
      %sudo   ALL=(ALL:ALL) ALL
      # to
      %sudo   ALL=(ALL:ALL) NOPASSWD:ALL

#. Add new user and set passwords

   .. code-block:: bash

      useradd -m -G wheel vince
      passwd vince
      passwd root

#. Reboot to new partition

   .. code-block:: bash

      exit
      umount -a
      reboot

#. Modify BASH environment

   .. code-block:: bash
   
      echo "alias 'cls=clear'" >> ~/.bashrc
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

#. Modify GIT environment
   
   .. code-block:: bash
   
      git config --global user.name <user>
      git config --global user.email <email>
      git config --global core.editor vim

#. Install PIP

   .. code-block:: bash
      
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python get-pip.py
      pip install pip --upgrade
      
      # add misc packages
      pip install f5-sdk --upgrade
      pip install ansible --upgrade
      pip install awscli --upgrade

#. Add Sphinx build environment

   .. code-block:: bash
   
      pip install sphinx sphinx-autobuild sphinx_rtd_theme
      
      # F5 Theme
      pip install f5_sphinx_theme recommonmark sphinxcontrib.addmetahtml sphinxcontrib.nwdiag sphinxcontrib.blockdiag sphinxcontrib-websupport
      apt install graphviz
      
#. Install GUI

   .. code-block:: bash

      pacman -S xorg-server (xorg-xinit)
      pacman -S gdm #sddm for kde
      systemctl enable gdm

      # Virtual ENV
      pacman -S virtualbox-guest-utils virtualbox-guest-modules-arch mesa mesa-libgl

      pacman -S gnome gnome-terminal nautilus gnome-tweaks gnome-control-center gnome-backgrounds adwaita-icon-theme arc-gtk-theme firefox
      #OR
      pacman -S xfce4 xfce4-goodies xfce4-terminal
      #OR
      pacman -S plasma konsole dolphin