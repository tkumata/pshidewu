# PowerShell script as uninstall or hide unnecessary Windows Update (KBxxxxx)

## Require
- Windows 7
- PowerShell module, PSWindowsUpdate

## Usage
Search and uninstall in already installed updates.
```
Open PowerShell as administrator and run following,
PS> pshidewu.ps1 -check installed
```
Search and hide in Windows Update List.
```
Open PowerShell as administrator and run following,
PS> pshidewu.ps1 -check new
```

## Notes
