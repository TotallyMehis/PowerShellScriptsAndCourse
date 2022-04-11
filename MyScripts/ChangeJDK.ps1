#
# Add JDKs here.
#
$JDKs = @{
    "8" = "C:\Program Files\Amazon Corretto\jdk1.8.0_302";
    "11" = "C:\Program Files\Amazon Corretto\jdk11.0.13_8";
    "17" = "C:\Program Files\Amazon Corretto\jdk17.0.1_12"
}



function SetJDK {
    param (
        $WantedJDK
    )

    if (!$JDKs.ContainsKey($WantedJDK)) {
        Write-Warning "$WantedJDK is not a valid JDK version!"
        return $false
    }

    # Replace PATH with Regex & JAVA_HOME.
    $NewPATH = $env:PATH -replace [Regex]::Escape($JDKs[$CurrentJDK]),$JDKs[$WantedJDK]

    Write-Host "Changing JAVA_HOME and PATH environmental variables to point to JDK $WantedJDK..."

    Try {
        [System.Environment]::SetEnvironmentVariable("PATH", $NewPATH, 'User')
        [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $JDKs[$WantedJDK], 'User')
    }
    Catch {
        Write-Error "Failed to change environmental variables!"
    }

    return $true
}

$CurrentJDK = $null

Write-Host "Configured JDKs:"
foreach ($JDK in $JDKs.GetEnumerator()) {
    $Key = $JDK.Key
    $Value = $JDK.Value
    Write-Host "JDK $Key = $Value"
    if ($env:JAVA_HOME.contains($Value)) {
        $CurrentJDK = $Key
    }
}

if ($null -eq $CurrentJDK) {
    Write-Error "Failed to recognize current installed JDK version!"
    return
}

Write-Host "Current JDK: $CurrentJDK"

$AskForJDK = $true

if ($args.Count -ge 1) {
    $WantedJDK = [string]$args[0]
    Write-Host "Trying to set JDK to $WantedJDK"

    if (SetJDK($WantedJDK)) {
        $AskForJDK = $false
    }
}

while ($AskForJDK) {
    $WantedJDK = Read-Host "Set JDK to"

    if ($WantedJDK -eq "") {
        break
    } else {
        if (SetJDK($WantedJDK)) {
            break
        }
    }
}

Write-Host "Done!"
