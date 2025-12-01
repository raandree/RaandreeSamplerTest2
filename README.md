# RaandreeSamplerTest2

[![Build Status](https://dev.azure.com/raandree/RaandreeSamplerTest2/_apis/build/status/RaandreeSamplerTest2-CI?branchName=main)](https://dev.azure.com/raandree/RaandreeSamplerTest2/_build/latest?definitionId=1&branchName=main)

A sample PowerShell module demonstrating modern module development practices using the Sampler framework.

## Overview

This module serves as a **learning resource** and **reference implementation** for PowerShell module developers. It showcases:

- **Sampler Framework**: Complete build automation and scaffolding
- **GitVersion**: Automated semantic versioning from git history
- **Pester 5.x**: Comprehensive testing with 100% code coverage
- **Azure Pipelines**: Multi-platform CI/CD (Linux, Windows PowerShell, Windows Core)
- **PSScriptAnalyzer**: Code quality enforcement
- **ModuleBuilder**: Automated module compilation and packaging

## Project Purpose

This is a **sample/test module** built to demonstrate best practices for:

1. Properly structured PowerShell modules following DSC Community standards
2. Automated build, test, and publish workflows
3. Semantic versioning based on conventional commits
4. Comprehensive unit testing with coverage reporting
5. Multi-platform compatibility testing
6. Automated changelog management
7. GitHub release integration

## Features

### Public Functions

- **Get-Something** - Sample function demonstrating parameter validation and ShouldProcess
- **Get-CurrentDateTime** - Returns current date/time in ISO 8601 format
- **Get-OsVersionString** - Returns operating system version information
- **Test-Is64BitOperatingSystem** - Checks if the OS is 64-bit

### Build & Test Features

- ✅ Automated module building with ModuleBuilder
- ✅ Multi-stage Azure Pipelines (Build, Test, Publish)
- ✅ Code coverage tracking with 85% threshold
- ✅ Cross-platform testing (Linux, Windows PowerShell, Windows Core)
- ✅ Automated changelog updates
- ✅ GitHub release creation

## Getting Started

### Prerequisites

- PowerShell 5.0 or higher (Windows PowerShell or PowerShell Core)
- Git for version control
- .NET SDK (for GitVersion during build)

### Installation

```powershell
# Install from PowerShell Gallery (when published)
Install-Module -Name RaandreeSamplerTest2

# Or clone and build locally
git clone https://github.com/raandree/RaandreeSamplerTest2.git
cd RaandreeSamplerTest2
.\build.ps1 -ResolveDependency
```

### Usage Examples

```powershell
# Import the module
Import-Module RaandreeSamplerTest2

# Get current date/time in ISO 8601 format
Get-CurrentDateTime
# Output: 2025-12-01T14:23:45

# Check OS version
Get-OsVersionString
# Output: Version: 10.0.19045.0, Platform: Win32NT, Service Pack:

# Check if OS is 64-bit
Test-Is64BitOperatingSystem
# Output: True

# Use the sample function
Get-Something -Data "Hello, World!"
# Output: Hello, World!
```

## Development

### Building the Module

```powershell
# Install build dependencies
.\build.ps1 -ResolveDependency

# Build the module
.\build.ps1

# Run tests
.\build.ps1 -Tasks test

# Build and package
.\build.ps1 -Tasks pack

# Clean output
.\build.ps1 -Tasks clean
```

### Project Structure

```
source/               # Source code
  ├── Public/        # Exported functions
  ├── Private/       # Internal functions
  └── en-US/         # Help files

tests/                # Mirror of source
  ├── Unit/          # Unit tests
  └── QA/            # Quality tests

output/               # Build output (excluded from git)
  ├── module/        # Built module
  └── testResults/   # Test reports
```

### Quality Gates

All builds must pass:

- ✅ All Pester tests passing
- ✅ Code coverage ≥ 85%
- ✅ PSScriptAnalyzer rules compliance
- ✅ Comment-based help for all public functions
- ✅ Unit test for every function
- ✅ Updated CHANGELOG.md

## Versioning

This project uses [GitVersion](https://gitversion.net/) for automated semantic versioning:

- **Main branch**: Stable releases (e.g., `0.3.0`)
- **Feature branches**: Preview versions (e.g., `0.3.0-feature-name.1`)
- **Pull requests**: PR versions (e.g., `0.3.0-PR123.1`)

Version bumps are determined by commit messages:
- `feat:` or `minor` → Minor version bump
- `fix:` or `patch` → Patch version bump
- `breaking` or `major` → Major version bump

## Contributing

This is a sample/learning module, but contributions that improve the demonstration of best practices are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes following the established patterns
4. Ensure all tests pass and code coverage ≥ 85%
5. Update CHANGELOG.md with your changes
6. Commit using conventional commit messages
7. Push to your branch and open a Pull Request

## CI/CD Pipeline

The Azure Pipelines workflow includes:

1. **Build Stage**: GitVersion calculation, module build, artifact publishing
2. **Test Stage**: Multi-platform parallel testing
   - Ubuntu (PowerShell Core)
   - Windows (PowerShell 5.1)
   - Windows (PowerShell Core)
3. **Publish Stage**: GitHub releases and PowerShell Gallery publishing

## Technology Stack

- **Framework**: [Sampler](https://github.com/gaelcolas/Sampler) 0.118.3
- **Build**: InvokeBuild 5.14.22 + ModuleBuilder 3.1.8
- **Testing**: Pester 5.7.1
- **Versioning**: GitVersion 5.x
- **CI/CD**: Azure Pipelines
- **Quality**: PSScriptAnalyzer 1.24.0

## Resources

- [Sampler Documentation](https://github.com/gaelcolas/Sampler)
- [GitVersion Documentation](https://gitversion.net/)
- [Pester Documentation](https://pester.dev/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)

## License

This project is for educational and demonstration purposes.

## Author

**raandree** (r.andree@live.com)

## Acknowledgments

- Built with [Sampler](https://github.com/gaelcolas/Sampler) by Gael Colas and the DSC Community
- Generated using Plaster templates
