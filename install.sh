#!/bin/sh
# Node.js v23.2.0 for OpenWrt / iStoreOS (arm64 / musl)
# 安装到 /opt/node23（推荐位置，ramdisk 或 overlay）
# 同时在 /usr/local/bin/ 创建系统级 wrapper，任何插件均可直接调用 node/npm/npx

set -e

# 检测安装目录，默认 /opt/node23（支持自定义）
INSTALL_DIR="${INSTALL_DIR:-/opt/node23}"

echo "==> 安装 Node.js v23.2.0 到 $INSTALL_DIR"

# 创建目标目录
mkdir -p "$INSTALL_DIR"

# 解压到目标目录
cp -r bin lib share node npm npx "$INSTALL_DIR/"

# ============================================================
# 1. 创建 /etc/profile.d/ 环境变量（兼容原有方式）
# ============================================================
mkdir -p /etc/profile.d
cat > /etc/profile.d/node23.sh << 'ENV'
export PATH=/opt/node23/bin:$PATH
export NODE_ICU_DATA=/opt/node23/share/icu
export LD_LIBRARY_PATH=/opt/node23/lib:$LD_LIBRARY_PATH
ENV
chmod +x /etc/profile.d/node23.sh

# ============================================================
# 2. 在 /usr/local/bin/ 创建真正的 wrapper 脚本（绝对路径）
#    这样所有 OpenWrt 插件无需配置 PATH 即可调用 node/npm/npx
# ============================================================
cat > /usr/local/bin/node << 'WRAPPER'
#!/bin/sh
# Node.js wrapper - 将调用重定向到 /opt/node23
exec /opt/node23/bin/node "$@"
WRAPPER
chmod +x /usr/local/bin/node

cat > /usr/local/bin/npm << 'WRAPPER'
#!/bin/sh
# npm wrapper - 使用绝对路径找到 Node.js 和库文件
export NODE_ICU_DATA=/opt/node23/share/icu
export LD_LIBRARY_PATH=/opt/node23/lib:$LD_LIBRARY_PATH
exec /opt/node23/bin/node /opt/node23/lib/node_modules/npm/bin/npm-cli.js "$@"
WRAPPER
chmod +x /usr/local/bin/npm

cat > /usr/local/bin/npx << 'WRAPPER'
#!/bin/sh
# npx wrapper - 使用绝对路径找到 Node.js 和库文件
export NODE_ICU_DATA=/opt/node23/share/icu
export LD_LIBRARY_PATH=/opt/node23/lib:$LD_LIBRARY_PATH
exec /opt/node23/bin/node /opt/node23/lib/node_modules/npm/bin/npx-cli.js "$@"
WRAPPER
chmod +x /usr/local/bin/npx

echo ""
echo "==> 安装完成！"
echo ""
echo "    系统路径（推荐，OpenWrt 插件直接调用）："
echo "    /usr/local/bin/node   -> /opt/node23/bin/node"
echo "    /usr/local/bin/npm    -> /opt/node23/lib/node_modules/npm/bin/npm-cli.js"
echo "    /usr/local/bin/npx    -> /opt/node23/lib/node_modules/npm/bin/npx-cli.js"
echo ""
echo "    环境变量（登录 shell 可用）："
echo "    source /etc/profile.d/node23.sh"
echo ""
echo "    验证："
echo "    /usr/local/bin/node --version   # 应显示 v23.2.0"
echo "    /usr/local/bin/npm --version    # 应显示 10.9.1"
echo ""
echo "    安装位置: $INSTALL_DIR"
echo "    二进制文件: $INSTALL_DIR/bin/"
echo "    库文件: $INSTALL_DIR/lib/"
echo "    ICU 数据: $INSTALL_DIR/share/icu/"