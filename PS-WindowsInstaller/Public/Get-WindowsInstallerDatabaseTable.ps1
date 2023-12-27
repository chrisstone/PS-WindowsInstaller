$msiDatabaseSchema = @{
	Upgrade      = @{
		'UpgradeCode'    = 1
		'VersionMin'     = 2
		'VersionMax'     = 3
		'Language'       = 4
		'Attributes'     = 5
		'Remove'         = 6
		'ActionProperty' = 7
	}
	Property     = @{
		'Property' = 1
		'Value'    = 2
	}
	File         = @{
		'File'       = 1
		'Component_' = 2
		'FileName'   = 3
		'FileSize'   = 4
		'Version'    = 5
		'Language'   = 6
		'Attributes' = 7
		'Sequence'   = 8
	}
	Component    = @{
		'Component'   = 1
		'ComponentId' = 2
		'Directory_'  = 3
		'Attributes'  = 4
		'Condition'   = 5
		'KeyPath'     = 6
	}
	Feature      = @{
		'Feature'        = 1
		'Feature_Parent' = 2
		'Title'          = 3
		'Description'    = 4
		'Display'        = 5
		'Level'          = 6
		'Directory_'     = 7
		'Attributes'     = 8
	}
	Registry     = @{
		'Registry'   = 1
		'Root'       = 2
		'Key'        = 3
		'Name'       = 4
		'Value'      = 5
		'Component_' = 6
	}
	Shortcut     = @{
		'Shortcut'    = 1
		'Directory_'  = 2
		'Name'        = 3
		'Component_'  = 4
		'Target'      = 5
		'Arguments'   = 6
		'Description' = 7
		'Hotkey'      = 8
		'Icon_'       = 9
		'IconIndex'   = 10
		'ShowCmd'     = 11
		'WkDir'       = 12
	}
	CustomAction = @{
		'Action' = 1
		'Type'   = 2
		'Source' = 3
		'Target' = 4
	}
}


<#
.SYNOPSIS
Fetches a table from a Windows Installer Database.

.DESCRIPTION
The Get-WindowsInstallerDatabaseTable function retrieves data from a specified table in a Windows Installer Database.
It uses the OpenView and Fetch methods to get the data. The function can return the data as an array or as a hashtable.

.PARAMETER Database
Specifies the Windows Installer Database COM object from which the table is retrieved. This parameter is mandatory.

.PARAMETER TableName
Specifies the name of the table to retrieve. This parameter is mandatory.

.PARAMETER Schema
Specifies the schema of the table. This is a hashtable that maps column names to their indices. If not provided, it defaults to $msiDatabaseSchema.$TableName.

.PARAMETER AsHashtable
If this switch is set, the function will return the data as a hashtable instead of an array. This parameter is optional.

.PARAMETER Where
This is a placeholder for a future feature to filter rows from the table. This parameter is optional.

.EXAMPLE
$Database = Open-WindowsInstallerDatabase -DatabasePath "C:\Path\To\Database.msi"
Get-WindowsInstallerDatabaseTable -Database $Database -TableName "Property"

This example retrieves the Property table from a specified Windows Installer Database.

#>
function Get-WindowsInstallerDatabaseTable {
	[CmdletBinding(DefaultParameterSetName = 'AsArray')]
	[OutputType([Array], ParameterSetName = 'AsArray')]
	[OutputType([Hashtable], ParameterSetName = 'AsHashtable')]
	param (
		[Parameter(Mandatory = $true)]
		[System.__ComObject]	$Database,

		[Parameter(Mandatory = $true)]
		[string]				$TableName,

		[Parameter(Mandatory = $false,
			ParameterSetName = 'AsArray')]
		[Hashtable]				$Schema = $msiDatabaseSchema.$TableName,

		[Parameter(Mandatory = $false,
			ParameterSetName = 'AsHashtable')]
		[switch]				$AsHashtable,

		[Parameter(Mandatory = $false)]
		[string]				$Where # TODO Implement Where
	)

	begin {
		$View = $Database.GetType().InvokeMember("OpenView", [System.Reflection.BindingFlags]::InvokeMethod, $null, $Database, "SELECT * FROM $TableName")
		$View.GetType().InvokeMember("Execute", [System.Reflection.BindingFlags]::InvokeMethod, $null, $View, $null) | Out-Null
		if ($AsHashtable) {
			$Results = @{}
		} else {
			$Results = @()
		}
	}

	process {
		while ($null -ne ($Row = $View.GetType().InvokeMember("Fetch", [System.Reflection.BindingFlags]::InvokeMethod, $null, $View, $null))) {
			if ($AsHashtable) {
				$Key = $View.GetType().InvokeMember("StringData", [System.Reflection.BindingFlags]::GetProperty, $null, $Row, 1)
				$Val = $View.GetType().InvokeMember("StringData", [System.Reflection.BindingFlags]::GetProperty, $null, $Row, 2)
				$Results[$Key] = $Val
			} else {
				$RowData = @{}
				foreach ($ColumnName in $Schema.Keys) {
					$RowData[$ColumnName] = $View.GetType().InvokeMember("StringData", [System.Reflection.BindingFlags]::GetProperty, $null, $Row, $Schema[$ColumnName])
				}
				$Results += $RowData
			}
		}
	}

	end {
		$View.GetType().InvokeMember("Close", [System.Reflection.BindingFlags]::InvokeMethod, $null, $View, $null) | Out-Null
		[System.Runtime.Interopservices.Marshal]::ReleaseComObject($View) | Out-Null

		return $Results
	}

}
Export-ModuleMember -Function Get-WindowsInstallerDatabaseTable
