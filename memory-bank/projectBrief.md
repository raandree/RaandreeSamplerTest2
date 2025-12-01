# RaandreeSamplerTest2 - Project Brief

## Project Identity

**Name:** RaandreeSamplerTest2  
**Owner:** raandree  
**Repository:** github.com/raandree/RaandreeSamplerTest2  
**Type:** PowerShell Module  
**Current Version:** 0.3.0-new1 (preview)  
**Status:** Active Development  

## Core Purpose

This is a sample PowerShell module built using the **Sampler** framework and Plaster scaffolding template. It serves as a learning and testing ground for PowerShell module development best practices, CI/CD pipelines, and automated versioning with GitVersion.

## Primary Objectives

1. **Module Development Template**: Provide a working example of a properly structured PowerShell module following DSC Community standards
2. **CI/CD Integration**: Demonstrate automated build, test, and publish workflows using Azure Pipelines
3. **Automated Versioning**: Implement GitVersion for semantic versioning based on git history
4. **Testing Framework**: Showcase comprehensive unit and quality testing with Pester
5. **Code Quality**: Enforce best practices through PSScriptAnalyzer and automated quality gates

## Scope

### In Scope
- Basic utility functions for OS information retrieval
- Date/time formatting functions
- Automated build and packaging with ModuleBuilder
- Unit testing with Pester 5.x
- Code coverage reporting (85% threshold)
- Automated changelog management
- GitHub integration for releases
- Multi-platform testing (Linux, Windows PowerShell, Windows Core)

### Out of Scope
- Production-critical functionality (this is a sample/test module)
- DSC Resources (commented out in structure)
- Complex business logic
- External service integrations

## Success Criteria

1. **Build System**: Automated builds produce versioned module packages
2. **Testing**: All tests pass with ≥85% code coverage
3. **Quality**: PSScriptAnalyzer rules pass with no violations
4. **Documentation**: All public functions have comment-based help
5. **Publishing**: Automated publishing to PowerShell Gallery on releases
6. **Version Management**: GitVersion correctly calculates semantic versions

## Key Stakeholders

**Primary Maintainer:** raandree (r.andree@live.com)  
**Framework:** Sampler (DSC Community)  
**Target Users:** PowerShell developers learning module development

## Technical Constraints

- **Minimum PowerShell Version:** 5.0 (Windows PowerShell compatibility)
- **Framework:** Sampler 0.118.3
- **Build Tool:** InvokeBuild 5.14.22
- **Testing:** Pester 5.7.1
- **Version Control:** GitVersion 5.x
- **CI/CD Platform:** Azure Pipelines

## Current Focus

Building out sample utility functions with proper testing, documentation, and CI/CD integration to serve as a reference implementation.
