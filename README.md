# Uninstall or hide unnecessary Windows Update (KBxxxxx)
My PC made by Core i5-750 and DDR3 memory and bad sector increased 5400rpm HDD. I will upgrade to Windows 10 but my PC is old. Then when I change CPU and M/B, re-activation is bothersome. However Microsoft remind me quite often.

## Require
- Windows 7
- PowerShell module, PSWindowsUpdate

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

## Notes
You will notice difference Get-WUList -IsHidden and GUI. However it is no problem.
