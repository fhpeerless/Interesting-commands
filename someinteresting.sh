#!/bin/bash

echo "请选择要安装和运行的工具："
echo "1) asciiquarium (水族馆)"
echo "2) cmatrix (黑色帝国)"
echo "3) cowsay (会说话的牛)"
echo "4) sl (动力火车)"
echo "5) hollywood (好莱坞黑客动态界面)"
echo "6) bastet (俄罗斯方块)"

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

# 安装 Term::Animation 模块
install_term_animation_module() {
    sudo cpanm Term::Animation
}

# 安装 Perl Curses 模块
install_perl_curses_module() {
    sudo cpanm Curses
}

# 下载并安装 asciiquarium
install_asciiquarium() {
    wget http://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz
    tar zxvf asciiquarium.tar.gz
    cd asciiquarium_*/
    chmod +x asciiquarium
    sudo cp asciiquarium /usr/local/bin
}

install_cowsay() {
    if [ -f /etc/debian_version ]; then
        # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install -y cowsay
    elif [ -f /etc/redhat-release ]; then
        # CentOS
        sudo yum install -y cowsay
    else
        echo "不支持的操作系统"
        exit 1
    fi
}

read -p "输入你的选择: " choice

case $choice in
    1)

# 主程序
if [ -f /etc/os-release ]; then
    . /etc/os-release
    
    if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
        sudo apt-get update
        sudo apt-get install -y cpanminus wget libncurses5-dev make gcc
        install_perl_curses_module
        install_term_animation_module
        install_asciiquarium

    elif [ "$ID" = "centos" ]; then
        sudo yum check-update
        sudo yum install -y perl-App-cpanminus wget ncurses-devel gcc make
        install_perl_curses_module
        install_term_animation_module
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
    3)install_cowsay
mkk=$(which cowsay)
# 加载变量
source ~/.bashrc 
if [ -z "$mkk" ]; then
    echo "找不到 cowsay 命令。"
else
    echo "找到 cowsay 命令，路径为: $mkk"
fi
/usr/games/cowsay "Hello, world!"
cowsay "Hello, world!"
echo "手动执行 cowsay "要说的话""
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
