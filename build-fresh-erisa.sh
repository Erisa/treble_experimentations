#!/bin/bash
# From fresh Debian 10, on a system you DO NOT MIND SCREWING OVER

if [ -e "$HOME/.erisa-android-setup-done"];then 
    echo "!! WARNING !!"
    echo "A previous setup for the script has been detected."
    echo "For your safety, running it again has been prevented."
    echo "To build, enter ~/build and use ../treble_experimentations/build-dakkar.sh"
    echo "To ignore this warning, delete the file '$HOME/.erisa-android-setup-done and run the script again."
else
    sudo apt update && \
    sudo apt -y upgrade && \
    sudo apt -y install bc bison build-essential ccache curl \
    flex g++-multilib gcc-multilib git gnupg gperf imagemagick \
    lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool \
    libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 \
    libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc \
    zip zlib1g-dev libncurses5 libncurses5-dev git wget rsync aria2 && \
    echo 'deb http://deb.debian.org/debian stretch main' | sudo tee /etc/apt/sources.list.d/stretch.list && \
    git clone https://github.com/Erisa/treble_experimentations.git && \
    mkdir ~/bin &&\
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
    chmod a+x ~/bin/repo && PATH="$HOME/bin:$PATH" && \
    sudo apt update && sudo apt -y install openjdk-8-jdk/stretch && \
    mkdir build && \
    git config --global user.name "Erisa A" && \
    git config --global user.email "seriel@erisa.moe" && \
    git config --global color.ui auto && \
    sed -E -i "s/(repo sync.*)-j 1/\1-j10/g" treble_experimentations/build.sh && \
    sed -E -i "s/(make.*)-j8/\1-j250/g" treble_experimentations/build.sh && \
    cd build && \
    echo "!!! BUILD ENVIRONMENT HAS BEEN SETUP !!!"
    echo "!!! For subsequent builds, DO NOT RUN THIS SCRIPT !!!"
    echo "!!! Instead enter ~/build and use ../treble_experimentations/build-dakkar.sh !!!"
    touch "$HOME/.erisa-android-setup-done"
    bash -x ../treble_experimentations/build-dakkar.sh $1 $2
fi