# Node.js v23.2.0 for OpenWrt / iStoreOS

预编译的 Node.js v23.2.0，适用于 **OpenWrt / iStoreOS** (arm64, musl libc)。

## 🎯 特色

- ✅ **开箱即用**：解释器路径和 ICU 数据路径已修复，无需手动 patchelf
- ✅ **纯 musl**：专为 OpenWrt/musl 环境编译
- ✅ **arm64 架构**：适用于 iStoreOS 及同类固件

## 📦 包含组件

- `node` v23.2.0
- `npm` 10.9.1
- `npx` 10.9.1
- 完整 ICU 数据 ( bundled )

## 🚀 安装

```bash
# SSH 登录路由器后执行：
cd /tmp
curl -L https://github.com/a10463981/node-openwrt-arm64/releases/download/v23.2.0/node-v23.2.0-openwrt-arm64.tar.gz -o node.tar.gz
tar -xzf node.tar.gz
sh install.sh
source /etc/profile.d/node23.sh
node --version
```

## ✅ 验证

```bash
node --version   # v23.2.0
npm --version    # 10.9.1
```

## 📝 说明

本项目重新打包了 [10000ge10000/luci-app-openclaw](https://github.com/10000ge10000/luci-app-openclaw) 提供的预编译版，并修复了 OpenWrt 兼容性问题：
- 修正动态链接器路径 (`/opt/openclaw/node/lib/ld-musl-aarch64.so.1` → `/lib/ld-musl-aarch64.so.1`)
- 设置 `NODE_ICU_DATA` 环境变量指向 bundled ICU 数据

## ⚠️ 兼容性

| 项目 | 要求 |
|------|------|
| CPU 架构 | arm64 / aarch64 |
| 系统库 | musl libc (非 glibc) |
| 适用固件 | OpenWrt, iStoreOS, ImmortalWrt 等 |

## 📄 许可证

Node.js 本身为 MIT 许可证。本仓库仅重新打包，不修改 Node.js 源代码。
