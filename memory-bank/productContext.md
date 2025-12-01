# Product Context

## Purpose and Vision

RaandreeSamplerTest2 exists as a **reference implementation** and **learning resource** for PowerShell module developers. It demonstrates the complete lifecycle of a professional PowerShell module from scaffolding to publishing.

## Problem Statement

Many PowerShell developers struggle with:
- Setting up proper module structure following community standards
- Implementing automated build and test pipelines
- Managing semantic versioning correctly
- Writing comprehensive tests with good coverage
- Publishing modules to PowerShell Gallery
- Maintaining quality documentation
- Following DSC Community best practices

## Solution

This module provides a **working example** that developers can study, fork, and adapt. It demonstrates:
- Modern module structure (Public/Private function separation)
- Sampler framework integration for automated builds
- GitVersion for semantic versioning automation
- Pester 5.x testing patterns
- Azure Pipelines multi-platform testing
- Automated changelog management
- GitHub release integration
- PowerShell Gallery publishing workflow

## User Experience Goals

### For Module Developers Learning
- **Clarity**: Easy to understand structure and patterns
- **Completeness**: Full working example with all components
- **Documentation**: Well-commented code and comprehensive help
- **Best Practices**: Follows DSC Community and PowerShell standards

### For the Module Functions Themselves
- **Simplicity**: Simple utility functions that are easy to understand
- **Reliability**: Tested functions that work cross-platform
- **Consistency**: Uniform parameter naming and behavior
- **Help Quality**: Complete comment-based help for all public functions

## Key Features

### Public Functions (Exported)
1. **Get-Something** - Sample function demonstrating parameter validation, ShouldProcess, and private function usage
2. **Get-CurrentDateTime** - Returns ISO 8601 formatted current date/time
3. **Get-OsVersionString** - Returns OS version information string
4. **Test-Is64BitOperatingSystem** - Checks if OS is 64-bit

### Private Functions (Internal)
1. **Get-PrivateFunction** - Sample internal helper function

### Build & Test Features
- Automated module building with ModuleBuilder
- Multi-stage Azure Pipelines (Build, Test, Publish)
- Code coverage tracking with 85% threshold
- Cross-platform testing (Linux, Windows PowerShell, Windows Core)
- Automated changelog updates
- GitHub release creation

## How It Should Work

### Development Workflow
1. Developer adds/modifies functions in `source/Public/` or `source/Private/`
2. Developer adds corresponding tests in `tests/Unit/`
3. Developer commits with conventional commit message
4. GitVersion calculates next version based on commit
5. Build script compiles module to `output/module/`
6. Tests run with coverage analysis
7. On success, module is packaged as .nupkg

### Release Workflow
1. Changes merged to main branch
2. Azure Pipeline triggered
3. GitVersion calculates release version
4. Module built and tested on multiple platforms
5. Changelog updated automatically
6. GitHub release created
7. Module published to PowerShell Gallery

### Developer Usage
```powershell
# Install the module
Install-Module -Name RaandreeSamplerTest2

# Use the functions
Get-CurrentDateTime
Get-OsVersionString
Get-Something -Data "test input"
Test-Is64BitOperatingSystem
```

## Value Proposition

**For Learning**: Complete, working reference implementation of modern PowerShell module development  
**For Quality**: Demonstrates testing, coverage, and quality gate enforcement  
**For Automation**: Shows full CI/CD pipeline from commit to publish  
**For Standards**: Follows DSC Community and PowerShell best practices
