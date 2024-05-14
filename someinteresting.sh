#!/bin/bash

echo "请选择要安装和运行的工具："
echo "1) asciiquarium (水族馆)"
echo "2) cmatrix (黑客帝国)"
echo "3) cowsay (会说话的牛)"
echo "4) sl (动力火车)"
echo "5) hollywood (好莱坞电影动态界面)"
echo "6) bastet (俄罗斯方块)"

export PATH=$PATH:/usr/games
install_package() {
    if [[ -f /etc/redhat-release ]] || [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "$ID" == "centos" || "$ID" == "fedora" ]]; then
            sudo yum install -y $1
        elif [[ "$ID" == "rhel" ]]; then
            sudo yum install -y $1
        fi
    elif [[ -f /etc/debian_version ]]; then
        sudo apt-get update && sudo apt-get install -y $1
    else
        echo "不支持的操作系统"
        exit 1
    fi 
}

read -p "输入你的选择: " choice

case $choice in
    1)
        if [[ ! $(command -v cpanm) ]]; then
            if [[ -f /etc/debian_version ]]; then
                sudo apt-get update && sudo apt-get install -y cpanminus wget libncurses5-dev make gcc
            elif [[ -f /etc/redhat-release ]] || [[ -f /etc/os-release ]]; then
                . /etc/os-release
                if [[ "$ID" == "centos" || "$ID" == "fedora" || "$ID" == "rhel" ]]; then
                    sudo yum check-update && sudo yum install -y perl-App-cpanminus wget ncurses-devel gcc make
                fi
            fi
        fi
        sudo cpanm --force Curses
        sudo cpanm Term::Animation
        wget http://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz
        tar zxvf asciiquarium.tar.gz
        cd asciiquarium_*
        chmod +x asciiquarium
        sudo cp asciiquarium /usr/local/bin
        asciiquarium
        ;;
        
    2)
        install_package "cmatrix"
        cmatrix
        ;;
        
    3)
        install_package "cowsay"
        cowsay "Hello, world!"
        ;;
        
    4)
        install_package "sl"
        sl
        ;;
        
    5)
        install_package "hollywood"
        hollywood
        ;;
        
    6)
        install_package "bastet"
        bastet
        ;;
    *)
        echo "无效的选择。"
        exit 1
        ;;
esac
