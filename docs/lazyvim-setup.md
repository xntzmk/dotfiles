# LazyVim 迁移流程

> 状态：配置骨架已替换为官方 starter，**尚未执行首次安装**（插件、Mason、treesitter 都未下载）。
> 生成日期：2026-10-27
> 环境：Windows 11 / PowerShell 7 / Neovim 0.12.5
> Starter：`LazyVim/starter` @ `803bc181`（2024-12-11）

## 1. 备份与回退

- 备份文件：`D:\Sync\backups\nvim-vim-pack-2026-10-27.zip`
- 内容：替换前的 7 个配置文件（含最近未提交的 vim.pack 配置）。
- 注意：旧配置的最近改动没有提交到 git，`git restore` 只能回到上次 commit，**回退请用 zip**。
- 旧插件仍在 `%LOCALAPPDATA%\nvim-data\site\pack\core\opt`，LazyVim 不会加载；确认新配置稳定后可手动清理。

回退命令（PowerShell）：

```powershell
$tmp = "$env:TEMP\nvim-restore"
Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
Expand-Archive 'D:\Sync\backups\nvim-vim-pack-2026-10-27.zip' -DestinationPath $tmp -Force
Remove-Item 'D:\Sync\dotfiles\nvim\*' -Recurse -Force
Copy-Item "$tmp\nvim\*" 'D:\Sync\dotfiles\nvim\' -Recurse -Force
```

## 2. 当前骨架

配置目录仍是符号链接：`%LOCALAPPDATA%\nvim` → `D:\Sync\dotfiles\nvim`。

```text
nvim/
├── init.lua                 # require("config.lazy")
├── lua/config/lazy.lua      # 启动 lazy.nvim + 导入 LazyVim
├── lua/config/options.lua   # 自定义 options 占位
├── lua/config/keymaps.lua   # 自定义 keymaps 占位
├── lua/config/autocmds.lua  # 自定义 autocmds 占位
├── lua/plugins/example.lua  # 官方示例（首行 return {}，不生效）
├── .neoconf.json
├── .gitignore
├── stylua.toml
├── LICENSE
└── README.md
```

LazyVim 本体和插件走 lazy.nvim，数据目录仍是 `%LOCALAPPDATA%\nvim-data`（`lazy/`、`mason/`）。

## 3. 首次安装前检查

新开一个 PowerShell（确保 scoop 的 mingw 已进 PATH）：

```powershell
gcc --version          # 需要 MinGW gcc
tree-sitter --version  # 需要 0.26+
node -v                # 项目外应为 20.x（Volta 全局）
nvim --version         # 0.12.5
```

若 `gcc` 找不到，重开终端；仍找不到则检查 `C:\Users\jiancent\scoop\apps\mingw-winlibs\current\bin` 是否在 PATH。

## 4. 首次安装（交互式执行）

GitHub 直连当前不通，首次安装使用 gh-proxy 重写 **只对当前 PowerShell 会话生效**：

```powershell
$env:CC = "gcc"

$env:GIT_CONFIG_COUNT = "1"
$env:GIT_CONFIG_KEY_0 = "url.https://gh-proxy.com/https://github.com/.insteadOf"
$env:GIT_CONFIG_VALUE_0 = "https://github.com/"

nvim
```

说明：

- `GIT_CONFIG_*` 会被 nvim 派生的 git 子进程继承，覆盖 lazy.nvim 启动引导、插件 clone、Mason registry clone。
- 首次启动会 clone lazy.nvim 并安装 LazyVim 及插件；结束后按提示重启 nvim。
- 首次会编译 treesitter parser，必须带 `CC=gcc`，否则 tree-sitter 会去找 MSVC 的 `cl.exe` 而失败。
- 这些环境变量只对当前 shell 生效；以后执行 `:Lazy update` 前也要重新设置，或使用下面的按需函数。

可选：在 `$PROFILE` 里加一个按需函数，不要全局常开（避免影响所有 git 操作）：

