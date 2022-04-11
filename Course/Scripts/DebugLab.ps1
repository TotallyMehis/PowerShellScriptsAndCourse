[CmdLetBinding()]
param(
    [Parameter(Mandatory=$True)]
    [string[]]$RuleName
)

foreach ($name in $RuleName) {
    Get-NetFirewallRule -DisplayName $name |
        Where-Object -Property Enabled -EQ True |
        Select-Object -Property DisplayName, Profile, Direction, Action, Description
}