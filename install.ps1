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

$UserFolder

if ($HOME) {
    $UserFolder = $HOME
} elseif ($env:USERPROFILE) {
    $UserFolder = $env:USERPROFILE
}

if ($IsWindows) # For Windows
{
    Write-Host "Running on Windows!"

    $UserModulePath = [System.Environment]::GetFolderPath('MyDocuments') + "\WindowsPowerShell\Modules"
    Write-Host "User's PowerShell Modules Path > $UserModulePath"

    Write-Host "Copying Modules > $UserModulePath"
    Copy-Item -Path "./pwsh/Modules/*" -Destination $UserModulePath -Recurse -Force
    
    Write-Host "Importing Module > ArchiNuGetClean"
    Import-Module ArchiNuGetClean -Force

    $VS2022ItemTemplatesPath = "$UserFolder\Documents\Visual Studio 2022\Templates\ItemTemplates"
    $VS2022ItemTemplatesPathExists = ($VS2022ItemTemplatesPath) -and (Test-Path -Path $VS2022ItemTemplatesPath)

    if ($VS2022ItemTemplatesPathExists) {
        Write-Host "Copying Item Templates VS2022 > $VS2022ItemTemplatesPath"
        Copy-Item -Path "./vs-templates/item-templates/*.zip" -Destination $VS2022ItemTemplatesPath -Recurse -Force     
    }
} 
elseif ($IsLinux -or $IsMacOS) # For Linux or macOS    
{
    Write-Host "Running on MacOS/Linux!"

    $UserModulePath = [System.Environment]::GetFolderPath('UserProfile') + "/.local/share/powershell/Modules"
    Write-Host "User's PowerShell Modules Path > $UserModulePath"

    Write-Host "Copying Modules > $UserModulePath"
    Copy-Item -Path "./pwsh/Modules/*" -Destination $UserModulePath -Recurse -Force
    
    Write-Host "Importing Module > ArchiNuGetClean"
    Import-Module ArchiNuGetClean -Force
}