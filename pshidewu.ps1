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
 # いらんこリスト last modify at 2016/03/02

KB2952664 Win10アプグレ関連(Application Experience) (Win7用)
KB2990214 Win10アプグレ関連(Win7用WindowsUpdateクライアント 詳細は ※備考 参照)
KB3021917 CEIP＆テレメトリ(遠隔情報収集)関連
KB3035583 Win10アプグレ関連 1
KB3035583 Win10アプグレ関連 2
KB3050265 Win7用WindowsUpdateクライアント (Win10アプグレ関連と思われるファイル有)
KB3065987 Win7用WindowsUpdateクライアント (同上)
KB3068708 テレメトリ関連
KB3075249 テレメトリ関連
KB3075851 Win7用WindowsUpdateクライアント (同上)
KB3080149 テレメトリ関連
KB3083324 Win7用WindowsUpdateクライアント (同上)
KB3083710 Win7用WindowsUpdateクライアント (同上)
KB3102810 Win7用WindowsUpdateからWin10にアプグレ時の不具合の修正
KB3112343 Win7用WindowsUpdateクライアント Win10アプグレ関連+KB3050265の不具合修正
KB3123862 Win10アプグレ関連
KB3135445 Win7用WindowsUpdateクライアント
KB3138612 Win7用WindowsUpdateクライアント

KB2977759 CEIP関連
KB3022345 テレメトリ関連

(注: KB2952664 は環境によっては中々消えない問題が発生しております。その際は何度も(数回～数十回)アンスコする必要有)

 #>

param (
    [string]$check,
    [string[]]$noWUKBs = @("KB2952664","KB2990214","KB3021917","KB3035583","KB3035583","KB3050265","KB3065987","KB3068708","KB3075249","KB3075851","KB3080149","KB3083324","KB3083710","KB3102810","KB3112343","KB3123862","KB3135445","KB3138612","KB2977759","KB3022345")
)

Import-Module PSWindowsUpdate

$ServiceID = Get-WUServiceManager | Select ServiceID
# echo $ServiceID
# Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false
# Add-WUServiceManager -ServiceID 9482f4b4-e343-43b6-b170-9a65bc822c77 -Confirm:$false

function toUninstall() {
    echo "Searching unnecessary already installed updates for Windows7."
    $flag = 0
    Get-WUList -IsInstalled -MicrosoftUpdate -Verbose |
        % {
            $installedKB = $_.KB
            if ($noWUKBs -contains $installedKB) {
                echo "Found unnecessary $installedKB. Uninstall this."
                $flag = 1
                Get-WUUninstall -KBArticleID $installedKB -confirm:$false
                Start-Sleep -s 10
            }
        }
    
    if ($flag -eq 1) {
        echo "Next, please execute `"pshidewu.ps1 -check new`" for to hide."
    }
    
    echo "Searching finished."
}

function toHidden() {
    echo "Searching unnecessary updates in new updates for Windows7."
    Get-WUList -IsNotHidden -MicrosoftUpdate -Verbose |
        % {
            $notHiddenKB = $_.KB
            if ($noWUKBs -contains $notHiddenKB) {
                echo "Found unnecessary $notHiddenKB. Hidden this."
                Hide-WUUpdate -KBArticleID $notHiddenKB -confirm:$false
                Start-Sleep -s 10
            }
        }
    echo "Searching finished."
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
        Start-Sleep -s 60
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

# $hiddenItems = Get-WUList -IsHidden -Verbose
# foreach ($hiddenItem in $hiddenItems) {
#     $hiddenKB = $hiddenItem.KB
#     if ($noWUKBs -contains $hiddenKB) {
#         echo "$hiddenKB is hidden already."
#     } else {
#         echo "$hiddenKB is not hidden yet."
#     }
# }

# if ($noWUKBs.Length -eq $hiddenItems.Length) {
#     echo "OK"
# } else {
#     Hide-WUUpdate -KBArticleID $noWUKBs -confirm:$false
# }
