
Set-StrictMode -Version Latest

# Initialize to null
$script:Twitch_API_ClientID = $null

# Helper function
filter Get-IdFromUri {
    $Uri = $_ -split "/" | Select-Object -Last 1
    return $Uri -split "\?" | Select-Object -First 1
}


# Dot source the Legacy version if not running at least PowerShell 7.0.
# Otherwise, load the Current version of the function.
if ($PSVersionTable.PSVersion.Major -lt 7) {
    . "$PSScriptRoot/Legacy/Get-TwitchXRef-Legacy.ps1"
}
else {
    . "$PSScriptRoot/Current/Get-TwitchXRef.ps1"
}


Set-Alias -Name gtxr -Value Get-TwitchXRef

Export-ModuleMember -Alias "gtxr"
Export-ModuleMember -Variable "Twitch_API_ClientID"
Export-ModuleMember -Function "Get-TwitchXRef"
