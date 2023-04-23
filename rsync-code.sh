#!/bin/bash
# auther: wc
# filename: rsync-code.sh
set -e
set -u
# 获取当前脚本文件所在的目录的绝对路径
SCRIPT_DIR="$(basename $(cd "$(dirname "$0")" && pwd -P))"

echo "当前脚本文件所在的目录：$SCRIPT_DIR"

# 判断是否只传了1个参数，并且传入的参数是否是ip
if [ $# -eq 1 ] && [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    remote_ip=$1
else
    echo "ERROR: 需要传入一个ip地址"
    exit 1
fi


sshpass -p donotuseroot! ssh -o 'StrictHostKeyChecking no' root@$remote_ip "mkdir -p /root/rsync/$SCRIPT_DIR"
rsync -avz -e "sshpass -p donotuseroot! ssh -o 'StrictHostKeyChecking no'" --exclude "*.git" . root@$remote_ip:/root/rsync/$SCRIPT_DIR