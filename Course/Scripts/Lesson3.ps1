[CmdletBinding()]
Param(
    $FileName = "test.html"
)

$style = "
<style> 
    body { 
        font-family: Segoe, Tahoma, Arial, Helvetica; 
        font-size: 10pt; 
        color: #333; 
        background-color: #eee; 
        margin: 10px; 
    }
    th { 
        font-weight: bold; 
        color: white; 
        background-color: #333; 
    }
</style>
"


Write-Host "Outputting to $FileName"

$tbl1 = Get-Process -Name "code" |
    ConvertTo-Html -Fragment -PreContent "$style<h2>Visual Studio Code</h2>" |
    Out-String

$tbl2 = Get-Process -Name "powershell" |
    ConvertTo-Html -Fragment -PreContent "<h2>Powershell</h2>" |
    Out-String

ConvertTo-Html `
    -Title "System report" `
    -Head $style `
    -Body $tbl1, $tbl2 |
    Out-File $FileName
