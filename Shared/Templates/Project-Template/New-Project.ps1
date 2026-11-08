<#
.SYNOPSIS
  建立新產品專案（L1）：複製範本、連結共用 Skill、更新專案索引、（可選）git init。
.DESCRIPTION
  - 預設在 <Workspace>\Projects\<Name> 建立專案；已存在的資料夾不會被覆蓋。
  - 為專案的 .claude\skills 建立指向 <Workspace>\.claude\skills\* 的 Windows Junction（不需要系統管理員權限）。
  - -LinksOnly：只重建連結（例如在新電腦還原後、或 clone 了既有產品之後）。
  - Workspace 的決定順序：-Workspace 參數 → 環境變數 RD_WORKSPACE → 本腳本位於 <Workspace>\Shared\Templates\Project-Template\ 時的上三層。
  - 不會 git commit、不會 push。
.EXAMPLE
  .\New-Project.ps1 -Name MyTool -Purpose "個人效率小工具"
.EXAMPLE
  .\New-Project.ps1 -Name MyTool -LinksOnly
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Name,
    [string]$Workspace = $env:RD_WORKSPACE,
    [string]$Purpose = '(待填)',
    [switch]$LinksOnly,
    [switch]$NoGit
)
$ErrorActionPreference = 'Stop'

if ($Name -notmatch '^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$') {
    throw "專案名稱只能用英數字、點、底線、連字號（最長 64 字，需以英數字開頭）：$Name"
}
if (-not $Workspace) { $Workspace = Join-Path $PSScriptRoot '..\..\..' }
if (-not (Test-Path -LiteralPath $Workspace)) { throw "找不到 Workspace：$Workspace（請用 -Workspace 或環境變數 RD_WORKSPACE 指定）" }
$Workspace = (Resolve-Path -LiteralPath $Workspace).Path
$skills = Join-Path $Workspace '.claude\skills'
if (-not (Test-Path -LiteralPath (Join-Path $Workspace 'CLAUDE.md')) -or -not (Test-Path -LiteralPath $skills)) {
    throw "$Workspace 不像 Personal-RD-Workspace（缺少 CLAUDE.md 或 .claude\skills）；請確認 -Workspace。"
}
$projects = Join-Path $Workspace 'Projects'
$proj = Join-Path $projects $Name

if ($LinksOnly) {
    if (-not (Test-Path -LiteralPath $proj)) { throw "專案不存在：$proj" }
} else {
    if (Test-Path -LiteralPath $proj) { throw "專案已存在，不會覆蓋：$proj（只想重建連結請加 -LinksOnly）" }
    $src = Join-Path $PSScriptRoot 'template'
    if (-not (Test-Path -LiteralPath $src)) { throw "找不到範本資料夾：$src" }
    New-Item -ItemType Directory -Path $proj | Out-Null
    Get-ChildItem -LiteralPath $src -Force | Copy-Item -Destination $proj -Recurse -Force
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $readme = Join-Path $proj 'README.md'
    if (Test-Path -LiteralPath $readme) {
        $t = [System.IO.File]::ReadAllText($readme, $utf8)
        $t = $t.Replace('{{NAME}}', $Name).Replace('{{PURPOSE}}', $Purpose).Replace('{{DATE}}', (Get-Date -Format 'yyyy-MM-dd'))
        [System.IO.File]::WriteAllText($readme, $t, $utf8)
    }
}

# 共用 Skill 連結（Junction）：已存在就保留；不是連結的同名資料夾不動，只提醒
$linkDir = Join-Path $proj '.claude\skills'
New-Item -ItemType Directory -Path $linkDir -Force | Out-Null
foreach ($s in Get-ChildItem -LiteralPath $skills -Directory) {
    $link = Join-Path $linkDir $s.Name
    if (Test-Path -LiteralPath $link) {
        $item = Get-Item -LiteralPath $link -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { Write-Host "連結已存在：$($s.Name)" }
        else { Write-Warning "$link 已存在且不是連結，未變更。" }
        continue
    }
    New-Item -ItemType Junction -Path $link -Target $s.FullName | Out-Null
    Write-Host "已建立連結：$($s.Name) -> $($s.FullName)"
}

if (-not $LinksOnly) {
    # 專案索引：沒有這個專案才補一列
    $idx = Join-Path $projects 'PROJECT-INDEX.md'
    if (Test-Path -LiteralPath $idx) {
        $utf8 = New-Object System.Text.UTF8Encoding($false)
        $t = [System.IO.File]::ReadAllText($idx, $utf8)
        if ($t -notmatch ('\|\s*' + [regex]::Escape($Name) + '\s*\|')) {
            $row = "| $Name | $Purpose | ``./$Name/`` |"
            if (-not $t.EndsWith("`n")) { $row = "`n" + $row }
            [System.IO.File]::AppendAllText($idx, $row + "`n", $utf8)
            Write-Host "已更新專案索引：$idx"
        }
    } else { Write-Warning "找不到專案索引：$idx（請手動維護）" }
    if (-not $NoGit -and (Get-Command git -ErrorAction SilentlyContinue)) {
        git -C $proj init --quiet
        Write-Host '已 git init（尚未 commit）。'
    }
}
Write-Host "完成：$proj"
