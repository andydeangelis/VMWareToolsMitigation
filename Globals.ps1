#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------


#Sample function that provides the location of the script
function Get-ScriptDirectory
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

# Set the log directory.
[string]$docsDirectory = [Environment]::GetFolderPath('MyDocuments')
$logGUID = New-Guid
[string]$logParentDirectory = "$docsDirectory\vmware_tools_mitigation"
[string]$logDirectory = "$docsDirectory\vmware_tools_mitigation\$logGUID"

if (-not (Get-Item -Path $logGUID)) { New-Item -ItemType Directory -Path "$logParentDirectory" -Name $logGUID }

# Import all functions.

foreach ($item in (Get-ChildItem -Path "$ScriptDirectory\Functions\" | ?{ $_.Extension -eq ".ps1" }))
{
	. "$($item.FullName)"
}

if (-not (Get-ChildItem "$logParentDirectory\prereqsinstalled.log" -ErrorAction SilentlyContinue))
{
	Install-PreReqs | Out-File "$logParentDirectory\prereqsinstalled.log"
}

#Credential object for vCenter authentication.
if (Get-Item -Path "$($env:TEMP)\vcCreds.xml")
{
	$vcCredential = Import-Clixml -Path "$($env:TEMP)\vcCreds.xml"
}
else
{
	$vcCredential = $null
}

#vCenter connection object.
$vcenterConnection = $null

#vCenter Server Name
if (Get-Item -Path "$($env:TEMP)\vcServer.xml")
{
	$vcServer = Import-Clixml -Path "$($env:TEMP)\vcServer.xml"
}
else
{
	$vcServer = $null
}

#VM Folder array
$vmFolderArray = @()

#Windows Update Credential
$updateCred

# Selected ISO file
$vmToolsISO