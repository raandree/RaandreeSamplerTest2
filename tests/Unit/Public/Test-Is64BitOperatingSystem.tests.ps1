# Unit test for Test-Is64BitOperatingSystem
Describe 'Test-Is64BitOperatingSystem' {
    It 'Returns a boolean value' {
        $result = Test-Is64BitOperatingSystem
        $result | Should -BeOfType [System.Boolean]
    }

    It 'Should not throw an error' {
        { Test-Is64BitOperatingSystem } | Should -Not -Throw
    }

    It 'Returns a boolean value' {
        $result = Test-Is64BitOperatingSystem
        $result | Should -BeOfType [System.Boolean]
    }
    
    It 'Returns True on 64-bit operating system' {
        # This test assumes the build system is 64-bit (which is typical for modern systems)
        $result = Test-Is64BitOperatingSystem
        $result | Should -Be ([System.Environment]::Is64BitOperatingSystem)
    }
}
