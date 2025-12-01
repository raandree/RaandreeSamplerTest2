# Memory Bank - Quick Reference

**Project**: RaandreeSamplerTest2  
**Type**: PowerShell Module (Sampler Framework)  
**Version**: 0.3.0-new1 (preview)  
**Status**: 🔴 Build Failing  

## 📂 Memory Bank Structure

All memory files are located in `memory-bank/`:

1. **projectBrief.md** - Project identity, purpose, scope, stakeholders
2. **productContext.md** - Why it exists, user experience, key features
3. **systemPatterns.md** - Architecture, design patterns, workflows
4. **techContext.md** - Technology stack, tools, dependencies
5. **activeContext.md** - Current focus, recent changes, known issues
6. **progress.md** - What works, what's left, completion metrics
7. **promptHistory.md** - All AI interactions logged chronologically

## 🎯 Quick Project Overview

### What It Is
Sample PowerShell module demonstrating modern module development with:
- Sampler framework for build automation
- GitVersion for semantic versioning
- Pester 5.x for testing
- Azure Pipelines for CI/CD
- Multi-platform support (Windows/Linux, PS 5.1/7+)

### Current Functions
- `Get-Something` - Demo with ShouldProcess ✅
- `Get-CurrentDateTime` - ISO 8601 formatter ✅
- `Get-OsVersionString` - OS version info ✅
- `Test-Is64BitOperatingSystem` - 64-bit check ❌ **BROKEN**

### Critical Issues (HIGH PRIORITY)
1. ❌ Test-Is64BitOperatingSystem implementation bug
2. ❌ Missing test file for Test-Is64BitOperatingSystem
3. ❌ Build failing (Exit Code: 1)

## 🚀 Common Commands

```powershell
# Install dependencies
.\build.ps1 -ResolveDependency

# Build module
.\build.ps1

# Run tests
.\build.ps1 -Tasks test

# Build and package
.\build.ps1 -Tasks pack

# Clean output
.\build.ps1 -Tasks clean
```

## 📁 Key Directory Structure

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

memory-bank/          # AI context files
```

## 🔧 Technology Stack

- **Framework**: Sampler 0.118.3
- **Build**: InvokeBuild 5.14.22 + ModuleBuilder 3.1.8
- **Testing**: Pester 5.7.1 (85% coverage threshold)
- **Versioning**: GitVersion 5.x (ContinuousDelivery mode)
- **CI/CD**: Azure Pipelines (multi-platform)
- **Min PowerShell**: 5.0

## 📊 Current Metrics

- **Functions**: 4 implemented, 3 working, 1 tested
- **Tests**: 3 of 4 test files exist
- **Coverage**: Unknown (build failing)
- **Build**: ❌ Failing
- **Documentation**: Good (except README minimal)

## 🎓 Key Learnings

1. **ModuleBuilder** auto-populates FunctionsToExport - source manifest can be empty
2. **GitVersion** calculates versions from git history and commit messages
3. **Public/Private** separation enforced by directory structure
4. **One function per file** pattern strictly followed
5. **Test structure** mirrors source directory layout

## 📝 Next Session Checklist

Before working on this project:
1. ✅ Read `memory-bank/activeContext.md` for current state
2. ✅ Check `memory-bank/progress.md` for known issues
3. ✅ Review `memory-bank/promptHistory.md` for recent changes
4. ✅ Update files after making changes

## 🔗 Important Files

- `build.yaml` - Build workflow configuration
- `GitVersion.yml` - Versioning strategy
- `azure-pipelines.yml` - CI/CD pipeline
- `CHANGELOG.md` - Release history
- `RequiredModules.psd1` - Build dependencies

## 💡 Design Decisions

- **Empty FunctionsToExport**: Let ModuleBuilder manage (Sampler pattern)
- **Main branch = preview**: Non-standard but intentional for test module
- **85% coverage**: Balance between quality and practicality
- **Multi-platform testing**: Ensure compatibility across environments

---

**Last Updated**: 2025-12-01  
**Memory Bank Version**: 1.0  
**Status**: Complete and ready for collaboration
