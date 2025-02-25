<#PSScriptInfo
.VERSION 8.8.1.1983
.GUID a51126ac-2c0b-4e0b-bb22-8070eb36da6d
.AUTHOR gmpatel (GP)
.DESCRIPTION PowerShell function to clean NuGet packages to allow fetch latest from the source...
.COMPANYNAME Archistar Pty Ltd
.COPYRIGHT Archistar Pty Ltd
.TAGS 
.LICENSEURI 
.PROJECTURI 
.ICONURI 
.EXTERNALMODULEDEPENDENCIES 
.REQUIREDSCRIPTS 
.EXTERNALSCRIPTDEPENDENCIES 
.RELEASENOTES
.PRIVATEDATA
#>
function ArchiNuGetClean {
    param (
        [string]$Path = (Get-Item .).FullName,
        [string[]]$PackagesToDelete = @("archistar", "archisharp"), # Default list of packages
        [switch]$ReBuild,
        [switch]$DryRun
    )

    $UserFolder
    $NuGetRootFolder
    $NuGetFolder

    if ($HOME) {
        $UserFolder = $HOME
    } elseif ($env:USERPROFILE) {
        $UserFolder = $env:USERPROFILE
    }

    if ($UserFolder) {
        $NuGetRootFolder = Join-Path -Path $UserFolder -ChildPath ".nuget"
        $NuGetFolder = Join-Path -Path $NuGetRootFolder -ChildPath "packages"
    }

    $PathExists = ($Path) -and (Test-Path -Path $Path)
    $UserFolderExists = ($UserFolder) -and (Test-Path -Path $UserFolder)
    $NuGetRootFolderExists = ($NuGetRootFolder) -and (Test-Path -Path $NuGetRootFolder)
    $NuGetFolderExists = ($NuGetFolder) -and (Test-Path -Path $NuGetFolder)

    # Ensure the provided path exists
    Write-Host $("=" * 80) -ForegroundColor Blue;
    Write-Host "Work  Path (Archi-NuGet-Clean) > " -f Blue -nonewline; Write-Host "$Path" -f White -nonewline; Write-Host " " -nonewline; Write-Host @({"<not found>"}, {"<found>"})[$PathExists] -f Green
    Write-Host "User  Path (Archi-NuGet-Clean) > " -f Blue -nonewline; Write-Host "$UserFolder" -f White -nonewline; Write-Host " " -nonewline; Write-Host @({"<not found>"}, {"<found>"})[$UserFolderExists] -f Green
    Write-Host "NuGet Path (Archi-NuGet-Clean) > " -f Blue -nonewline; Write-Host "$NuGetRootFolder" -f White -nonewline; Write-Host " " -nonewline; Write-Host @({"<not found>"}, {"<found>"})[$NuGetRootFolderExists] -f Green
    Write-Host "Pkgs  Path (Archi-NuGet-Clean) > " -f Blue -nonewline; Write-Host "$NuGetFolder" -f White -nonewline; Write-Host " " -nonewline; Write-Host @({"<not found>"}, {"<found>"})[$NuGetFolderExists] -f Green
    Write-Host $("-" * 80) -ForegroundColor Blue;

    if ($PathExists) {
        # Find all folders containing .csproj files
        $foldersWithCsproj = Get-ChildItem -Path $Path -Recurse -Filter "*.csproj" |
            ForEach-Object { $_.Directory.FullName } |
            Select-Object -Unique
        
        $foldersWithCsprojCount = $foldersWithCsproj.Count

        # $foldersWithCsproj

        if ($foldersWithCsprojCount -eq 0) {
            Write-Host "0 {.csproj} files found..." -ForegroundColor DarkGreen
        }
        else {    
            Write-Host "Total $foldersWithCsprojCount {.csproj} files found..." -ForegroundColor DarkGreen
            # Loop through each folder and remove 'bin' and 'obj' directories
            foreach ($folder in $foldersWithCsproj) {
                $binPath = Join-Path -Path $folder -ChildPath "bin"
                $objPath = Join-Path -Path $folder -ChildPath "obj"
                
                $binLogPath = $binPath.Replace($Path, "")
                $objLogPath = $objPath.Replace($Path, "")   

                if (Test-Path -Path $binPath) {
                    if ($DryRun) {
                        Write-Host "Build-Dir: ..$binLogPath" -f White -nonewline; Write-Host " (dry/would-delete)" -f Red
                    }
                    else {
                        Remove-Item -Path $binPath -Recurse -Force -ErrorAction SilentlyContinue
                        Write-Host "Build-Dir: ..$binLogPath" -f Yellow -nonewline; Write-Host " (deleted...)" -f Green
                    }
                }
                else {
                    Write-Host "Build-Dir: ..$binLogPath" -f Yellow -nonewline; Write-Host " (not found!)" -f Red
                }

                if (Test-Path -Path $objPath) {
                    if ($DryRun) {
                        Write-Host "Build-Dir: ..$objLogPath" -f White -nonewline; Write-Host " (dry/would-delete)" -f Red
                    }
                    else {
                        Remove-Item -Path $objPath -Recurse -Force -ErrorAction SilentlyContinue
                        Write-Host "Build-Dir: ..$objLogPath" -f Yellow -nonewline; Write-Host " (deleted...)" -f Green
                    }
                }
                else {
                    Write-Host "Build-Dir: ..$objLogPath" -f Yellow -nonewline; Write-Host " (not found!)" -f Red
                }
            }
        }

        Write-Host $("-" * 80) -ForegroundColor Blue;
    }

    if ($NuGetFolderExists) {
        # Iterate through the specified packages
        foreach ($package in $PackagesToDelete) {
            $filter = "$package*"
            
            $foldersWithPackage = Get-ChildItem -Path $NuGetFolder -Filter $filter -Directory -ErrorAction Ignore # Get-ChildItem -Directory -Path $NuGetFolder -Filter $filter |
                ForEach-Object { $_.Directory.FullName } |
                Select-Object -Unique

            $foldersWithPackageCount = $foldersWithPackage.Count

            Write-Host "Checking > $filter" -f Green -nonewline; Write-Host " ($foldersWithPackageCount packages found)" -f Blue
            
            foreach ($folder in $foldersWithPackage) {
                $folderName = Split-Path -Path $folder -Leaf
                $folderPath = Join-Path -Path $NuGetFolder -ChildPath $folderName
                #$folderPath = Join-Path -Path $NuGetFolder -ChildPath $folder
                $folderLogPath = $folderPath.Replace($UserFolder, "")

                if ($DryRun) {
                    Write-Host "Package-Dir: ..$folderLogPath" -f White -nonewline; Write-Host " (dry/would-delete)" -f Red
                }
                else {
                    Remove-Item -Path $folderPath -Recurse -Force -ErrorAction SilentlyContinue
                    Write-Host "Package-Dir: ..$folderLogPath" -f Yellow -nonewline; Write-Host " (deleted...)" -f Green
                }
            }

            Write-Host $("-" * 80) -ForegroundColor Blue;
        }

        Write-Host "Cleaning > NuGet's HTTP Cache..." -ForegroundColor Green
        dotnet nuget locals http-cache --clear

        Write-Host $("-" * 80) -ForegroundColor Blue;
    }    

    if ($PathExists -and $ReBuild) {
        $solutionFiles = Get-ChildItem -Path $Path -Recurse -Filter "*.sln" |
            ForEach-Object { if ($_.FullName -notmatch "templates") { $_.FullName } } |	#ForEach-Object { $_.FullName } |
            Select-Object -Unique
		
        $solutionFilesCount = $solutionFiles.Count

        Write-Host "Checking > *.sln" -f Green -nonewline; Write-Host " ($solutionFilesCount solution found...)" -f Blue
		
        if ($solutionFilesCount -gt 0) {
			foreach ($solutionFile in $solutionFiles) {
				Write-Host $solutionFile
			}
			Write-Host $("-" * 80) -ForegroundColor Blue;

            foreach ($solutionFile in $solutionFiles) {
                $buildThis = 89
                $solutionFileRelativePath =  $solutionFile.Replace($Path, "")
                $solutionFileRelativePath = ".$solutionFileRelativePath"
                                
                if ($solutionFilesCount -gt 1) {
                    Write-Host "Do you want to build this solution? > " -f Yellow -nonewline; Write-Host "$solutionFileRelativePath " -f Blue -nonewline; Write-Host "(y/n) : " -f Green -nonewline;
                    # $buildThis = Read-Host "(y/n)"
                    $buildThis = $Host.UI.RawUI.ReadKey('IncludeKeyDown').VirtualKeyCode;
                    Write-Host ""
                }

                if ($buildThis -eq 89 -or $buildThis -eq 13 -or $buildThis -eq 32) {
                    if ($DryRun) {
                        Write-Host "Solution: $solutionFileRelativePath" -f White -nonewline; Write-Host " (dry/would-rebuild-solution)" -f Yellow
                    }
                    else {
                        Write-Host "Solution: $solutionFileRelativePath" -f Yellow -nonewline; Write-Host " (building...)" -f Green
                        dotnet build $solutionFile -nowarn:NU1903,NU1904,NU1902,NU1701,NU1603,CS0219,NETSDK1194,CS0618,ASP0019,CS8618,NETSDK1138,CS8602,CS8604,CS8601,CA1711,CA2201,CA1852,xUnit1026,CA1822
                    }
                }
                
                Write-Host $("-" * 80) -ForegroundColor Blue;
            }
        }        
    }

    Write-Host "Done..." -ForegroundColor Green
    Write-Host $("=" * 80) -ForegroundColor Blue;
}