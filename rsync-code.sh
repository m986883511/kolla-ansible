#!/bin/bash
# auther: wc
# filename: rsync-code.sh
set -e
set -u
# 获取当前脚本文件所在的目录的绝对路径
SCRIPT_DIR="$(basename $(cd "$(dirname "$0")" && pwd -P))"

echo "当前脚本文件所在的目录：$SCRIPT_DIR"

# 判断是否只传了2个参数，并且判断传入的第一个参数是ip，第二个参数是root密码
if [ $# -ne 2 ]; then
    echo "ERROR: Usage: ip root_password"
    exit 1
else
    remote_ip=$1
    if [[ ! $remote_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "ERROR: Usage: param1 should be ip"
        exit 1
    fi
    root_password=$2
fi

sshpass -p $root_password ssh -o 'StrictHostKeyChecking no' root@$remote_ip "mkdir -p /root/rsync/$SCRIPT_DIR"
rsync -avz -e "sshpass -p $root_password ssh -o 'StrictHostKeyChecking no'" --exclude "*.git" . root@$remote_ip:/root/rsync/$SCRIPT_DIR