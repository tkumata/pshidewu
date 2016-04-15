<#
 # pshidewu.ps1
 #
 # Usage:
 #     pshidewu.ps1 -check new
 #     pshidewu.ps1 -check installed
 #
 # Require:
 #     PSWindowsUpdate module for PowerShell
 #
 # いらんこリスト last modify at 2016/04/13

KB2952664 Win10アプグレ関連(Application Experience) (Win7用) (注: KB2952664 は環境によっては中々消えない問題が発生しております。その際は何度も(数回～数十回)アンスコする必要有)
KB2977759 CEIP関連
KB2990214 Win10アプグレ関連(Win7用WindowsUpdateクライアント 詳細は ※備考1 参照)
KB3021917 CEIP＆テレメトリ(遠隔情報収集)関連
KB3022345 テレメトリ関連
KB3035583 Win10アプグレ関連
KB3068708 テレメトリ関連
KB3075249 テレメトリ関連
KB3080149 テレメトリ関連
KB3123862 Win10アプグレ関連
KB3050265 Win7用WindowsUpdateクライアント (Win10アプグレ関連と思われるファイル有)
KB3065987 Win7用WindowsUpdateクライアント (同上)
KB3075851 Win7用WindowsUpdateクライアント (同上)
KB3083324 Win7用WindowsUpdateクライアント (同上)
KB3083710 Win7用WindowsUpdateクライアント (同上)
KB3102810 Win7用WindowsUpdateからWin10にアプグレ時の不具合の修正
KB3112343 Win7用WindowsUpdateクライアント Win10アプグレ関連+KB3050265の不具合修正
KB3135445 Win7用WindowsUpdateクライアント
KB3138612 Win7用WindowsUpdateクライアント
KB3139929 IE11 patch with Win10アプグレ関連

2016/04/13 追記
KB3148198 IE11 patch with Win10アプグレ関連
KB2965664 Win10アプグレ関連
 #>
param (
    [string]$check,
    [string[]]$noKBs = @("KB2952664","KB2990214","KB3021917","KB3035583","KB3050265","KB3065987","KB3068708","KB3075249","KB3075851","KB3080149","KB3083324","KB3083710","KB3102810","KB3112343","KB3123862","KB3135445","KB3138612","KB2977759","KB3022345","KB3139929","KB3148198","KB2965664")
)

Import-Module PSWindowsUpdate
$ServiceID = Get-WUServiceManager | Select ServiceID

# workaround bug that prompt does not return.
$ServiceID = Get-WUServiceManager | Select ServiceID
echo $ServiceID

function toUninstall() {
    echo "Uninstalling unnecessary already installed updates for Windows7..."
    foreach($noKB in $noKBs) {
        $articleID = $noKB -replace "KB", ""
        echo $articleID
        $UninstallCommand = "wusa.exe /uninstall /kb:$articleID /quiet /norestart"
        Invoke-Expression $UninstallCommand
        echo "Waiting for update removal to finish ..."
        while (@(Get-Process wusa -ErrorAction SilentlyContinue).Count -ne 0) {
            Start-Sleep -s 10
        }
    }
    echo "Uninstalling finished."
}

function toHidden() {
    echo "Searching unnecessary updates in new updates for Windows7."
    $local:findKBs = @()
    Get-WUList -IsNotHidden -WindowsUpdate -confirm:$false |
        % {
            $notHiddenKB = $_.KB
            if ($noKBs -contains $notHiddenKB) {
                echo "Found unnecessary $notHiddenKB. Hidden this."
                $findKBs += $notHiddenKB
                $_.IsHidden = $true
            }
        }
    
    if ($findKBs.Length -gt 0) {
        echo "Hidding updates..."
        Hide-WUUpdate -KBArticleID $findKBs -confirm:$false
    }
    echo "Searching finished."
    echo "Please reboot Windows7."
}

function hiddenUpdatesList() {
    echo "Checking hidden updates."
    $hiddenUpdates = Get-WUList -IsHidden
    foreach ($hiddenUpdate in $hiddenUpdates) {
        echo $hiddenUpdate
    }
    $n = $hiddenUpdates.Length
    echo "Total: $n hidden."
}

switch ($check) {
    "installed" {
        toUninstall
    }
    "new" {
        toHidden
    }
    "hiddenlist" {
        hiddenUpdatesList
    }
    "all" {
        toUninstall
        Start-Sleep -s 20
        toHidden
    }
    default {
        echo "Usage:"
        echo "Uninstall unnecessary updates in installed updates."
        echo "    ./pshidewu.ps1 -check installed"
        echo "To hide unnecessary updates in new updates."
        echo "    ./pshidewu.ps1 -check new"
    }
}
