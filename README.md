# Uninstall or hide unnecessary Windows Update (KBxxxxx)
My PC is made by Core i5 750 and DDR3 memory and bad sector increased 5400rpm HDD. I will change PC parts and I will upgrade to Windows 10. But my PC is old as menthoned in the introduction. Then when I have changed CPU and M/B and so on, re-activation is bothersome. However Microsoft remind me quite often. Moreover, Microsoft trap some update data.

## Require
- Windows 7
- Installing PowerShell module, PSWindowsUpdate.

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

## License
Copyright (c) 2016 tkumata

This software is release under the MIT License, please see [MIT](http://opensource.org/licenses/mit-license.php)

## Author
[tkumata](https://github.com/tkumata)

## Notes
You will notice difference Get-WUList -IsHidden and GUI. However it is no problem.

By the way, this script gets Unblock-File commandlet error. Standard Windows 7 does not have Unblock-File. So please ignore this error.

KB3035583, KB3135445 are trap!!! Please hide this manually. Then please execute this script.
