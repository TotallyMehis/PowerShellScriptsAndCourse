# JEA (Just Enough Administration) requires WMF 5.0 (introduced in Powershell 5.0, uses PS remoting)
# You need to explicitly define what you allow the remote user to run.



# Creates test.psrc
# NOTE: THIS SHOULD RESIDE IN PSModulePath path inside RoleCapabilities-folder TO TAKE EFFECT
# Allow function Test-JSONGetText
# Allow to manipulate PS variables
# Allows PS cmlets Write-Output and Stop-Website with -Name switch set to 'Default Web Site'
# Allow to run netstat program
New-PSRoleCapabilityFile `
    -Path "test.psrc" `
    -VisibleFunctions "Test-JSONGetText" `
    -VisibleProviders "Variable" `
    -VisibleCmdlets 'Write-Output', `
    @{
        Name = "Stop-Website"; # 
        Parameters = @{
            Name = 'Name';
            ValidateSet = "Default Web Site";
            #ValidatePattern
        };
    } `
    -VisibleExternalCommands "C:\Windows\System32\netstat.exe"

# Create a session configuration file
New-PSSessionConfigurationFile `
    -Path "test.pssc" `
    -SessionType "RestrictedRemoteServer"

# Run this to allow the remoting on this host
#Register-PSSessionConfiguration -Path ".\test.pssc"



# Remoting


# Explicit
#Enter-PSSession -ComputerName "bla"


# Implicit
#New-PSSession -ComputerName "bla" | Import-PSSession -Prefix 'PREFIX'
#Get-PREFIXCommand

# Using DSC to propagate JEA
# I gave up
# Configuration JEA {
#     Import-DscResource -ModuleName JustEnoughAdministration, PSDesiredStateConfiguration
#     File GetRoleShit { # ??????????
#         SourcePath = "test.psrc"
#         DestinationPath = "C:\Program Files\WindowsPowerShell\Modules\RoleCapabilities"
#     }
#     JeaEndpoint Something {
#         EndpointName = "something"
#         RoleDefinitions = @{"admins" = @{RoleCapabilities = 'somethingwdaw'}}
#         # NOT DONE
#     }
# }
