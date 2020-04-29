#
# Module manifest for module 'Get-TwitchXRef'
#
# Generated by: Alex Wiser
#
# Generated on: 4/29/2020
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Get-TwitchXRef.psm1'

# Version number of this module.
ModuleVersion = '2.9.9'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '8c89ef10-5110-4406-a876-82b8eadf5bb2'

# Author of this module
Author = 'Alex Wiser'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = 'Copyright 2020 Alex Wiser. Licensed under MIT license.'

# Description of the functionality provided by this module
Description = 'Given a Twitch clip or video timestamp URL, get a URL to the same moment from the cross-referenced video or channel.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-TwitchXRef'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = 'Twitch_API_ClientID'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'gtxr'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = 'Get-TwitchXRef.psm1', 'Current\Get-TwitchXRef.ps1', 
               'Legacy\Get-TwitchXRef-Legacy.ps1'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Twitch', 'Stream', 'Cross-Reference', 'Reference', 'Rest', 'API', 'Find', 
               'Search'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/awsr/Get-TwitchXRef/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/awsr/Get-TwitchXRef'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

