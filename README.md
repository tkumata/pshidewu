# Uninstall and hide unnecessary Windows Update (KBxxxxx)

MS: Upgrade to Windows 10!!!!!

PC Vender: Your PC is not supported. DO NOT upgrade.

User: !?

This script uninstall or hide unnecessary Windows Updates.

I have given up to buy new CPU and mainboard etc. So I stop this project. Thanks.

## Require
- Windows 7
- PowerShell module, PSWindowsUpdate.

## Install PSWindowsUpdate
1. Dlownload [PSWindowsUpdate.zip](https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc).
2. Open property and click Unblock.
3. Extract zip file.
4. Move this folder to PS module dir. (eg, C:\Windows\System32\WindowsPowerShell\v1.0\Modules)

## Usage
Search and uninstall in already installed updates.
```
Open PowerShell as administrator and run following,
PS> /path/to/pshidewu.ps1 -check installed
```
Search and hide in Windows Update List.
```
Open PowerShell as administrator and run following,
PS> /path/to/pshidewu.ps1 -check new
```
Automatically all.
```
Open PowerShell as administrator and run following,
PS> /path/to/pshidewu.ps1 -check all
```

## Notes
You will notice difference Get-WUList -IsHidden and GUI. However it is no problem.

By the way, this script gets Unblock-File commandlet error. Standard Windows 7 does not have Unblock-File. So please ignore this error.

[Disable upgrade to Windows 10, MS Official Site](https://sway.com/JZF2z8BPmK3TChUs)

## Monologue
My PC is made by Core i5 750 and DDR3 memory and bad sector increased 5400rpm HDD. I will change PC parts and I will upgrade to Windows 10. But my PC is old as menthoned in the introduction. Then when I have changed CPU and M/B and so on, re-activation is bothersome. However Microsoft remind me quite often. Moreover, Microsoft trap some update data. So I wrote this script. I will protect Windows 7 absolutely until changing PC parts.

## License
Copyright (c) 2016 tkumata

This software is release under the MIT License, please see [MIT](http://opensource.org/licenses/mit-license.php)

## Author
[tkumata](https://github.com/tkumata)
