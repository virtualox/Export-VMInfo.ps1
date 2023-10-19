<#
.SYNOPSIS
This script retrieves VM information from a vCenter or ESXi host and exports it to a CSV file.

.DESCRIPTION
The script connects to a specified vCenter or ESXi host, retrieves virtual machine information, and extracts the following details:
- VM Name
- IP Address
- Guest OS
- Notes

The extracted data is then exported to a CSV file.

.PARAMETER Server
The address of the vCenter or ESXi host.

.PARAMETER OutputPath
The path to the CSV file where the data should be saved.

.EXAMPLE
.\Export-VMInfo.ps1 -Server 'my.vcenter.com' -OutputPath "C:\path\to\output.csv"

.NOTES
Ensure VMware PowerCLI is installed and you have the necessary rights to query the vCenter or ESXi host.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Server,

    [Parameter(Mandatory=$true)]
    [string]$OutputPath
)

# Ensure the VMware PowerCLI module is installed
Import-Module VMware.VimAutomation.Core

# Get credentials
$Username = Read-Host "Enter username for $Server"
$Password = Read-Host "Enter password for $Server" -AsSecureString

$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $Password

# Connect to the specified vCenter or ESXi host
Connect-VIServer -Server $Server -Credential $Credentials

# Retrieve VM information
$vms = Get-VM | Get-VMGuest

# Create an object with the desired output for each VM
$output = $vms | ForEach-Object {
    [PSCustomObject]@{
        'VM Name'   = $_.VM.Name
        'IP Address'  = $_.IPAddress[0] # Get the first IP address. Adjust as needed.
        'Guest OS'   = $_.OSFullName
        'Notes' = $_.VM.Notes
    }
}

# Export the object to a CSV file
$output | Export-Csv -Path $OutputPath -NoTypeInformation -Delimiter "`t"

# Disconnect from the vCenter or ESXi host
Disconnect-VIServer -Confirm:$false
