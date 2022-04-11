Function Get-FileVersion {
<#
.Synopsis
    Fuck off.
.Description
    Get-FileVersion displays file's version information.
.Parameter FileNames
    File name(s)
.Example
    Get-FileVersion C:\Windows\explorer.exe
.Example
    Get-FileVersion C:\Windows\explorer.exe, C:\Windows\notepad.exe -Confirm/-WhatIf
#>
    # NOTICE:
    # - Nothing(?) is case sensitive ($true, $version)
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact="High")]
    Param(
        [Parameter(Mandatory=$True,
                   HelpMessage='This is the help message.',
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [Alias('FileName')]
        [ValidatePattern('html$')]
        [string[]]$FileNames
    )

    PROCESS {
        Foreach ($FileName in $FileNames) {
            #if (!$PSCmdlet.ShouldProcess($FileName)) {
            #    continue
            #}

            Write-Verbose "Checking $FileName"

            $ItemProperty = Get-ItemProperty -Path $FileName

            $version = Get-ItemPropertyValue -Path $FileName -Name VersionInfo |
                Select-Object ProductVersion, FileVersion, CompanyName, FileName
            $CreationDate = $ItemProperty | Select-Object -ExpandProperty CreationTime
            $LastAccessDate = $ItemProperty | Select-Object -ExpandProperty LastAccessTime

            $Properties = @{
                "FileName" = $FileName;
                "ProductVersion" = $Version.ProductVersion;
                "FileVersion" = $Version.FileVersion;
                "CreationDate" = $CreationDate;
                "LastAccessDate" = $LastAccessDate;
            }

            $output = [PSCustomOBject]$Properties
            #Could also be: (old)
            #$output = New-Object -TypeName PSObject -Property $Properties
            Write-Output $output
        }
    }
}


function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="This is the help")]
        [ValidatePattern('LON-\w{2,3}\d{1,2}')]
        [string[]]$ComputerName
    )

    Write-Debug "Test"

    foreach ($Computer in $ComputerName) {
        Write-Verbose "Now  connecting to $Computer"
        Write-Output "Testing $Computer"
    }
}
