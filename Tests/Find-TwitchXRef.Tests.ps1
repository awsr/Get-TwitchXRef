#Requires -Module @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }

BeforeAll {
    $ModulePath = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModulePath "Module/StreamXRef.psd1"
    Import-Module $ModulePath -Force -ErrorAction Stop
    Import-Module Microsoft.PowerShell.Utility -Force

    function MakeMockHTTPError {
        [CmdletBinding()]
        Param(
            [Parameter(Mandatory = $true)]
            [ValidateSet(404, 503)]
            [int]$Code
        )

        $ErrorData = @{}
        $ErrorData.404 = @{
            Code    = [System.Net.HttpStatusCode]::NotFound
            String  = "Response status code does not indicate success: 404 (Not Found)."
            Details = '{"error":"Not Found","status":404,"message":""}'
        }
        $ErrorData.503 = @{
            Code    = [System.Net.HttpStatusCode]::ServiceUnavailable
            String  = "Response status code does not indicate success: 503 (Service Unavailable)."
            Details = "I don't remember what the error details should look like, but this doesn't really matter."
        }

        $Response = [System.Net.Http.HttpResponseMessage]::new($ErrorData[$Code].Code)
        $Exception = [Microsoft.PowerShell.Commands.HttpResponseException]::new($ErrorData[$Code].String, $Response)
        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
            $Exception,
            "WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeRestMethodCommand",
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $null
        )
        $ErrorRecord.ErrorDetails = $ErrorData[$Code].Details
        return $ErrorRecord
    }
}

Describe "HTTP response errors" -Tag HTTPResponse {
    BeforeEach {
        Clear-XRefLookupData -RemoveAll -Force
        Import-XRefLookupData -ApiKey notreal -Force
    }
    Context "404 Not Found" {
        BeforeEach {
            Mock Invoke-RestMethod -ModuleName StreamXRef -ParameterFilter { $RestArgs.Uri -notlike "*ValidClipName" } -MockWith {
                $PSCmdlet.ThrowTerminatingError($(MakeMockHTTPError -Code 404))
            }
        }
        It "Clip name not found" {
            $Result = Find-TwitchXRef -Source ClipNameThatResultsIn404Error -XRef TestVal -ErrorVariable TestErrs -ErrorAction SilentlyContinue

            $TestErrs[0].InnerException.Response.StatusCode | Should -Be 404
            $Result | Should -BeNullOrEmpty

        }
        It "Clip URL not found" {
            $Result = Find-TwitchXRef -Source https://clip.twitch.tv/AnotherBadClipName -XRef TestVal -ErrorVariable TestErrs -ErrorAction SilentlyContinue

            $TestErrs[0].InnerException.Response.StatusCode | Should -Be 404
            $Result | Should -BeNullOrEmpty

        }
        It "Video URL not found" {
            $Result = Find-TwitchXRef -Source "https://www.twitch.tv/videos/123456789?t=1h23m45s" -XRef TestVal -ErrorVariable TestErrs -ErrorAction SilentlyContinue

            $TestErrs[0].InnerException.Response.StatusCode | Should -Be 404
            $Result | Should -BeNullOrEmpty

        }
        It "Continues with next entry in the pipeline" {
            InModuleScope StreamXRef {
                Mock Invoke-RestMethod -ParameterFilter { $RestArgs.Uri -like "*ValidClipName" } -MockWith {
                    return [pscustomobject]@{
                        vod = [pscustomobject]@{
                            id = 123456789
                            offset = 2468
                        }
                        created_at = [datetime]::UtcNow
                    }
                }
                $TestArray = @()
                $TestArray += [pscustomobject]@{ Source = "BadClipName"; XRef = "TestVal" }
                $TestArray += [pscustomobject]@{ Source = "ValidClipName"; XRef = "TestVal" }

                $Result = $TestArray | Find-TwitchXRef -ErrorVariable TestErrs -ErrorAction SilentlyContinue

                $TestErrs[0].InnerException.Response.StatusCode | Should -Be 404 -Because "only the call with 'ValidClipName' is mocked with values"
                $TwitchData.ClipInfoCache.Keys | Should -Contain "ValidClipName"
                $Result | Should -BeNullOrEmpty

            }
        }
    }
    Context "503 Service Unavailable" {
        BeforeEach {
            Mock Invoke-RestMethod -ModuleName StreamXRef -MockWith {
                $PSCmdlet.ThrowTerminatingError($(MakeMockHTTPError -Code 503))
            }
        }
        It "503 during clip lookup" {
            { Find-TwitchXRef -Source https://clip.twitch.tv/WhatCouldGoWrong -XRef TestVal } | Should -Throw
        }
    }
}
