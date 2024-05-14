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

# 定义安装 Term::Animation 模块的函数
install_term_animation_module() {
    cpanm --sudo Term::Animation
}

# 判断操作系统并安装依赖
if [ -f /etc/os-release ]; then
    # 加载操作系统信息
    . /etc/os-release
    
    if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
        # Debian 或 Ubuntu
        sudo apt-get update
        sudo apt-get install -y cpanminus
        install_term_animation_module

    elif [ "$ID" = "centos" ]; then
        # CentOS
        sudo yum check-update
        sudo yum install -y perl-App-cpan
        

# 定义安装 Perl Curses 模块的函数
install_perl_curses_module() {
    cpan App::cpanminus
    cpanm Curses
}

# 定义安装 asciiquarium 的函数
install_asciiquarium() {
    wget http://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz
    tar zxvf asciiquarium.tar.gz
    cd asciiquarium_*/
    chmod +x asciiquarium
    sudo cp asciiquarium /usr/local/bin
}

# 判断操作系统并安装依赖
if [ -f /etc/os-release ]; then
    # 加载操作系统信息
    . /etc/os-release
    
    if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
        # Debian 或 Ubuntu
        sudo apt-get update
        sudo apt-get install -y cpanminus wget libncurses5-dev make gcc
        install_perl_curses_module
        install_asciiquarium

    elif [ "$ID" = "centos" ]; then
        # CentOS
        sudo yum check-update
        sudo yum install -y perl-CPAN wget ncurses-devel gcc make
        install_perl_curses_module
        install_asciiquarium
    else
        echo "此脚本不支持的Linux发行版：$ID"
        exit 1
    fi
else
    echo "无法确定操作系统。"
    exit 1
fi

echo "asciiquarium 安装完成，可以通过运行 'asciiquarium' 来启动。"

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
