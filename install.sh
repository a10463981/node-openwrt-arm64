#!/bin/sh
# Node.js v23.2.0 for OpenWrt / iStoreOS (arm64 / musl)
# 安装到 /opt/node23（推荐位置，ramdisk 或 overlay）

set -e

# 检测安装目录（默认 /opt/node23，支持自定义）
INSTALL_DIR="${INSTALL_DIR:-/opt/node23}"

echo "==> 安装 Node.js v23.2.0 到 $INSTALL_DIR"

# 创建目标目录
mkdir -p "$INSTALL_DIR"

# 解压到目标目录
cp -r bin lib share node npm npx "$INSTALL_DIR/"

# 创建环境变量脚本
mkdir -p /etc/profile.d
cat > /etc/profile.d/node23.sh << ENV
export PATH=$INSTALL_DIR/bin:\$PATH
export NODE_ICU_DATA=$INSTALL_DIR/share/icu
export LD_LIBRARY_PATH=$INSTALL_DIR/lib:\$LD_LIBRARY_PATH
ENV
chmod +x /etc/profile.d/node23.sh

# 创建符号链接到系统路径（可选）
ln -sf "$INSTALL_DIR/bin/node" /usr/local/bin/node 2>/dev/null || true
ln -sf "$INSTALL_DIR/bin/npm" /usr/local/bin/npm 2>/dev/null || true
ln -sf "$INSTALL_DIR/bin/npx" /usr/local/bin/npx 2>/dev/null || true

echo ""
echo "==> 安装完成！"
echo "    source /etc/profile.d/node23.sh   # 生效环境变量"
echo "    node --version   # 应显示 v23.2.0"
echo "    npm --version    # 应显示 10.9.1"
echo ""
echo "==> 安装位置: $INSTALL_DIR"
echo "    二进制: $INSTALL_DIR/bin/"
echo "    库文件: $INSTALL_DIR/lib/"
echo "    ICU数据: $INSTALL_DIR/share/icu/"
