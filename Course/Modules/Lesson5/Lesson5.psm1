# Out-Null = don't print

Function Test-XMLGetText {
@"
<entities> 
    <person age="21">Joann</person> 
    <person age="42">Chad</person> 
    <animal species="dog"> 
        <name>Fido</name> 
        <age>4</age> 
        <breed>Cocker Spaniel</breed> 
    </animal> 
    <company name="Microsoft" /> 
</entities>
"@
}

Function Test-XMLRead {
    [xml]$xml = Test-XMLGetText

    # Select stuff
    $xml.SelectSingleNode("//person")
    $xml.SelectSingleNode("//person[@age=21]")
    $xml.SelectNodes("//person")[0]

    # Add new element
    $newele = $xml.CreateElement('newnode')
    $newele.InnerText = "69" | Out-Null
    $xml.DocumentElement.AppendChild($newele) | Out-Null

    # Remove stuff
    $xml.DocumentElement.RemoveChild($xml.SelectSingleNode("//person")) | Out-Null

    # New attribute
    [System.Xml.XmlElement]$ele = $xml.SelectSingleNode("//company")
    $ele.SetAttribute("new_attribute", "woah") | Out-Null

    # Print it
    $xml.OuterXml
}

Function Test-XMLForEach {
    [xml]$xml = Test-XMLGetText

    Foreach ($child in $xml.DocumentElement.ChildNodes) {
        Write-Output $child.OuterXML
    }
}
Function Test-JSONGetText {
@"
{
    "websites":  [
        {
            "name":  "Default Web Site",
            "id":  "oK-SdF0KOmzWeP9qEL7cuQ",
            "key":  1,
            "status":  "started",
            "_links":  "@{self=}"
        },
        {
            "name":  "site01",
            "id":  "neMMC_7YMnPhQ9yf3-9WzA",
            "key":  2,
            "status":  "started",
            "_links":  "@{self=}"
        }
    ]
}
"@
}

Function Test-JSONRead {
    $json = Test-JSONGetText | ConvertFrom-Json

    $json.websites[0].name
}

Function Test-Regex {
    $str = "This is a test string."

    $str -match "is"
    $str -match "dawdaw"
    $str -match "\."
    [regex]::matches($str, "test")
}

Function Test-CustomFormat {
    $netstatOut = netstat -p tcp

    # Skip headers and trim whitespaces away
    $netstatOut[4..$netstatOut.Count].Trim() |
        ConvertFrom-String -Delimiter " {2,}" `
        -PropertyNames Proto, LocalAddress, ForeignAddress, State # Convert the delimited stuff to these properties
}


Function Test-CustomFormat2 {
    $netstatOut = netstat -p tcp

    $template = @" 
Active Connections 
    Proto  Local Address          Foreign Address        State 
    {Proto*:TCP}    {LocalAddress:192.168.0.40:53119}     {ForeignAddress:msnbot-65-52-108-201:https}  {State:ESTABLISHED} 
    {Proto*:TCP}    {LocalAddress:192.168.0.40:64400}     {ForeignAddress:SVR01:microsoft-ds}     {State:ESTABLISHED} 
"@

    $netstatOut | ConvertFrom-String -TemplateContent $template
}

Function Test-ConvertStringExample {
    "Testi Joo", "Mutta Jebs" | Convert-String -Example "Something Foo=SFoo"
}

Function Test-JSONAppendAndFilter {
    $json = Test-JSONGetText | ConvertFrom-Json

    $newlist = @()

    Foreach($website in $json.websites) {
        # Only select name and status
        $website = $website | Select-Object -Property name, status

        $website | Add-Member -Name "new_prop" -Value 1 -MemberType NoteProperty | Out-Null
        $website | Add-Member -Name "new_prop_str" -Value "WOAH" -MemberType NoteProperty | Out-Null

        $newlist += $website
    }

    $newlist
}
