# dotfiles
My dotfiles

## 配置目录

| 目录 | 内容 | Windows 部署位置 |
| --- | --- | --- |
| `nvim/` | Neovim / LazyVim | `%LOCALAPPDATA%\nvim`，本机已有目录符号链接 |
| `windows-terminal/` | 窗口外观、终端配色、字体、快捷键和会话配置 | Microsoft Store 版 Windows Terminal 的 `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json` |
| `powershell/` | PowerShell 7 profile、PSReadLine 配色、别名和 Oh My Posh 提示符 | PowerShell 7 的 `$PROFILE.CurrentUserCurrentHost` 所在目录 |

## 在另一台 Windows 电脑使用

- 在 Windows Terminal 设置里点击「打开 JSON 文件」确认实际路径，再复制 `windows-terminal/settings.json` 到该位置。
- 将 `powershell/` 的两个文件一起复制到 `Split-Path -Parent $PROFILE.CurrentUserCurrentHost` 返回的目录。Profile 依赖 `zoxide` 和 `oh-my-posh`，并通过 `$PSScriptRoot` 读取同目录的提示符配色。
