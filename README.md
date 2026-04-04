# Node.js for OpenWrt / iStoreOS

预编译的 Node.js，适用于 **OpenWrt / iStoreOS** (arm64, musl libc)。

## 📦 版本

| 版本 | Node.js | npm | 下载 |
|------|---------|-----|------|
| [v23.2.0](https://github.com/a10463981/node-openwrt-arm64/releases/tag/v23.2.0) | 23.2.0 | 10.9.1 | [下载](https://github.com/a10463981/node-openwrt-arm64/releases/download/v23.2.0/node-v23.2.0-openwrt-arm64-fixed.tar.gz) |
| [v22.15.1](https://github.com/a10463981/node-openwrt-arm64/releases/tag/v22.15.1) | 22.15.1 | 10.9.1 | [下载](https://github.com/a10463981/node-openwrt-arm64/releases/download/v22.15.1/node-v22.15.1-openwrt-arm64-fixed.tar.gz) |

## 🎯 特色

- ✅ **开箱即用**：自动安装到 `/opt/node22` 或 `/opt/node23`，无需手动配置路径
- ✅ **纯 musl**：专为 OpenWrt/musl 环境编译
- ✅ **arm64 架构**：适用于 iStoreOS 及同类固件
- ✅ **完整 ICU**：内置 ICU 数据，支持 Unicode 正则等国际化功能

## 📦 包含组件

- `node` 主程序
- `npm` 包管理器
- `npx` 执行器
- 完整 ICU 数据

## 🚀 安装

SSH 登录路由器后执行：

```bash
# v23.2.0
curl -L https://github.com/a10463981/node-openwrt-arm64/releases/download/v23.2.0/node-v23.2.0-openwrt-arm64-fixed.tar.gz -o /tmp/node.tar.gz
mkdir -p /tmp/node23 && tar -xzf /tmp/node.tar.gz -C /tmp/node23
cd /tmp/node23/*/ && sh install.sh
source /etc/profile.d/node23.sh

# v22.15.1
curl -L https://github.com/a10463981/node-openwrt-arm64/releases/download/v22.15.1/node-v22.15.1-openwrt-arm64-fixed.tar.gz -o /tmp/node.tar.gz
mkdir -p /tmp/node22 && tar -xzf /tmp/node.tar.gz -C /tmp/node22
cd /tmp/node22/*/ && sh install.sh
source /etc/profile.d/node22.sh
```

## ✅ 验证

```bash
node --version
npm --version
```

## 🔧 自定义安装路径

```bash
# 安装到自定义目录
INSTALL_DIR=/自定义路径 sh install.sh
```

## 📝 源码

基于 [10000ge10000/luci-app-openclaw](https://github.com/10000ge10000/luci-app-openclaw) 预编译版修复

## ⚠️ 兼容性

| 项目 | 要求 |
|------|------|
| CPU 架构 | arm64 / aarch64 |
| 系统库 | musl libc (非 glibc) |
| 适用固件 | OpenWrt, iStoreOS, ImmortalWrt 等 |

## 📄 许可证

Node.js 本身为 MIT 许可证。本仓库仅重新打包，不修改 Node.js 源代码。
