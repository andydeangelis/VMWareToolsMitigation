# VMWareToolsMitigation

# Description

This is a simple PowerShell GUI script that allows you to run reports against your vcenter server to determine th VMWare Tools version in all Windows VMs. It also allows you to select specific VMs to remotely apply mitigation for https://www.vmware.com/security/advisories/VMSA-2020-0002.html.

# Usage - Reporting

1. Reporting is simple. On the Step 1 tab, enter your vcenter server and credentials. Once authenticated, click Next.
2. On the Step 2 tab, click the "Get VM Tools Versions" radio button and the click the big green "Run Report" button.

# Usage - Modify ACLs

1. On the Step 1 tab, enter your vcenter server and credentials. Once authenticated, click Next.
2. Select you datacenter and VM folder from the dropdown lists.
3. In the left hand pane, select the VMs you want to apply mitigation to and click the "Add Virtual Machines" button in the center. NOTE: You can add VMs from multiple folders.
4. Click the "Modify ACLs" radio button.
5. Click the "Set Update Credential" button. Enter a local username and password that will be used to log into the selected devices. NOTE: If UAC is enabled in your environment, you must use the local (.\Administrator) account. If UAC is not enabled, any administrator account (i.e. Domain Admin) can be used.
6. Click the big green "Modify ACLs" button.

# Reporting

Both functions write their results to log files that are then compressed when the tool has completed. The location of the log files will be in a "Documents\vmware_tools_mitigation" folder. Zip files are named according to function and date/time they were created (i.e. VMToolsReport_01292020_10_05_29.zip or ModifyACLs_01282020_16_31_02.zip).

# Notes and Requirements

All code and project files are created in Sapien PowerShell Studio 2018, so you will need that to review the code for the controls themselves, etc. The scripts have been compiled into an executable (VMToolsUpdateMitigation.exe) that can be run from any machine that access to vCenter.

PowerShell 5.1 and the latest version of PowerCLI are required (Install-Module VMWare.PowerCLI).
