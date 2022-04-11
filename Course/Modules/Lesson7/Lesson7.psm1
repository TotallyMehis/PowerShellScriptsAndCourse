#
# Debug mode:
#
# Set-PSBreakpoint (editor uses this to add breakpoints)
# Get-PSBreakpoint
# Remove-PSBreakpoint
# Disable-PSBreakpoint
# You get the idea
#
# Wait-Debugger
# To wait as a job
#
# Enter variable name to print the value.
# v to step over
# etc.
#

Function Get-ArchitectureInfo {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string[]]$ComputerName = "localhost"
    )
    PROCESS {
        foreach ($computer in $computername) {
            # All CPUs should be the same so only get one
            $proc = Get-CimInstance -ClassName Win32_Processor -ComputerName $computer |
                     Select-Object -first 1
            $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer
            $properties = @{'ComputerName'=$Computer;
                            'OSArchitecture'=$os.osarchitecture;
                            'ProcArchitecture'=$proc.addresswidth}
            $obj = New-Object -TypeName PSObject -Property $properties
            # If run with -Debug will break here.
            #Write-Debug "stuff"
            Write-Output $obj
        }
    }
}
