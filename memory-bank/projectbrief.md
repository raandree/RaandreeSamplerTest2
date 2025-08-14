# Project Brief - RaandreeSamplerTest2

## Overview
RaandreeSamplerTest2 is a PowerShell module built using the Sampler framework. It provides utility functions for getting system information and datetime data.

## Core Requirements
- **Module Type**: PowerShell Module
- **Framework**: Sampler (PowerShell module development framework)
- **Testing**: Pester 5.x for unit tests
- **Quality**: PSScriptAnalyzer for code quality
- **Build System**: InvokeBuild with PowerShell scripts

## Primary Goals
1. Provide reliable utility functions for system information
2. Maintain high code quality standards (85% test coverage)
3. Follow PowerShell best practices
4. Ensure comprehensive testing with Pester

## Key Functions
- `Get-CurrentDateTime`: Returns current date/time in ISO 8601 format
- `Get-OsVersionString`: Returns OS version information
- `Get-Something`: Sample function demonstrating advanced PowerShell features
- `Get-PrivateFunction`: Internal/private function used by public functions

## Quality Standards
- All functions must pass PSScriptAnalyzer
- Unit tests required for all public functions
- 85% code coverage minimum
- Comprehensive help documentation required
