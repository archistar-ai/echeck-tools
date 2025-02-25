# echeck-tools
echeck-tools - public repo with the tools to support coding echeck customizations

## Run following command in your powershell

### Windows
```
$repo="https://github.com/archistar-ai/echeck-tools.git"; $temp="/tmp/echecktools-cloned"; git clone $repo $temp; Write-Host $temp; pwsh -NoProfile -ExecutionPolicy Bypass -File "$temp/install.ps1"; Remove-Item -Recurse -Force $temp
```

### Linux / MacOS
```
$repo="https://github.com/archistar-ai/echeck-tools.git"; $temp="/tmp/echecktools-cloned"; git clone $repo $temp; Write-Host $temp; pwsh -NoProfile -ExecutionPolicy Bypass -File "$temp/install.ps1"; Remove-Item -Recurse -Force $temp
```

