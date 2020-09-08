#Requires -Module @{ ModuleName = 'Pester'; ModuleVersion = '5.0.2' }

Describe "Persistence functionality" {
    BeforeAll {
        Get-Module StreamXRef | Remove-Module
        $ProjectRoot = Split-Path -Parent $PSScriptRoot

        # Use Pester automatic variable $TestDrive for temporary location
        # This is currently the only test script that is set up in a way that works with it
        $Env:XRefPersistPath = Join-Path $TestDrive "StreamXRef/datacache.json"

        Import-Module "$ProjectRoot/Module/StreamXRef.psd1" -Force
    }
    AfterAll {
        Disable-XRefPersistence -Quiet -Remove
        $Env:XRefPersistPath = $null
    }

    Context "Standalone" {
        It "Creates event subscriber" {
            Enable-XRefPersistence -Quiet
            Get-EventSubscriber XRefNewDataAdded | Should -HaveCount 1
        }

        It "Creates placeholder file on first enable" {
            Test-Path $Env:XRefPersistPath | Should -BeTrue
        }
    }

    Context "Automatic" {
        It "Enables persistence on module load" {
            Import-XRefData -ApiKey "TestValue" -Quiet -Persist
            Get-Module StreamXRef | Remove-Module

            Import-Module "$ProjectRoot/Module/StreamXRef.psd1" -Force

            InModuleScope StreamXRef {
                $PersistEnabled | Should -BeTrue
                $TwitchData.ApiKey | Should -Be "TestValue"
            }
        }
    }
}
