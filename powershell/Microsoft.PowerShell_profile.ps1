# zoxide 智能目录跳转
Invoke-Expression (& { (zoxide init powershell | Out-String) })

oh-my-posh init pwsh --config (Join-Path $PSScriptRoot 'github-light-default.omp.json') --eval | Invoke-Expression


$smartTabHandler = {
    # 尝试执行右箭头的历史填充功能
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()

    # 检查命令是否变化（历史填充是否生效）
    $newLine = $null
    $newCursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$newLine, [ref]$newCursor)
    
    # 如果命令未变化（没有历史建议），则执行 Tab 补全
    if ($line -eq $newLine) {
        [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
    }
}

# 设置智能 Tab 处理
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock $smartTabHandler

Set-Alias -Name d -Value nr
Set-Alias -Name ql -Value qodercli
Set-Alias -Name n -Value nvim

# git: resolve branch for a commit sha (git log --all --source)
function gn {
    if (-not $args) {
        Write-Host 'Usage: gn <sha> [git log options]' -ForegroundColor DarkYellow
        return
    }

    $sha = $args[0]
    $options = @($args | Select-Object -Skip 1)

    $fullSha = "$(git rev-parse --verify --quiet "$sha^{commit}")".Trim()
    if (-not $fullSha) {
        Write-Host "unknown revision '$sha'" -ForegroundColor Red
        return
    }

    # 遍历所有 ref 时 git 会记录"第一个走到该提交的 ref"，比 git name-rev 稳，不会被发布分支抢
    $hit = git log --all --source --format='%H%x09%S' --no-color @options 2>$null |
        Where-Object { $_.StartsWith("$fullSha`t") } |
        Select-Object -First 1

    if (-not $hit) {
        Write-Host 'undefined' -ForegroundColor DarkYellow
        return
    }

    $ref = (($hit -split "`t", 2)[1] -split '\s+', 2)[0]
    $ref = $ref -replace '^refs/', ''
    $ref = $ref -replace '^remotes/[^/]+/', ''
    $ref = $ref -replace '^heads/', ''
    $ref
}

# yazi 预览依赖 file(1) 探测 MIME，指向 Git 自带的 file.exe
$env:YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'


# GitHub Light Default (Primer)
$githubSelection = $PSStyle.Foreground.FromRgb(0x1F2328) + $PSStyle.Background.FromRgb(0xADD6FF)
Set-PSReadLineOption -Colors @{
    ContinuationPrompt     = '#57606A'
    Emphasis               = '#0969DA'
    Selection              = $githubSelection
    InlinePrediction       = '#656D76'
    ListPrediction         = '#6639BA'
    ListPredictionSelected = $githubSelection
    ListPredictionTooltip  = '#656D76'
    Command                = '#0969DA'
    Comment                = '#656D76'
    Default                = '#1F2328'
    Error                  = '#CF222E'
    Keyword                = '#CF222E'
    Member                 = '#6639BA'
    Number                 = '#0550AE'
    Operator               = '#1F2328'
    Parameter              = '#6639BA'
    String                 = '#0A3069'
    Type                   = '#116329'
    Variable               = '#953800'
}

$PSStyle.Formatting.Debug                  = $PSStyle.Foreground.FromRgb(0x0550AE)
$PSStyle.Formatting.Error                  = $PSStyle.Foreground.FromRgb(0xCF222E)
$PSStyle.Formatting.ErrorAccent            = $PSStyle.Foreground.FromRgb(0x0969DA)
$PSStyle.Formatting.FormatAccent           = $PSStyle.Foreground.FromRgb(0x0969DA)
$PSStyle.Formatting.TableHeader            = $PSStyle.Foreground.FromRgb(0x57606A)
$PSStyle.Formatting.Verbose                = $PSStyle.Foreground.FromRgb(0x656D76)
$PSStyle.Formatting.Warning                = $PSStyle.Foreground.FromRgb(0x9A6700)
$PSStyle.Formatting.CustomTableHeaderLabel = $PSStyle.Formatting.TableHeader + $PSStyle.Italic
$PSStyle.Formatting.FeedbackName           = $PSStyle.Formatting.Warning
$PSStyle.Formatting.FeedbackText           = $PSStyle.Foreground.FromRgb(0x656D76)
$PSStyle.Formatting.FeedbackAction         = $PSStyle.Formatting.ErrorAccent
$PSStyle.FileInfo.Directory                = $PSStyle.Formatting.ErrorAccent + $PSStyle.Bold
$PSStyle.FileInfo.SymbolicLink             = $PSStyle.Formatting.FormatAccent
$PSStyle.FileInfo.Executable               = $PSStyle.Foreground.FromRgb(0x1A7F37)
$PSStyle.Progress.Style                   = $PSStyle.Formatting.ErrorAccent
