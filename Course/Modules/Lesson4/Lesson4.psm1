# Stop
# Inquire
# SilentlyContinue
# Continue
Function Test-Exception {
    param(
        $Action = "Stop"
    )
    $FileName = "dawdawdawdaw.txt"

    Try {
        $content = Get-Content -Path $FileName -ErrorAction $Action
        Write-Host "This should not be printed! Content: $content"
    }
    Catch {
        Write-Host "Failure reading file $FileName"
    }
    Finally {
        Write-Host "Finally block"
    }
}

Function Test-ExceptionThrowCustom {
    [CmdletBinding()]
    Param()

    throw "I don't like you"

    Write-Host "You continued :)"
}

Function Test-ExceptionThrowCustom2 {
    Write-Error -Message "Stap" -ErrorAction Stop
}

Function Test-AppendToErrorFile {
    Param(
        $Content = "Fuck off"
    )

    Write-Warning $Content | Out-File "errors.txt" -Append
}