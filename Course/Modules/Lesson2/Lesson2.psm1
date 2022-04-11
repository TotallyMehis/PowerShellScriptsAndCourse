Function Test-WriteLine {
    [System.Console]::WriteLine("Hello world!")
}

Function Test-RoundedPie {
    # NOTE: System namespace already included
    # AND case insensitive
    $roundedpie = [System.Math]::Round([math]::PI)
    Write-Output "Rounded pie: $roundedpie"
}

Function Test-RoundedPieToDigits {
    param(
        $Digits = 3
    )

    $roundedpie = [System.Math]::Round([Math]::PI, $Digits)
    Write-Output "Rounded pie: $roundedpie"
}

Function Test-NewObject {
    $guid = [System.Guid]::NewGuid()

    Write-Output $guid
}

Function Test-TypeAccelerator {
    $Date = [datetime]"27 Jan 2017" 
    
    Write-Output $Date
}

Function Test-Instances {
    $svc = Get-Service -Name Bits

    Write-Output $svc
}

Function Test-S {
    foreach ($val in $Env) {
        Write-Output $val
    }
}

Function Test-StartNotepad {
    $process = [System.Diagnostics.Process]::Start("notepad.exe")
    Write-Output $process

    Write-Output "Waiting for Notepad process to exit..."
    $process.WaitForExit()
}

Function Test-Rest1 {
    $output = Invoke-RestMethod -Uri https://strims.gg/api | Select-Object -Property streams

    # Foreach ($stream in $output.Properties) {
    #     Write-Output "Stream: $stream"
    # }
    $hashtable = $output.psobject.Members | where-object membertype -like 'noteproperty'
    Foreach ($prop in $hashtable) {
        Write-Output "Value: $prop"
    }
}

Function Test-DownloadFile {
    $webclient = New-Object Net.WebClient
    # Print all methods, etc.
    #$webclient | Get-Member

    $webclient.DownloadFile("https://file-examples-com.github.io/uploads/2017/10/file_example_PNG_500kB.png", "outputfile.png")
}

Function Test-GetCurrentUserName {
    [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
}

Function Test-CurrentUserHasRole {
    param(
        $Role = "Administrator"
    )

    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    
    $principal = [System.Security.Principal.WindowsPrincipal]$currentUser

    $role = [System.Security.Principal.WindowsBuiltInRole]$Role
    
    $principal.IsInRole($role)
}
