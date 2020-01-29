<#
	.SYNOPSIS
		A brief description of the Invoke-WSUSMicrosoftUpdate_ps1 file.
	
	.DESCRIPTION
		A description of the file.
	
	.PARAMETER LogDirectory
		A description of the LogDirectory parameter.
	
	.PARAMETER GuestCredential
		A description of the GuestCredential parameter.
	
	.PARAMETER VMName
		A description of the VMName parameter.
	
	.PARAMETER ScriptDirectory
		A description of the ScriptDirectory parameter.
	
	.NOTES
		===========================================================================
		Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.150
		Created on:   	1/8/2020 2:23 PM
		Created by:   	dalthakar
		Organization:
		Filename:     	WSUSMicrosoftUpdate.ps1
		===========================================================================
#>

function Get-MSAvailableUpdates
{
	param
	(
		[Parameter(Mandatory = $true)]
		[PSCredential]$GuestCredential,
		[Parameter(Mandatory = $true)]
		[string]$VMName,
		[Parameter(Mandatory = $true)]
		[string]$ScriptDirectory,
		[Parameter(Mandatory = $true)]
		[string]$LogDirectory
	)
	
	Invoke-VMScript -VM $VMName -ScriptText {
		
		if (-not (Get-Item -Path "C:\WinUpdate"))
		{
			New-Item -ItemType Directory -Path "C:\" -Name "WinUpdate"
		}
		
		Remove-Item -Path "C:\WinUpdate\*" -Recurse -Force
	} -GuestCredential $GuestCredential
	
	Copy-VMGuestFile -Source "$($ScriptDirectory)\packages\WindowsUpdateSchedulerPowerShell.zip" -Destination "C:\WinUpdate" -VM $VMName -LocalToGuest -GuestCredential $GuestCredential -Force
	
	Invoke-VMScript -VM $VMName -ScriptText { Expand-Archive -Path "C:\WinUpdate\WindowsUpdateSchedulerPowerShell.zip" -DestinationPath "C:\WinUpdate\" -Force } -GuestCredential $GuestCredential
	Invoke-VMScript -VM $VMName -ScriptText {
		Set-Location "C:\WinUpdate\WindowsUpdateSchedulerPowerShell"
		$computer = $ENV:COMPUTERNAME
		$schedDate = Get-Date -Format "MM-dd-yyyy_hh_mm"
		$taskName = "GetAvailableUpdates-$computer-$schedDate"
		schtasks.exe /Create /XML ".\xml\GetAvailUpdates.xml" /tn $taskName
		schtasks.exe /Run /tn $taskName
		while ((GWMI -Namespace Root/Microsoft/Windows/TaskScheduler -class MSFT_ScheduledTask | ?{ $_.TaskName -eq $taskName }).State -eq 4)
		{
			Write-Host "Waiting for task to finish..."
			Start-Sleep -Seconds 5
		}
		schtasks.exe /Delete /tn $taskName /F
	} -GuestCredential $GuestCredential
	
	Copy-VMGuestFile -Source "C:\WinUpdate\WindowsUpdateSchedulerPowerShell\WSUS_Reports" -Destination "$($LogDirectory)" -VM $VMName -GuestToLocal -GuestCredential $GuestCredential -Force
	
	Invoke-VMScript -VM $VMName -ScriptText { Remove-Item -Path "C:\WinUpdate\*" -Recurse -Force } -GuestCredential $GuestCredential
}

function Get-MSUpdateHistory
{
	param
	(
		[Parameter(Mandatory = $true)]
		[PSCredential]$GuestCredential,
		[Parameter(Mandatory = $true)]
		[string]$VMName,
		[Parameter(Mandatory = $true)]
		[string]$ScriptDirectory,
		[Parameter(Mandatory = $true)]
		[string]$LogDirectory
	)
	
	Invoke-VMScript -VM $VMName -ScriptText {
		
		if (-not (Get-Item -Path "C:\WinUpdate"))
		{
			New-Item -ItemType Directory -Path "C:\" -Name "WinUpdate"
		}
		
		Remove-Item -Path "C:\WinUpdate\*" -Recurse -Force
	} -GuestCredential $GuestCredential
	
	Copy-VMGuestFile -Source "$($ScriptDirectory)\packages\WindowsUpdateSchedulerPowerShell.zip" -Destination "C:\WinUpdate" -VM $VMName -LocalToGuest -GuestCredential $GuestCredential -Force
	
	Invoke-VMScript -VM $VMName -ScriptText { Expand-Archive -Path "C:\WinUpdate\WindowsUpdateSchedulerPowerShell.zip" -DestinationPath "C:\WinUpdate\" -Force } -GuestCredential $GuestCredential
	Invoke-VMScript -VM $VMName -ScriptText {
		Set-Location "C:\WinUpdate\WindowsUpdateSchedulerPowerShell"
		$computer = $ENV:COMPUTERNAME
		$schedDate = Get-Date -Format "MM-dd-yyyy_hh_mm"
		$taskName = "GetAvailableUpdates-$computer-$schedDate"
		schtasks.exe /Create /XML ".\xml\GetUpdateHistory.xml" /tn $taskName
		schtasks.exe /Run /tn $taskName
		while ((GWMI -Namespace Root/Microsoft/Windows/TaskScheduler -class MSFT_ScheduledTask | ?{ $_.TaskName -eq $taskName }).State -eq 4)
		{
			Write-Host "Waiting for task to finish..."
			Start-Sleep -Seconds 5
		}
		schtasks.exe /Delete /tn $taskName /F
	} -GuestCredential $GuestCredential
	
	Copy-VMGuestFile -Source "C:\WinUpdate\WindowsUpdateSchedulerPowerShell\WSUS_Reports" -Destination "$($LogDirectory)" -VM $VMName -GuestToLocal -GuestCredential $GuestCredential -Force -ToolsWaitSecs 30
	Invoke-VMScript -VM $VMName -ScriptText { Remove-Item -Path "C:\WinUpdate\WindowsUpdateSchedulerPowerShell\WSUS_Reports" -Recurse -Force } -GuestCredential $GuestCredential
}

function Install-MSUpdates
{
	param
	(
		[Parameter(Mandatory = $true)]
		[PSCredential]$GuestCredential,
		[Parameter(Mandatory = $true)]
		[string]$VMName,
		[Parameter(Mandatory = $true)]
		[string]$ScriptDirectory,
		[Parameter(Mandatory = $true)]
		[string]$LogDirectory
	)
	
	Invoke-VMScript -VM $VMName -ScriptText {
		
		if (-not (Get-Item -Path "C:\WinUpdate"))
		{
			New-Item -ItemType Directory -Path "C:\" -Name "WinUpdate"
		}
		
		Remove-Item -Path "C:\WinUpdate\*" -Recurse -Force
	} -GuestCredential $GuestCredential
	
	Copy-VMGuestFile -Source "$($ScriptDirectory)\packages\WindowsUpdateSchedulerPowerShell.zip" -Destination "C:\WinUpdate" -VM $VMName -LocalToGuest -GuestCredential $GuestCredential -Force
	
	Invoke-VMScript -VM $VMName -ScriptText { Expand-Archive -Path "C:\WinUpdate\WindowsUpdateSchedulerPowerShell.zip" -DestinationPath "C:\WinUpdate\" -Force } -GuestCredential $GuestCredential
	Invoke-VMScript -VM $VMName -ScriptText {
		Set-Location "C:\WinUpdate\WindowsUpdateSchedulerPowerShell"
		$computer = $ENV:COMPUTERNAME
		$schedDate = Get-Date -Format "MM-dd-yyyy_hh_mm"
		$taskName = "GetAvailableUpdates-$computer-$schedDate"
		schtasks.exe /Create /XML ".\xml\InstallUpdates.xml" /tn $taskName
		schtasks.exe /Run /tn $taskName
		while ((GWMI -Namespace Root/Microsoft/Windows/TaskScheduler -class MSFT_ScheduledTask | ?{ $_.TaskName -eq $taskName }).State -eq 4)
		{
			Write-Host "Waiting for task to finish..."
			Start-Sleep -Seconds 5
		}
		schtasks.exe /Delete /tn $taskName /F
	} -GuestCredential $GuestCredential
	
	Copy-VMGuestFile -Source "C:\WinUpdate\WindowsUpdateSchedulerPowerShell\WSUS_Reports" -Destination "$($LogDirectory)" -VM $VMName -GuestToLocal -GuestCredential $GuestCredential -Force
	Invoke-VMScript -VM $VMName -ScriptText { Remove-Item -Path "C:\WinUpdate\*" -Recurse -Force } -GuestCredential $GuestCredential
}