# Check if the OS is Windows
#if ($IsWindows) 
#{
#    # Check if the script is running with admin privileges
#    $IsAdmin = [Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())
#    $AdminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
#
#    # If not running as admin, restart the script as admin
#    if (-not $IsAdmin.IsInRole($AdminRole)) {
#        # Relaunch the script as Administrator
#        $arg = "-NoProfile -ExecutionPolicy Bypass -File `"$( $MyInvocation.MyCommand.Path )`""
#        Start-Process powershell.exe -ArgumentList $arg -Verb RunAs
#        exit
#    }
#    # Put your actual script commands below this line
#    Write-Host "Running as Administrator!"
#
#    # Set current user execution policy unrestricted
#    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
#}

Write-Host "Install started!"

$UserFolder

if ($HOME) 
{
    $UserFolder = $HOME
} 
elseif ($env:USERPROFILE) 
{
    $UserFolder = $env:USERPROFILE
}

Write-Host "User's Home Path > $UserFolder"

#$ProfileExists = Test-Path $PROFILE
#
#if (ProfileExists -eq False)
#{
#    New-Item -ItemType File -Path $PROFILE -Force
#}
#
#Set-Alias mycmd Get-Process 

if ($IsLinux -or $IsMacOS) # For Linux or macOS    
{
    Write-Host "Running on MacOS/Linux!"

    $UserModulePath = [System.Environment]::GetFolderPath('UserProfile') + "/.local/share/powershell/Modules"
    Write-Host "User's PowerShell Modules Path > $UserModulePath"

    Write-Host "Copying Modules > $UserModulePath"
    Copy-Item -Path "./pwsh/Modules/" -Destination $UserModulePath -Recurse -Force
    
    Write-Host "Importing Module > ArchiNuGetClean"
    Import-Module ArchiNuGetClean -Force
}
else # elseif ($IsWindows) # For Windows
{
    Write-Host "Running on Windows!"

    $UserDocumentsPath = [System.Environment]::GetFolderPath('MyDocuments')
    Write-Host "User's Documents Path > $UserDocumentsPath"

    $UserModulePath = $UserDocumentsPath + "\WindowsPowerShell\Modules"
    Write-Host "User's PowerShell Modules Path > $UserModulePath"

    Write-Host "Copying Modules > $UserModulePath"
    Copy-Item -Path "./pwsh/Modules/*" -Destination $UserModulePath -Recurse -Force
    
    Write-Host "Importing Module > ArchiNuGetClean"
    Import-Module ArchiNuGetClean -Force

    $VS2022ItemTemplatesPath = "$UserDocumentsPath\Visual Studio 2022\Templates\ItemTemplates\C#"
    Write-Host "Checking Path > $VS2022ItemTemplatesPath"
    $VS2022ItemTemplatesPathExists = ($VS2022ItemTemplatesPath) -and (Test-Path -Path $VS2022ItemTemplatesPath)
    
    if ($VS2022ItemTemplatesPathExists) {
        Write-Host "Copying Item Templates VS2022 (Found) > $VS2022ItemTemplatesPath"
        Copy-Item -Path "./vs-templates/item-templates/*.zip" -Destination $VS2022ItemTemplatesPath -Recurse -Force     
        Write-Host "Copying Item Templates VS2022 > $VS2022ItemTemplatesPath"
    }

    $VS2019ItemTemplatesPath = "$UserDocumentsPath\Visual Studio 2019\Templates\ItemTemplates\Visual C#"
    Write-Host "Checking Path > $VS2019ItemTemplatesPath"
    $VS2019ItemTemplatesPathExists = ($VS2019ItemTemplatesPath) -and (Test-Path -Path $VS2019ItemTemplatesPath)
    
    if ($VS2019ItemTemplatesPathExists) {
        Write-Host "Copying Item Templates VS2019 (Found) > $VS2019ItemTemplatesPath"
        Copy-Item -Path "./vs-templates/item-templates/*.zip" -Destination $VS2019ItemTemplatesPath -Recurse -Force     
        Write-Host "Copying Item Templates VS2019 > $VS2019ItemTemplatesPath"
    }

    $VS2017ItemTemplatesPath = "$UserDocumentsPath\Documents\Visual Studio 2017\Templates\ItemTemplates\Visual C#"
    Write-Host "Checking Path > $VS2017ItemTemplatesPath"
    $VS2017ItemTemplatesPathExists = ($VS2017ItemTemplatesPath) -and (Test-Path -Path $VS2017ItemTemplatesPath)
    
    if ($VS2017ItemTemplatesPathExists) {
        Write-Host "Copying Item Templates VS2017 (Found) > $VS2017ItemTemplatesPath"
        Copy-Item -Path "./vs-templates/item-templates/*.zip" -Destination $VS2017ItemTemplatesPath -Recurse -Force     
        Write-Host "Copying Item Templates VS2017 > $VS2017ItemTemplatesPath"
    }
}