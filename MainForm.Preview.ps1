#----------------------------------------------
# Generated Form Function
#----------------------------------------------
function Show-MainForm_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Define SAPIEN Types
	#----------------------------------------------
	try{
		[ProgressBarOverlay] | Out-Null
	}
	catch
	{
		Add-Type -ReferencedAssemblies ('System.Windows.Forms', 'System.Drawing') -TypeDefinition  @" 
		using System;
		using System.Windows.Forms;
		using System.Drawing;
        namespace SAPIENTypes
        {
		    public class ProgressBarOverlay : System.Windows.Forms.ProgressBar
	        {
                public ProgressBarOverlay() : base() { SetStyle(ControlStyles.OptimizedDoubleBuffer | ControlStyles.AllPaintingInWmPaint, true); }
	            protected override void WndProc(ref Message m)
	            { 
	                base.WndProc(ref m);
	                if (m.Msg == 0x000F)// WM_PAINT
	                {
	                    if (Style != System.Windows.Forms.ProgressBarStyle.Marquee || !string.IsNullOrEmpty(this.Text))
                        {
                            using (Graphics g = this.CreateGraphics())
                            {
                                using (StringFormat stringFormat = new StringFormat(StringFormatFlags.NoWrap))
                                {
                                    stringFormat.Alignment = StringAlignment.Center;
                                    stringFormat.LineAlignment = StringAlignment.Center;
                                    if (!string.IsNullOrEmpty(this.Text))
                                        g.DrawString(this.Text, this.Font, Brushes.Black, this.ClientRectangle, stringFormat);
                                    else
                                    {
                                        int percent = (int)(((double)Value / (double)Maximum) * 100);
                                        g.DrawString(percent.ToString() + "%", this.Font, Brushes.Black, this.ClientRectangle, stringFormat);
                                    }
                                }
                            }
                        }
	                }
	            }
              
                public string TextOverlay
                {
                    get
                    {
                        return base.Text;
                    }
                    set
                    {
                        base.Text = value;
                        Invalidate();
                    }
                }
	        }
        }
"@ -IgnoreWarnings | Out-Null
	}
	#endregion Define SAPIEN Types

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formVMToolsMitigation = New-Object 'System.Windows.Forms.Form'
	$buttonCancel = New-Object 'System.Windows.Forms.Button'
	$buttonBack = New-Object 'System.Windows.Forms.Button'
	$buttonFinish = New-Object 'System.Windows.Forms.Button'
	$tabcontrolWizard = New-Object 'System.Windows.Forms.TabControl'
	$tabpageStep1 = New-Object 'System.Windows.Forms.TabPage'
	$labelStep1 = New-Object 'System.Windows.Forms.Label'
	$vcenterTextbox = New-Object 'System.Windows.Forms.TextBox'
	$labelVCenterFQDNOrIPAddre = New-Object 'System.Windows.Forms.Label'
	$panel1 = New-Object 'System.Windows.Forms.Panel'
	$labelOKStep1 = New-Object 'System.Windows.Forms.Label'
	$labelConnectionStatusNotC = New-Object 'System.Windows.Forms.Label'
	$labelUsernameNotConnected = New-Object 'System.Windows.Forms.Label'
	$labelVCenterServerNotConn = New-Object 'System.Windows.Forms.Label'
	$labelSetVSphereCredential = New-Object 'System.Windows.Forms.Label'
	$buttonEnterCredentials = New-Object 'System.Windows.Forms.Button'
	$pictureboxLoading = New-Object 'System.Windows.Forms.PictureBox'
	$tabpageStep2 = New-Object 'System.Windows.Forms.TabPage'
	$progressbaroverlayRun = New-Object 'SAPIENTypes.ProgressBarOverlay'
	$radiobuttonRunFullReport = New-Object 'System.Windows.Forms.RadioButton'
	$radiobuttonModifyACLs = New-Object 'System.Windows.Forms.RadioButton'
	$buttonSetUpdateCredential = New-Object 'System.Windows.Forms.Button'
	$buttonRun = New-Object 'System.Windows.Forms.Button'
	$listboxVMUpdateList = New-Object 'System.Windows.Forms.ListBox'
	$listboxVMList = New-Object 'System.Windows.Forms.ListBox'
	$checkboxSelectAll = New-Object 'System.Windows.Forms.CheckBox'
	$comboboxDatacenter = New-Object 'System.Windows.Forms.ComboBox'
	$labelDatacenter = New-Object 'System.Windows.Forms.Label'
	$labelVMFolder = New-Object 'System.Windows.Forms.Label'
	$comboboxVMFolders = New-Object 'System.Windows.Forms.ComboBox'
	$buttonDeleteVMFromQueue = New-Object 'System.Windows.Forms.Button'
	$buttonAddVirtualMachines = New-Object 'System.Windows.Forms.Button'
	$labelStep2 = New-Object 'System.Windows.Forms.Label'
	$buttonNext = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formVMToolsMitigation.SuspendLayout()
	$tabcontrolWizard.SuspendLayout()
	$tabpageStep1.SuspendLayout()
	$panel1.SuspendLayout()
	$tabpageStep2.SuspendLayout()
	#
	# formVMToolsMitigation
	#
	$formVMToolsMitigation.Controls.Add($buttonCancel)
	$formVMToolsMitigation.Controls.Add($buttonBack)
	$formVMToolsMitigation.Controls.Add($buttonFinish)
	$formVMToolsMitigation.Controls.Add($tabcontrolWizard)
	$formVMToolsMitigation.Controls.Add($buttonNext)
	$formVMToolsMitigation.AcceptButton = $buttonFinish
	$formVMToolsMitigation.AutoScaleDimensions = '6, 13'
	$formVMToolsMitigation.AutoScaleMode = 'Font'
	$formVMToolsMitigation.CancelButton = $buttonCancel
	$formVMToolsMitigation.ClientSize = '689, 455'
	$formVMToolsMitigation.FormBorderStyle = 'FixedDialog'
	$formVMToolsMitigation.MaximizeBox = $False
	$formVMToolsMitigation.Name = 'formVMToolsMitigation'
	$formVMToolsMitigation.StartPosition = 'CenterScreen'
	$formVMToolsMitigation.Text = 'VM Tools Mitigation'
	$formVMToolsMitigation.add_Load($formVMToolsMitigation_Load)
	#
	# buttonCancel
	#
	$buttonCancel.Anchor = 'Bottom, Right'
	$buttonCancel.DialogResult = 'Cancel'
	$buttonCancel.Location = '521, 420'
	$buttonCancel.Name = 'buttonCancel'
	$buttonCancel.Size = '75, 23'
	$buttonCancel.TabIndex = 4
	$buttonCancel.Text = '&Cancel'
	$buttonCancel.UseCompatibleTextRendering = $True
	$buttonCancel.UseVisualStyleBackColor = $True
	#
	# buttonBack
	#
	$buttonBack.Anchor = 'Bottom, Left'
	$buttonBack.Location = '13, 420'
	$buttonBack.Name = 'buttonBack'
	$buttonBack.Size = '75, 23'
	$buttonBack.TabIndex = 1
	$buttonBack.Text = '< &Back'
	$buttonBack.UseCompatibleTextRendering = $True
	$buttonBack.UseVisualStyleBackColor = $True
	$buttonBack.add_Click($buttonBack_Click)
	#
	# buttonFinish
	#
	$buttonFinish.Anchor = 'Bottom, Right'
	$buttonFinish.DialogResult = 'OK'
	$buttonFinish.Location = '602, 420'
	$buttonFinish.Name = 'buttonFinish'
	$buttonFinish.Size = '75, 23'
	$buttonFinish.TabIndex = 3
	$buttonFinish.Text = '&Finish'
	$buttonFinish.UseCompatibleTextRendering = $True
	$buttonFinish.UseVisualStyleBackColor = $True
	$buttonFinish.add_Click($buttonFinish_Click)
	#
	# tabcontrolWizard
	#
	$tabcontrolWizard.Controls.Add($tabpageStep1)
	$tabcontrolWizard.Controls.Add($tabpageStep2)
	$tabcontrolWizard.Anchor = 'Top, Bottom, Left, Right'
	$tabcontrolWizard.Location = '13, 12'
	$tabcontrolWizard.Name = 'tabcontrolWizard'
	$tabcontrolWizard.SelectedIndex = 0
	$tabcontrolWizard.Size = '664, 402'
	$tabcontrolWizard.TabIndex = 0
	$tabcontrolWizard.add_Selecting($tabcontrolWizard_Selecting)
	$tabcontrolWizard.add_Deselecting($tabcontrolWizard_Deselecting)
	#
	# tabpageStep1
	#
	$tabpageStep1.Controls.Add($labelStep1)
	$tabpageStep1.Controls.Add($vcenterTextbox)
	$tabpageStep1.Controls.Add($labelVCenterFQDNOrIPAddre)
	$tabpageStep1.Controls.Add($panel1)
	$tabpageStep1.Controls.Add($pictureboxLoading)
	$tabpageStep1.Location = '4, 22'
	$tabpageStep1.Name = 'tabpageStep1'
	$tabpageStep1.Padding = '3, 3, 3, 3'
	$tabpageStep1.Size = '656, 376'
	$tabpageStep1.TabIndex = 0
	$tabpageStep1.Text = 'Step 1 - vCenter Login'
	$tabpageStep1.UseVisualStyleBackColor = $True
	#
	# labelStep1
	#
	$labelStep1.AutoSize = $True
	$labelStep1.Font = 'Microsoft Sans Serif, 12pt, style=Bold'
	$labelStep1.Location = '6, 9'
	$labelStep1.Name = 'labelStep1'
	$labelStep1.Size = '470, 24'
	$labelStep1.TabIndex = 8
	$labelStep1.Text = 'Step 1: Enter your vCenter server and credentials to proceed.'
	$labelStep1.UseCompatibleTextRendering = $True
	#
	# vcenterTextbox
	#
	$vcenterTextbox.AutoCompleteMode = 'Append'
	$vcenterTextbox.AutoCompleteSource = 'CustomSource'
	$vcenterTextbox.Location = '166, 49'
	$vcenterTextbox.Name = 'vcenterTextbox'
	$vcenterTextbox.Size = '161, 20'
	$vcenterTextbox.TabIndex = 6
	$vcenterTextbox.add_TextChanged($vcenterTextbox_TextChanged)
	#
	# labelVCenterFQDNOrIPAddre
	#
	$labelVCenterFQDNOrIPAddre.AutoSize = $True
	$labelVCenterFQDNOrIPAddre.Location = '6, 52'
	$labelVCenterFQDNOrIPAddre.Name = 'labelVCenterFQDNOrIPAddre'
	$labelVCenterFQDNOrIPAddre.Size = '153, 17'
	$labelVCenterFQDNOrIPAddre.TabIndex = 5
	$labelVCenterFQDNOrIPAddre.Text = 'vCenter FQDN or IP Address:'
	$labelVCenterFQDNOrIPAddre.UseCompatibleTextRendering = $True
	#
	# panel1
	#
	$panel1.Controls.Add($labelOKStep1)
	$panel1.Controls.Add($labelConnectionStatusNotC)
	$panel1.Controls.Add($labelUsernameNotConnected)
	$panel1.Controls.Add($labelVCenterServerNotConn)
	$panel1.Controls.Add($labelSetVSphereCredential)
	$panel1.Controls.Add($buttonEnterCredentials)
	$panel1.Location = '6, 82'
	$panel1.Name = 'panel1'
	$panel1.Size = '321, 288'
	$panel1.TabIndex = 7
	#
	# labelOKStep1
	#
	$labelOKStep1.AutoSize = $True
	$labelOKStep1.Font = 'Comic Sans MS, 10.125pt, style=Bold'
	$labelOKStep1.ForeColor = 'Green'
	$labelOKStep1.Location = '197, 134'
	$labelOKStep1.Name = 'labelOKStep1'
	$labelOKStep1.Size = '28, 24'
	$labelOKStep1.TabIndex = 38
	$labelOKStep1.Text = 'OK!'
	$labelOKStep1.UseCompatibleTextRendering = $True
	$labelOKStep1.Visible = $False
	#
	# labelConnectionStatusNotC
	#
	$labelConnectionStatusNotC.AutoSize = $True
	$labelConnectionStatusNotC.Location = '13, 137'
	$labelConnectionStatusNotC.Name = 'labelConnectionStatusNotC'
	$labelConnectionStatusNotC.Size = '178, 17'
	$labelConnectionStatusNotC.TabIndex = 4
	$labelConnectionStatusNotC.Text = 'Connection Status: Not Connected'
	$labelConnectionStatusNotC.UseCompatibleTextRendering = $True
	#
	# labelUsernameNotConnected
	#
	$labelUsernameNotConnected.AutoSize = $True
	$labelUsernameNotConnected.Location = '13, 100'
	$labelUsernameNotConnected.Name = 'labelUsernameNotConnected'
	$labelUsernameNotConnected.Size = '138, 17'
	$labelUsernameNotConnected.TabIndex = 3
	$labelUsernameNotConnected.Text = 'Username: Not Connected'
	$labelUsernameNotConnected.UseCompatibleTextRendering = $True
	#
	# labelVCenterServerNotConn
	#
	$labelVCenterServerNotConn.AutoSize = $True
	$labelVCenterServerNotConn.Location = '13, 68'
	$labelVCenterServerNotConn.Name = 'labelVCenterServerNotConn'
	$labelVCenterServerNotConn.Size = '162, 17'
	$labelVCenterServerNotConn.TabIndex = 2
	$labelVCenterServerNotConn.Text = 'vCenter Server: Not Connected'
	$labelVCenterServerNotConn.UseCompatibleTextRendering = $True
	#
	# labelSetVSphereCredential
	#
	$labelSetVSphereCredential.AutoSize = $True
	$labelSetVSphereCredential.Dock = 'Fill'
	$labelSetVSphereCredential.Location = '0, 0'
	$labelSetVSphereCredential.Name = 'labelSetVSphereCredential'
	$labelSetVSphereCredential.Size = '127, 17'
	$labelSetVSphereCredential.TabIndex = 1
	$labelSetVSphereCredential.Text = 'Set vSphere Credentials'
	$labelSetVSphereCredential.UseCompatibleTextRendering = $True
	#
	# buttonEnterCredentials
	#
	$buttonEnterCredentials.Enabled = $False
	$buttonEnterCredentials.Location = '13, 168'
	$buttonEnterCredentials.Name = 'buttonEnterCredentials'
	$buttonEnterCredentials.Size = '114, 23'
	$buttonEnterCredentials.TabIndex = 0
	$buttonEnterCredentials.Text = 'Enter Credentials'
	$buttonEnterCredentials.UseCompatibleTextRendering = $True
	$buttonEnterCredentials.UseVisualStyleBackColor = $True
	$buttonEnterCredentials.add_Click($buttonEnterCredentials_Click)
	#
	# pictureboxLoading
	#
	$pictureboxLoading.Anchor = 'Bottom, Right'
	#region Binary Data
	$pictureboxLoading.Image = [System.Convert]::FromBase64String('
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
Cwg1RAAAOwAAAAAAAAAAAA==')
	#endregion
	$pictureboxLoading.Location = '595, 340'
	$pictureboxLoading.Name = 'pictureboxLoading'
	$pictureboxLoading.Size = '68, 68'
	$pictureboxLoading.TabIndex = 9
	$pictureboxLoading.TabStop = $False
	$pictureboxLoading.Visible = $False
	#
	# tabpageStep2
	#
	$tabpageStep2.Controls.Add($progressbaroverlayRun)
	$tabpageStep2.Controls.Add($radiobuttonRunFullReport)
	$tabpageStep2.Controls.Add($radiobuttonModifyACLs)
	$tabpageStep2.Controls.Add($buttonSetUpdateCredential)
	$tabpageStep2.Controls.Add($buttonRun)
	$tabpageStep2.Controls.Add($listboxVMUpdateList)
	$tabpageStep2.Controls.Add($listboxVMList)
	$tabpageStep2.Controls.Add($checkboxSelectAll)
	$tabpageStep2.Controls.Add($comboboxDatacenter)
	$tabpageStep2.Controls.Add($labelDatacenter)
	$tabpageStep2.Controls.Add($labelVMFolder)
	$tabpageStep2.Controls.Add($comboboxVMFolders)
	$tabpageStep2.Controls.Add($buttonDeleteVMFromQueue)
	$tabpageStep2.Controls.Add($buttonAddVirtualMachines)
	$tabpageStep2.Controls.Add($labelStep2)
	$tabpageStep2.Location = '4, 22'
	$tabpageStep2.Name = 'tabpageStep2'
	$tabpageStep2.Padding = '3, 3, 3, 3'
	$tabpageStep2.Size = '656, 376'
	$tabpageStep2.TabIndex = 1
	$tabpageStep2.Text = 'Step 2 - VM Selection'
	$tabpageStep2.UseVisualStyleBackColor = $True
	#
	# progressbaroverlayRun
	#
	$progressbaroverlayRun.Location = '534, 5'
	$progressbaroverlayRun.Name = 'progressbaroverlayRun'
	$progressbaroverlayRun.Size = '116, 23'
	$progressbaroverlayRun.Style = 'Continuous'
	$progressbaroverlayRun.TabIndex = 5
	#
	# radiobuttonRunFullReport
	#
	$radiobuttonRunFullReport.Location = '273, 46'
	$radiobuttonRunFullReport.Name = 'radiobuttonRunFullReport'
	$radiobuttonRunFullReport.Size = '255, 24'
	$radiobuttonRunFullReport.TabIndex = 37
	$radiobuttonRunFullReport.TabStop = $True
	$radiobuttonRunFullReport.Text = 'Run Full Report Against Selected Datacenter'
	$radiobuttonRunFullReport.UseCompatibleTextRendering = $True
	$radiobuttonRunFullReport.UseVisualStyleBackColor = $True
	$radiobuttonRunFullReport.add_CheckedChanged($radiobuttonRunFullReport_CheckedChanged)
	#
	# radiobuttonModifyACLs
	#
	$radiobuttonModifyACLs.Location = '273, 82'
	$radiobuttonModifyACLs.Name = 'radiobuttonModifyACLs'
	$radiobuttonModifyACLs.Size = '104, 24'
	$radiobuttonModifyACLs.TabIndex = 36
	$radiobuttonModifyACLs.TabStop = $True
	$radiobuttonModifyACLs.Text = 'Modify ACLs'
	$radiobuttonModifyACLs.UseCompatibleTextRendering = $True
	$radiobuttonModifyACLs.UseVisualStyleBackColor = $True
	$radiobuttonModifyACLs.add_CheckedChanged($radiobuttonModifyACLs_CheckedChanged)
	#
	# buttonSetUpdateCredential
	#
	$buttonSetUpdateCredential.Location = '534, 103'
	$buttonSetUpdateCredential.Name = 'buttonSetUpdateCredential'
	$buttonSetUpdateCredential.Size = '116, 32'
	$buttonSetUpdateCredential.TabIndex = 30
	$buttonSetUpdateCredential.Text = 'Set Update Credential'
	$buttonSetUpdateCredential.UseCompatibleTextRendering = $True
	$buttonSetUpdateCredential.UseVisualStyleBackColor = $True
	$buttonSetUpdateCredential.add_Click($buttonSetUpdateCredential_Click)
	#
	# buttonRun
	#
	$buttonRun.BackColor = 'Red'
	$buttonRun.Enabled = $False
	$buttonRun.ForeColor = 'ActiveCaptionText'
	$buttonRun.Location = '534, 34'
	$buttonRun.Name = 'buttonRun'
	$buttonRun.Size = '116, 53'
	$buttonRun.TabIndex = 29
	$buttonRun.Text = 'Run'
	$buttonRun.UseCompatibleTextRendering = $True
	$buttonRun.UseVisualStyleBackColor = $False
	$buttonRun.add_Click($buttonRun_Click)
	#
	# listboxVMUpdateList
	#
	$listboxVMUpdateList.FormattingEnabled = $True
	$listboxVMUpdateList.Location = '403, 150'
	$listboxVMUpdateList.Name = 'listboxVMUpdateList'
	$listboxVMUpdateList.Size = '247, 225'
	$listboxVMUpdateList.TabIndex = 28
	#
	# listboxVMList
	#
	$listboxVMList.FormattingEnabled = $True
	$listboxVMList.Location = '8, 149'
	$listboxVMList.Name = 'listboxVMList'
	$listboxVMList.SelectionMode = 'MultiExtended'
	$listboxVMList.Size = '244, 225'
	$listboxVMList.TabIndex = 27
	$listboxVMList.add_SelectedIndexChanged($listboxVMList_SelectedIndexChanged)
	#
	# checkboxSelectAll
	#
	$checkboxSelectAll.Enabled = $False
	$checkboxSelectAll.Location = '8, 119'
	$checkboxSelectAll.Name = 'checkboxSelectAll'
	$checkboxSelectAll.Size = '86, 26'
	$checkboxSelectAll.TabIndex = 26
	$checkboxSelectAll.Text = 'Select All'
	$checkboxSelectAll.UseCompatibleTextRendering = $True
	$checkboxSelectAll.UseVisualStyleBackColor = $True
	$checkboxSelectAll.add_CheckedChanged($checkboxSelectAll_CheckedChanged)
	#
	# comboboxDatacenter
	#
	$comboboxDatacenter.DropDownStyle = 'DropDownList'
	$comboboxDatacenter.FormattingEnabled = $True
	$comboboxDatacenter.Location = '73, 46'
	$comboboxDatacenter.Name = 'comboboxDatacenter'
	$comboboxDatacenter.Size = '179, 21'
	$comboboxDatacenter.TabIndex = 24
	$comboboxDatacenter.add_SelectedIndexChanged($comboboxDatacenter_SelectedIndexChanged)
	#
	# labelDatacenter
	#
	$labelDatacenter.AutoSize = $True
	$labelDatacenter.Location = '8, 46'
	$labelDatacenter.Margin = '1, 0, 1, 0'
	$labelDatacenter.Name = 'labelDatacenter'
	$labelDatacenter.Size = '63, 17'
	$labelDatacenter.TabIndex = 23
	$labelDatacenter.Text = 'Datacenter:'
	$labelDatacenter.UseCompatibleTextRendering = $True
	#
	# labelVMFolder
	#
	$labelVMFolder.AutoSize = $True
	$labelVMFolder.Location = '8, 84'
	$labelVMFolder.Margin = '1, 0, 1, 0'
	$labelVMFolder.Name = 'labelVMFolder'
	$labelVMFolder.Size = '59, 17'
	$labelVMFolder.TabIndex = 22
	$labelVMFolder.Text = 'VM Folder:'
	$labelVMFolder.UseCompatibleTextRendering = $True
	#
	# comboboxVMFolders
	#
	$comboboxVMFolders.DropDownStyle = 'DropDownList'
	$comboboxVMFolders.FormattingEnabled = $True
	$comboboxVMFolders.Location = '73, 82'
	$comboboxVMFolders.Name = 'comboboxVMFolders'
	$comboboxVMFolders.Size = '179, 21'
	$comboboxVMFolders.Sorted = $True
	$comboboxVMFolders.TabIndex = 21
	$comboboxVMFolders.add_SelectedIndexChanged($comboboxVMFolders_SelectedIndexChanged)
	#
	# buttonDeleteVMFromQueue
	#
	$buttonDeleteVMFromQueue.Enabled = $False
	$buttonDeleteVMFromQueue.Location = '277, 261'
	$buttonDeleteVMFromQueue.Name = 'buttonDeleteVMFromQueue'
	$buttonDeleteVMFromQueue.Size = '100, 48'
	$buttonDeleteVMFromQueue.TabIndex = 19
	$buttonDeleteVMFromQueue.Text = '<--
Delete VM from Queue'
	$buttonDeleteVMFromQueue.UseCompatibleTextRendering = $True
	$buttonDeleteVMFromQueue.UseVisualStyleBackColor = $True
	$buttonDeleteVMFromQueue.add_Click($buttonDeleteVMFromQueue_Click)
	#
	# buttonAddVirtualMachines
	#
	$buttonAddVirtualMachines.Enabled = $False
	$buttonAddVirtualMachines.Location = '277, 184'
	$buttonAddVirtualMachines.Name = 'buttonAddVirtualMachines'
	$buttonAddVirtualMachines.Size = '100, 52'
	$buttonAddVirtualMachines.TabIndex = 18
	$buttonAddVirtualMachines.Text = '-->
Add Virtual Machines'
	$buttonAddVirtualMachines.UseCompatibleTextRendering = $True
	$buttonAddVirtualMachines.UseVisualStyleBackColor = $True
	$buttonAddVirtualMachines.add_Click($buttonAddVirtualMachines_Click)
	#
	# labelStep2
	#
	$labelStep2.AutoSize = $True
	$labelStep2.Font = 'Microsoft Sans Serif, 12pt, style=Bold'
	$labelStep2.Location = '8, 8'
	$labelStep2.Name = 'labelStep2'
	$labelStep2.Size = '224, 24'
	$labelStep2.TabIndex = 17
	$labelStep2.Text = 'Step 2: Select VMs to modify'
	$labelStep2.UseCompatibleTextRendering = $True
	#
	# buttonNext
	#
	$buttonNext.Anchor = 'Bottom, Right'
	$buttonNext.Location = '440, 420'
	$buttonNext.Name = 'buttonNext'
	$buttonNext.Size = '75, 23'
	$buttonNext.TabIndex = 2
	$buttonNext.Text = '&Next >'
	$buttonNext.UseCompatibleTextRendering = $True
	$buttonNext.UseVisualStyleBackColor = $True
	$buttonNext.add_Click($buttonNext_Click)
	$tabpageStep2.ResumeLayout()
	$panel1.ResumeLayout()
	$tabpageStep1.ResumeLayout()
	$tabcontrolWizard.ResumeLayout()
	$formVMToolsMitigation.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formVMToolsMitigation.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formVMToolsMitigation.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formVMToolsMitigation.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formVMToolsMitigation.ShowDialog()

} #End Function

#Call the form
Show-MainForm_psf | Out-Null
