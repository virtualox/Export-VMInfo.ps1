# Export VM Info from vCenter/ESXi

This PowerShell script retrieves VM details from a vCenter or ESXi host and exports them to a CSV file.

## Features

- Connects to a specified vCenter or ESXi host.
- Retrieves the following VM details:
  - VM Name
  - IP Address
  - Guest OS
  - Notes
- Exports the gathered data to a CSV file.

# Usage

1. Ensure you have VMware PowerCLI installed.
2. Run the script, specifying the server and output path.

```powershell
.\Export-VMInfo.ps1 -Server 'my.vcenter.com' -OutputPath "C:\path\to\output.csv"
```

When prompted, enter the username and password for the vCenter or ESXi host.

# Requirements

- VMware PowerCLI.
- Necessary permissions to query the vCenter or ESXi host.

# Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

