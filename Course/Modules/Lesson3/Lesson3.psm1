Function Get-DiskInfo {
    Param(
        [string[]]$ComputerName = ""
    )

    Foreach($Name in $ComputerName) {
        #$drivers = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object -Property DriveType -EQ 3 | Where-Object -Property SystemName -EQ $Name
        $drivers = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

        if ($ComputerName -ne "") {
            $drivers = $drivers | Where-Object -Property SystemName -EQ $Name
        }

        Foreach ($Driver in $drivers) {
            $data = $Driver | Select-Object SystemName, Name, FreeSpace, Size
            [PSCustomObject]@{
                ComputerName = $data.SystemName;
                DriveLetter = $data.Name;
                FreeSpace = $data.FreeSpace;
                Size = $data.Size;
            }
        }
    }
}

# This one is just copied straight from the lesson... -_-
# -Verbose can be used
function Test-NetAdapterInfo {
    [CmdletBinding()]
    param( 
        [string[]]$ComputerName=@("localhost")
    )
     
    foreach ($computer in $computername) {
        if ($computer -eq $ENV:ComputerName) { $computer = 'localhost'}
        $arguments = if ($computer -eq "localhost") { @{} } else { @{
'ComputerName' = $computer }}
        Write-Verbose "Connecting to $computer"
        $session = New-CimSession @arguments
        $adapters = Get-NetAdapter -CimSession $session
        foreach ($adapter in $adapters) {
            $addresses = Get-NetIPAddress -InterfaceIndex ($adapter.InterfaceIndex) -CimSession $session 
            foreach ($address in $addresses) {
                $output = [pscustomobject][ordered]@{
                    'ComputerName'   = $computer
                    'AdapterName'    = $adapter.Name
                    'InterfaceIndex' = $adapter.InterfaceIndex
                    'IPAddress'      = $address.IPAddress
                    'AddressFamily'  = $address.AddressFamily
                } 
                Write-Output $output
            } # addresses
        } # adapters
        Write-Verbose "Closing session to $computer"
        Remove-CimSession -CimSession $session
    } # computers
} # function