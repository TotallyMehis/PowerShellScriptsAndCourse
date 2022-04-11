function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="This is the help")]
        #[ValidatePattern('LON-\w{2,3}\d{1,2}')]
        [string]$ComputerName
    )

    foreach ($Computer in $ComputerName) {
        Write-Verbose "Now  connecting to $Computer"
        Write-Output "Testing $Computer"
    }
}

Get-CorpCompSysInfo