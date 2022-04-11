#
# =======================================
# Reload this:
# 
# Import-Module -Name MyTests -Force
# =======================================
#
Function Test-Print1 {
    Write-Output "Print using Write-Output!"
}

Function Test-Print2 {
    Write-Host "Print using Write-Host!"
}

Function Test-Print3 {
    "Print using a simple string!"
}

Function Test-Arg {
    Param (
        $Param1 = "Default argument :)"
    )

    "Argument: $Param1"
}

Function Test-ArgType {
    Param (
        [int]$Param1 = 2
    )

    "Argument: $Param1"
}

# Can be called like:
# Test-ArgAnnotation 1
# Test-ArgAnnotation -Param 1
# Test-ArgAnnotation -ParamAlias 1
# Test-ArgAnnotation ... <Input number>
Function Test-ArgAnnotation {
    Param (
        [Parameter(Mandatory=$true, HelpMessage="This is the parameter help message. Must be 0 or 1.")]
        [ValidateRange(0, 1)]
        [int]
        [Alias("ParamAlias")]
        $Param
    )

    "Argument: $Param"
}

# Can be called like:
# Test-ArgList param1, param2, param3
# Test-ArgList -Params param1, param2, param3
Function Test-ArgList {
    Param (
        [string[]]$Params
    )

    Foreach ($Param in $Params) {
        Write-Output "Argument: $Param"
    }
}

Function Test-AdvancedFunc {
    [CmdletBinding()]
    Param(
        $Param1
    )

    "Argument: $Param1"
}

Function Test-Blocks {
    Param (
        [int]$Param1
    )
    Begin {
        Write-Host "Begin block"
    }
    Process {
        Write-Host "Process block"
    }
    End {
        Write-Host "End block"
    }
}
