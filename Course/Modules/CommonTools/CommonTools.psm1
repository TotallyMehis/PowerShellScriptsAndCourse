Function Get-OSInfo {
    [CmdletBinding()]
    Param(
        [string[]]$computername=@("localhost")
    )

    PROCESS {
        $CVPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        foreach ($computer in $computername) {
            if ($computer -eq $ENV:ComputerName) { $computer = 'localhost'}
            $arguments = if ($computer -eq "localhost") { @{} } else { @{ 'ComputerName' = $computer }}
            $OS = Get-CimInstance -ClassName Win32_OperatingSystem @arguments
            $ReleaseID = (Get-ItemProperty -Path $CVPath -Name ReleaseId).ReleaseId
            $output = [pscustomobject][ordered]@{
                'OSName' = $OS.Caption
                'OSArchitecture' = $OS.OSArchitecture
                'OSLanguage' = $OS.MUILanguages[0]
                'OSVersion' = $ReleaseID
                'OSBuild' = $OS.Version
            }
            Write-Output $output
        } # Computers
    } # Process
} # Function

Function Get-MemInfo {
    [CmdletBinding()]
    Param(
        [string[]]$computername=@("localhost")
    )

    PROCESS {
        $KiB_PER_GiB = [Math]::Pow(1024,2)
        foreach ($computer in $computername) {
            if ($computer -eq $ENV:ComputerName) { $computer = 'localhost'}
            $arguments = if ($computer -eq "localhost") { @{} } else { @{ 'ComputerName' = $computer }}
            $Memory = Get-CimInstance -ClassName Win32_OperatingSystem @arguments
            $output = [pscustomobject][ordered]@{
                'FreeMemory (GiB)'  = [Math]::Round($Memory.FreePhysicalMemory / $KiB_PER_GiB, 2)
                'TotalMemory (GiB)' = [Math]::Round($Memory.TotalVisibleMemorySize / $KiB_PER_GiB, 2)
                'Occupied' = [Math]::Round($Memory.FreePhysicalMemory * 100 / $Memory.TotalVisibleMemorySize, 2)
            }
            Write-Output $output
        } # Computer
    } # Process
} # Function
