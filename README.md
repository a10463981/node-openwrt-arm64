# Node.js for OpenWrt / iStoreOS

专为 **OpenWrt / iStoreOS** (arm64, musl libc) 打造的 Node.js 环境。

## 版本

| 版本 | Node.js | npm | 下载 |
|------|---------|-----|------|
| [v23.2.0](https://github.com/a10463981/node-openwrt-arm64/releases/tag/v23.2.0) | 23.2.0 | 10.9.1 | [下载](https://github.com/a10463981/node-openwrt-arm64/releases/download/v23.2.0/node-v23.2.0-openwrt-arm64-fixed.tar.gz) |
| [v22.15.1](https://github.com/a10463981/node-openwrt-arm64/releases/tag/v22.15.1) | 22.15.1 | 10.9.1 | [下载](https://github.com/a10463981/node-openwrt-arm64/releases/download/v22.15.1/node-v22.15.1-openwrt-arm64-fixed.tar.gz) |

## 特性

- **系统路径安装**：Node.js 安装到 `/opt/node23`，`node`/`npm`/`npx` 链接到 `/usr/local/bin/`，**所有 OpenWrt 插件均可直接调用，无需额外配置 PATH**
- **适配 musl**：专为 OpenWrt/musl 交叉编译
- **arm64 架构**：兼容 iStoreOS 等固件
- **完整 ICU**：内置 ICU 数据，支持 Unicode 规范化和国际化功能

## 安装后的文件布局

```
/opt/node23/          # 安装根目录
├── bin/node           # Node.js 主程序
├── lib/               # 动态链接库、node_modules
└── share/icu/        # ICU 数据

/usr/local/bin/node    # -> /opt/node23/bin/node（系统路径，所有插件可用）
/usr/local/bin/npm     # -> npm CLI（系统路径）
/usr/local/bin/npx     # -> npx CLI（系统路径）
```

## 安装

SSH 登录路由器后执行：

```bash
# v23.2.0
curl -L https://github.com/a10463981/node-openwrt-arm64/releases/download/v23.2.0/node-v23.2.0-openwrt-arm64-fixed.tar.gz -o /tmp/node.tar.gz
mkdir -p /tmp/node23 && tar -xzf /tmp/node.tar.gz -C /tmp/node23
cd /tmp/node23/*/ && sh install.sh

# 验证（无需 source 任何文件，直接用系统路径）
node --version
npm --version
```

## 验证

```bash
node --version   # v23.2.0
npm --version    # 10.9.1
```

## 自定义安装路径

```bash
INSTALL_DIR=/自定义路径 sh install.sh
```

## 来源

基于 [10000ge10000/luci-app-openclaw](https://github.com/10000ge10000/luci-app-openclaw) 预编译包修改

## 系统要求

| 项目 | 要求 |
|------|------|
| CPU 架构 | arm64 / aarch64 |
| 系统 | musl libc（非 glibc）|
| 目标固件 | OpenWrt, iStoreOS, ImmortalWrt 等 |

## 许可证

Node.js 源码为 MIT 许可证授权。本仓库可自由再分发，无需保留来源。
