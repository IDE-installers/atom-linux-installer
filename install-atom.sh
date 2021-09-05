#!/usr/bin/bash -e

# Simple bash script to install Atom IDE on Linux

### This shell commands to install Atom are taken from: 
# https://flight-manual.atom.io/getting-started/sections/installing-atom/#platform-linux
###

# identify system package manager
configure(){

    if [ -e /bin/apt ] || [ -e /usr/bin/apt ]; then PM=apt # <-- [P]ackage [M]anager

    elif [ -e /bin/dnf ] || [ -e /usr/bin/dnf ]; then PM=dnf

    elif [ -e /bin/yum ] || [ -e /usr/bin/yum ]; then PM=yum

    elif [ -e /bin/zypp ] || [ -e /usr/bin/zypp ]; then PM=zypper

    else 
        echo "Sorry, I don't know what to do."
        exit 1
    fi

}

# begin the installation
install(){
    printf "\nInstalling Atom...\n"

    case $PM in
        apt)
            wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
            sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
            sudo apt-get update
            sudo apt-get install atom -y
            ;;

        dnf)
            sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
            sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'
            sudo dnf install atom -y
            ;;

        yum)
            sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
            sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'
            sudo yum install atom -y
            ;;

        zypper)
            sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ntype=rpm-md\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/zypp/repos.d/atom.repo'
            sudo zypper --gpg-auto-import-keys refresh
            sudo zypper install atom
            ;;
    esac
}

# START
printf "Atom installer for Linux\n"
configure
install
