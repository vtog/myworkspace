Install Arch Linux
==================

These instruction will walk you through installing Arch Linux on any device or
VM.

I also have added my default preferences.

#. Boot from ISO

   - `Download Arch Linux ISO  <https://www.archlinux.org/download/>`_
   - `Balena Etcher <https://github.com/balena-io/etcher>`_ to create bootable
     thumbdrive

#. Enable sshd and set root passwd (This step is optional)

   .. code-block:: bash

      systemctl start sshd

      passwd

#. Update mirrorlist

   - `Arch Mirrorlist Generator  <https://www.archlinux.org/mirrorlist/>`_

   .. code-block:: bash

      # Copy & Replace current mirrorlist with generated content
      vim /etc/pacman.d/mirrorlist
      pacman -Syy

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
         +30G              #Set size
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

      pacstrap -i /mnt base

#. Create fstab on new partition

   .. code-block:: bash

      genfstab -U -p /mnt >> /mnt/etc/fstab

#. Change arch root to new partition

   .. code-block:: bash

      arch-chroot /mnt

#. Update pacman mirror list with reflector

   .. code-block:: bash

      pacman -S reflector
      reflector --latest 15 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

#. Install default packages

   .. code-block:: bash
      
      # Base requirements
      pacman -S linux linux-headers linux-firmware base-devel grub efibootmgr dosfstools os-prober mtools dhcpcd zsh

      # Base utilities 
      pacman -S openssh vim ntp make python3 git curl tree sudo elinks tcpdump nginx docker man-db bash-completion rsync tmux

      # Wireless support (if needed)
      pacman -S wireless_tools wpa_supplicant dialog

      systemctl enable dhcpcd
      systemctl enable sshd
      systemctl enable nginx
      systemctl enable docker
      systemctl enable ntpd

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

#. Modify GRUB to remember last selected kernel

   .. code-block:: bash

      vim /etc/default/grub

      # Add the following lines; write and quite
      GRUB_SAVEDEFAULT="true"
      GRUB_DEFAULT="saved"

      grub-mkconfig -o /boot/grub/grub.cfg

#. Setup SWAP file (configure appropriate size based on environment)

   .. code-block:: bash

      fallocate -l 2G /swapfile
      chmod 600 /swapfile
      mkswap /swapfile
      echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

#. Modify sudo with "visudo" allowing group "wheel" sudo rights

   .. code-block:: bash
   
      EDITOR=vim visudo

      # Uncomment the following line with visudo (write and quit)
      %wheel ALL=(ALL:ALL) NOPASSWD:ALL

#. Add new user and set passwords

   .. code-block:: bash

      useradd -m -G users,wheel vince
      passwd vince

#. Reboot to new partition

   .. code-block:: bash

      exit
      umount -a
      reboot

#. Login with "new user" and validate sudo rights

   .. code-block:: bash

      sudo pacman -Syu

#. Modify BASH environment

   .. code-block:: bash
   
      echo "alias ll='ls -l --color=auto'" >> ~/.bashrc
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

#. Modify GIT environment
   
   .. code-block:: bash
   
      git config --global user.name <user>
      git config --global user.email <email>
      git config --global core.editor vim

#. Install Desktop Environment

   .. code-block:: bash

      su -

      pacman -S xorg

      # What video driver do I have?
      lspci -nnk | grep -EA3 "VGA|'Kern'|3D|Display"

      # Intel
      pacman -S xf86-video-intel mesa
      # AMD
      pacman -S xf86-video-amdgpu mesa
      #VMWare
      pacman -S xf86-video-vmware mesa

      pacman -S gnome gnome-extra adwaita-icon-theme
      #OR
      pacman -S xfce4 xfce4-goodies
      #OR
      pacman -S plasma kde-applications

#. Setup .dotfiles

   .. note:: This assumes my "dotfiles" repo exists.

   .. code-block:: bash

      git clone --separate-git-dir=$HOME/.dotfiles git@github.com:vtog/.dotfiles.git tmpdotfiles
      rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
      rm -rf tmpdotfiles
      source .zshrc
      dotfiles config --local status.showUntrackedFiles no

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

#. Modify sshd (cert ONLY auth)

   .. code-block:: bash
   
      # modify following settings     
      vim /etc/ssh/sshd_config
         PermitRootLogin no
         PasswordAuthentication no
         ChallengeResponseAuthentication no
         UsePAM no
