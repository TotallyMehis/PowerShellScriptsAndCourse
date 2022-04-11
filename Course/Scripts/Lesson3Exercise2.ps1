$Continue = $True
While ($Continue) {
    Write-Host "1. Display operating system information"
    Write-Host "2. Display disk information"
    Write-Host "3. Display memory information"
    Write-Host "4. Turn computer off"
    Write-Host "X. Exit"

    $choice = Read-Host "Your option"
    Switch ($choice) {
        1 { Get-OSInfo }
        2 { Get-DiskInfo }
        3 { Get-MemInfo }
        #4 { Stop-Computer }
        "X" { $Continue }
        default {
            Write-Host "Uknown choice $choice!" -ForegroundColor Red
        }
    }
}
