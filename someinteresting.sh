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
        install_package "asciiquarium"
        perl -MCPAN -e 'install Term::Animation'
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