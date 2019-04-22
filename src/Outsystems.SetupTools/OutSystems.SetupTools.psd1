#
# Module manifest for module 'OutSystems.SetupTools'
#
# Generated by: Pedro Nunes
#
# Generated on: 6/16/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'OutSystems.SetupTools.psm1'

# Version number of this module.
ModuleVersion = '2.6.0.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'dcc020ea-a9c7-4bd3-91fc-e97432301020'

# Author of this module
Author = 'Pedro Nunes'

# Company or vendor of this module
CompanyName = 'OutSystems'

# Copyright statement for this module
Copyright = '(c) 2018 OutSystems. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Tools for installing and manage the OutSystems platform installation'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
ProcessorArchitecture = 'Amd64'

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('AzureRM.Storage')

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @(
    '.\Lib\Assemblies\OutSystems.RuntimeCommon.dll'
    '.\Lib\Assemblies\OutSystems.HubEdition.RuntimePlatform.dll'
    '.\Lib\Assemblies\ICSharpCode.SharpZipLib.dll'
    '.\Lib\Assemblies\OutSystems.Common.dll'
    '.\Lib\Assemblies\Microsoft.ApplicationInsights.dll'
)

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Disable-OSServerIPv6',
    'Get-OSPlatformApplications',
    'Get-OSPlatformModules',
    'Get-OSPlatformVersion',
    'Get-OSRepoAvailableVersions',
    'Get-OSServerConfig',
    'Get-OSServerInstallDir',
    'Get-OSServerPrivateKey',
    'Get-OSServerVersion',
    'Get-OSServiceStudioInstallDir',
    'Get-OSServiceStudioVersion',
    'Install-OSPlatformLicense',
    'Install-OSPlatformServiceCenter',
    'Install-OSServer',
    'Install-OSServerPreReqs',
    'Install-OSServiceStudio',
    'New-OSPlatformPrivateKey',
    'New-OSServerConfig',
    'Publish-OSPlatformLifetime',
    'Publish-OSPlatformModule',
    'Publish-OSPlatformSolution',
    'Publish-OSPlatformSystemComponents',
    'Restart-OSServerServices',
    'Set-OSInstallLog',
    'Set-OSServerConfig',
    'Set-OSServerPerformanceTunning',
    'Set-OSServerSecuritySettings',
    'Set-OSServerWindowsFirewall',
    'Start-OSServerServices',
    'Stop-OSServerServices',
    'Test-OSServerHardwareReqs',
    'Test-OSServerSoftwareReqs',
    'Get-OSServerInfo',
    'Get-OSServiceStudioInfo',
    'Get-OSPlatformDeploymentZone',
    'Set-OSPlatformDeploymentZone',
    'Write-OSInstallLog'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('OutSystems')

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/OutSystems/OutSystems.SetupTools'

        # A URL to an icon representing this module.
        IconUri = 'https://avatars2.githubusercontent.com/u/2916417?s=200&v=4'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease = '-beta1'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


