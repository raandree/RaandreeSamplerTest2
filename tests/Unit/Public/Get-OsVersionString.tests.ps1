BeforeAll {
    $script:dscModuleName = 'RaandreeSamplerTest2'

    Import-Module -Name $script:dscModuleName
}

AfterAll {
    # Unload the module being tested so that it doesn't impact any other tests.
    Get-Module -Name $script:dscModuleName -All | Remove-Module -Force
}

Describe Get-OsVersionString {
    Context 'When calling Get-OsVersionString' {
        It 'Should return a string' {
            $result = Get-OsVersionString
            $result | Should -BeOfType 'System.String'         
        }

        It 'Should not throw' {
            { Get-OsVersionString } | Should -Not -Throw
        }
    }
}

