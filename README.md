# echeck-tools
echeck-tools - public repo with the tools to support coding echeck customizations

## Run following command in your powershell
```
$repoUrl="https://github.com/archistar-ai/echeck-tools.git"; $tempDir=[System.IO.Path]::Combine($env:TEMP, "echeck-tools"); git clone $repoUrl $tempDir; Write-Host $tempDir; "$tempDir\install-update.ps1"; Remove-Item -Recurse -Force $tempDir
```