# echeck-tools
echeck-tools - public repo with the tools to support coding echeck customizations

## Run following command in your powershell

### Windows / Linux / MacOS
```
$repo="https://github.com/archistar-ai/echeck-tools.git"; $temp="~/echeck-tools-cloned"; git clone $repo $temp; Write-Host $temp; cd $temp; pwsh -NoProfile -ExecutionPolicy Bypass -File "install.ps1"; cd ~; Remove-Item -Recurse -Force $temp
```