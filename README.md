# Echeck Tools
echeck-tools - public repo with the tools to support coding echeck customizations

## Tools
```
- ArchiNuGetClean
- VS 2022 Coding Templates
```

## Install

### PowerShell

#### Run following command/script on PowerShell (pwsh)
```
$repo="https://github.com/archistar-ai/echeck-tools.git"; $temp="~/echeck-tools-cloned"; git clone $repo $temp; Write-Host $temp; cd $temp; pwsh -NoProfile -ExecutionPolicy Bypass -File "install.ps1"; cd ~; Remove-Item -Recurse -Force $temp
```
