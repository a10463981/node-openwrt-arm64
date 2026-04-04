#!/bin/sh
# Node.js v23.2.0 for OpenWrt / iStoreOS (arm64 / musl)
# 预修复版：解释器路径 + ICU 数据路径 已修正，开箱即用

set -e

DEST_DIR="${DEST_DIR:-/mnt/sata1-1/node23}"
NODE_DIR="$DEST_DIR/node-v23.2.0-openwrt-arm64"

echo "==> 安装 Node.js v23.2.0 到 $NODE_DIR"

mkdir -p "$NODE_DIR"
cp -r node npm npx lib share "$NODE_DIR/"

# 环境变量配置
mkdir -p /etc/profile.d
cat > /etc/profile.d/node23.sh << 'ENV'
export PATH={{NODE_DIR}}/bin:$PATH
export NODE_ICU_DATA={{NODE_DIR}}/share/icu
export LD_LIBRARY_PATH={{NODE_DIR}}/lib:$LD_LIBRARY_PATH
ENV
sed "s|{{NODE_DIR}}|$NODE_DIR|g" /etc/profile.d/node23.sh > /etc/profile.d/node23.sh.tmp && mv /etc/profile.d/node23.sh.tmp /etc/profile.d/node23.sh
chmod +x /etc/profile.d/node23.sh

echo "==> 安装完成！执行以下命令生效："
echo "    source /etc/profile.d/node23.sh"
echo "    node --version   # 应显示 v23.2.0"
echo "    npm --version    # 应显示 10.9.1"
