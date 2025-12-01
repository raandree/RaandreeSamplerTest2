# Changelog for RaandreeSamplerTest2

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Created Memory Bank documentation for future collaborative work.
- Added complete comment-based help to `Test-Is64BitOperatingSystem`.
- Unit test for `Test-Is64BitOperatingSystem`.

### Fixed

- Fixed `Test-Is64BitOperatingSystem` implementation - now correctly returns boolean value instead of trying to access properties on boolean.

## [0.2.0] - 2025-08-13

### Added

- New public function `Get-CurrentDateTime` that returns the current date and time in ISO 8601 format.
- Unit test for `Get-CurrentDateTime` in `tests/Unit/Public/Get-CurrentDateTime.tests.ps1`.

### Changed

- For changes in existing functionality.

### Deprecated

- For soon-to-be removed features.

### Removed

- For now removed features.

### Fixed

- For any bug fix.

### Security

- In case of vulnerabilities.
