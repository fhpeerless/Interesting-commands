#!/bin/bash

# 确定操作系统
OS="$(awk -F= '/^NAME/{print $2}' /etc/os-release)"

# CentOS 系统
if [[ $OS == *"CentOS"* ]]; then
sudo yum clean all
sudo yum makecache fast
    # 安装 EPEL 仓库
    sudo yum install -y epel-release
    # 安装 hollywood
    sudo yum install -y hollywood
# Debian 或 Ubuntu 系统
elif [[ $OS == *"Debian"* ]] || [[ $OS == *"Ubuntu"* ]]; then
sudo apt clean all
sudo apt makecache fast
    # 更新软件包列表
    sudo apt-get update
    # 安装 hollywood
    sudo apt-get install -y hollywood
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# 运行 hollywood 如果安装成功
if which hollywood >/dev/null; then
    hollywood
else
    echo "Hollywood installation failed."
    exit 1
fi
