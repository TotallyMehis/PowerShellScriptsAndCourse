# IMPORTANT: MUST BE RUN AS ADMIN
#
# AFTERWARDS:
#
# Start-DscConfiguration -Path .\TestConfiguration\ -Wait
#
# Which will apply the configuration (in this case copy a file) to the desired hosts (localhost).
# This is the Push-method.
#
# With Pull-method, we'd have a separate server with this configuration.
#

#
# 
#


# DSC = Desired State Configuration
# LCM = Local Configuration Manager, does what MOF file says
# MOF = Managed Object Format, which WMI (Windows Management Instrumentation) uses to configure the machine

# To use partial configuration
#[DSCLocalConfigurationManager()]
Configuration TestConfiguration {
    param() # You can give parameters like usual

    # PSDesiredStateConfiguration seems to come with Windows 10
    # Use
    # Get-DscResource
    # to view all possible resources to use.
    # Get-DSCResource <Name> | Select –ExpandProperty Properties
    # to view all properties you need to define for the resource. 
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    # Node = Computer
    # Who to
    # Can also be a list
    Node localhost {

        # Configuration for host's LCM
        # See command
        # Get-DscLocalConfigurationManager
        # what the host is configured with
        #LocalConfigurationManager {
            #ConfigurationMode = "ApplyandMonitor" # or ApplyOnly, etc. 
            #ConfigurationModeFrequencyMins # How often MOF is checked for changes
            #RebootNodeIfNeeded
        #}
        # Can only be used with DSCLocalConfigurationManager annotation enabled
        #Settings {
            #RefreshMode = 'Pull'
        #}
        # Configure pull mode
        #ConfigurationRepositoryWeb dwadaw {
            #ServerURL = 'http://DWADWA.com/PSDSCPullServer.svc'
            #AllowUnsecureConnection = 'true'
        #}

        #
        # Resources
        #

        # Environment JustANameDoesntMatter {
        #     Name = 'TestPathEnvironmentVariable'
        #     Value = 'TestValue'
        #     Ensure = 'Present'
        #     Path = $True
        #     #Target = @('Process', 'Machine')
        # }
        File TestNameItDoesntMatter {
            Ensure = "Present"
            Type = "File"
            SourcePath = "C:\Users\notme\Documents\WindowsPowerShell\Scripts\test.html"
            DestinationPath = "C:\Users\notme\Documents\WindowsPowerShell\Scripts\test_COPY.html"
        }
    }
}

# Creates the MOF files
TestConfiguration



Configuration TestStuff {
    Param(
        [string]$ComputerName = 'localhost'
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $ComputerName {
        Service ServiceResource {
            Name = "BITS"
            StartupType = "Automatic"
            State = "Running"
        }
        Script ScriptResource {
            # Create a folder
            SetScript = { New-Item -Path "C:\" -Name "AdatumLogs" -ItemType "Directory" }
            GetScript = { Get-Item -Path "C:\AdatumLogs" }
            TestScript = { Test-Path -Path "C:\AdatumLogs" }
        }
        WindowsFeature FeatureResource {
            Name = "Windows-Server-Backup"
        }
    }
}