```powershell
function Enable-GhProxy {
  $env:GIT_CONFIG_COUNT = "1"
  $env:GIT_CONFIG_KEY_0 = "url.https://gh-proxy.com/https://github.com/.insteadOf"
  $env:GIT_CONFIG_VALUE_0 = "https://github.com/"
}
```

如果 lazy.nvim 自身 clone 失败，可手动补：

```powershell
git clone --filter=blob:none --branch=stable https://gh-proxy.com/https://github.com/folke/lazy.nvim.git "$env:LOCALAPPDATA\nvim-data\lazy\lazy.nvim"
```

然后重新 `nvim`。

## 5. 启用 Vue 支持

首次安装完成后：

1. `:LazyExtras`，启用 **`lang.vue`**（会带上 `lang.typescript`、Vue/CSS treesitter、`vue_ls` + `vtsls`）。
2. `:Mason` 确认 `vue-language-server`、`vtsls` 已安装（本机之前已装过，Mason 会复用）。
3. `:TSUpdate` 或 `:TSInstall vue tsx typescript css scss html`，同样需要 `CC=gcc`。
4. 打开一个 `.vue` 验证：高亮、`gd`、`K`、补全、`:LazyHealth`。

## 6. 本机已知问题

### 6.1 gwms-web 用 Volta 锁了 Node 14

LazyVim 的 LSP 默认以项目根为 cwd，`vue_ls`/`vtsls` 会跑在 Node 14 下，Volar 3 会因 `??=` 语法直接崩溃（大项目首次还会等 tsconfig 初始化约 1 分钟）。

已应用修复：`lua/plugins/vue.lua` 给两个 server 设 `cmd_cwd = vim.fn.stdpath("data")`，让语言服务从项目外启动、使用全局 Node 20；项目的 Node 14 和依赖不变。

已验证：两个 client 的 `cmd_cwd` 为 `nvim-data`，`vue_ls` 能正常响应，LSP 日志不再出现 `Unexpected token '??='`。

### 6.2 i18n 生成文件拖慢 TS 工程

gwms-web 的 `src/i18n` 有约 23.6k 个 TS 文件，占全部 TS 文件的 93%。可在项目 `tsconfig.json` 评估：

```json
"exclude": ["node_modules", "src/i18n/lang"]
```

属于团队共享改动，需走评审；Vite 构建不受影响，只是 `vue-tsc` 不再检查这些生成的文案文件。

### 6.3 blink.cmp 预编译库

如果 LazyVim 默认补全使用 blink.cmp 且 GitHub Releases 下载失败，可在 `lua/plugins/blink.lua` 设置：

```lua
return {
  {
    "saghen/blink.cmp",
    opts = { fuzzy = { implementation = "lua" } },
  },
}
```

### 6.4 网络

- 直连 `github.com:443` 当前不通；gh-proxy 的 clone 已验证可用。
- 插件更新、Mason 安装都需要重新带代理环境变量。

## 7. 验收清单

- [ ] `nvim` 可启动，`:Lazy` 无报错
- [ ] `:LazyHealth` 通过
- [ ] `:checkhealth` 无关键错误
- [ ] `:Mason` 中 vue-language-server / vtsls 已安装
- [ ] `.vue` 有 treesitter 高亮与注入
- [ ] `gd` / `K` / 补全可用
- [ ] `:LazyExtras` 中已启用 `lang.vue`
- [ ] 如需 gitsigns / prettier / eslint，通过对应 extras 启用

## 8. 后续按需迁移的旧自定义

旧配置在备份 zip 中，重点文件：

- `lua/keymaps.lua`：Ctrl+S（n/i/v）
- `lua/pack.lua`：conform + prettier、Yazi、blink 版本锁定、gitsigns
- `lua/lsp.lua`：vue_ls + vtsls、Node 20 修复、首个响应的 `gd`/`K`
- `lua/options.lua`：leader=space、窗口移动、tab 设置

LazyVim 已自带大部分能力（LSP 键位、补全、treesitter、gitsigns、格式化/格式化 extras），建议先只用 extras，确实缺的再按 LazyVim 的 spec 写法迁移，不要直接复制旧文件。
