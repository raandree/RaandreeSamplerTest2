# Unit test for Get-CurrentDateTime
Describe 'Get-CurrentDateTime' {
    It 'Returns a valid ISO 8601 date-time string' {
        $result = Get-CurrentDateTime
        $pattern = '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$'
        $result | Should -Match $pattern
    }
}
