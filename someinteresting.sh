#!/bin/bash

echo "请选择要安装和运行的工具："
echo "1) asciiquarium (水族馆)"
echo "2) cmatrix (黑色帝国)"
echo "3) cowsay (会说话的牛)"
echo "4) sl (动力火车)"
echo "5) hollywood (假装在忙)"
echo "6) bastet (俄罗斯方块)"
read choice

install_package() {
    if [[ -f /etc/redhat-release ]]; then
        sudo yum install -y $1
    elif [[ -f /etc/debian_version ]]; then
        sudo apt-get install -y $1
    else
        echo "不支持的操作系统"
        exit 1
    fi
}

case $choice in
    1)
        perl -MCPAN -e 'install Term::Animation'
        sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install libncurses5-dev
cpan Curses
wget http://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz
tar -zxvf asciiquarium.tar.gz
cd asciiquarium_*/
sudo cp asciiquarium /usr/local/bin
sudo chmod 0755 /usr/local/bin/asciiquarium

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
        if [[ ! -f /etc/redhat-release ]]; then
            echo "hollywood 主要在 Ubuntu 上可用，尝试为您安装。"
            sudo apt-get install -y hollywood
            hollywood
        else
            echo "当前系统不支持安装 hollywood。"
        fi
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
