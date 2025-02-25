# Echeck Tools
echeck-tools - public repo with the tools to support coding echeck customizations

## Install

### PowerShell

#### Run following command/script on PowerShell (pwsh)
```
$repo="https://github.com/archistar-ai/echeck-tools.git"; $temp="~/echeck-tools-cloned"; git clone $repo $temp; Write-Host $temp; cd $temp; pwsh -NoProfile -ExecutionPolicy Bypass -File "install.ps1"; cd ~; Remove-Item -Recurse -Force $temp
```

## Tools
- ArchiNuGetClean
- VS 2022 Coding Templates

## ArchiNuGetClean
> "ArchiNuGetClean" is a powerful PowerShell command allows you to clean your current ECheck development packages easily and efficiently without remembering what needs to be done.

## VS 2022 Coding Templates

#### TemplateCustomOperation
> "TemplateCustomOperation" helps you to setup your new ECheck Custom Operation quickly and with the standards we recommend.
