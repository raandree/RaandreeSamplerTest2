# Technical Context

## Technology Stack

### Core PowerShell
- **PowerShell Version**: 5.0+ (minimum), tested on 5.1 and 7.x
- **Target Platforms**: Windows (PowerShell 5.1, PowerShell 7+), Linux (PowerShell 7+)
- **Module Type**: Script module (.psm1)
- **Manifest Format**: PowerShell Data File (.psd1)

### Build and Development Tools

#### Primary Framework
- **Sampler** (v0.118.3): Module scaffolding and build automation framework
  - Purpose: Provides InvokeBuild tasks for building, testing, and publishing
  - Documentation: https://github.com/gaelcolas/Sampler

#### Build System
- **InvokeBuild** (v5.14.22): Build automation in PowerShell
  - Purpose: Task execution engine
  - Configuration: `build.yaml` defines workflows and tasks
  - Entry Point: `build.ps1` script

- **ModuleBuilder** (v3.1.8): Module compilation and packaging
  - Purpose: Merges source files into single module
  - Creates versioned output directories
  - Updates manifest during build

#### Version Management
- **GitVersion** (v5.x): Automated semantic versioning
  - Configuration: `GitVersion.yml`
  - Mode: ContinuousDelivery
  - Integration: Azure Pipelines GitVersion task
  - Output: Environment variables (GitVersion.SemVer, etc.)

#### Testing Framework
- **Pester** (v5.7.1): PowerShell testing framework
  - Test Discovery: `*.tests.ps1` files
  - Output Format: NUnitXML
  - Code Coverage: Enabled with 85% threshold
  - Configuration: In `build.yaml` Pester section

#### Code Quality
- **PSScriptAnalyzer** (v1.24.0): Static code analysis
  - Runs as part of QA tests
  - Enforces PowerShell best practices
  - Configuration: Default rules

#### Dependency Management
- **PSDepend** (v0.3.8): PowerShell module dependency management
- **Microsoft.PowerShell.PSResourceGet** (v1.0.1): Module installation
- **Configuration**: `RequiredModules.psd1`

#### Changelog Management
- **ChangelogManagement** (v3.1.0): Automated changelog updates
  - Format: Keep a Changelog
  - Integration: Build tasks for release notes
  - File: `CHANGELOG.md`

#### GitHub Integration
- **Sampler.GitHubTasks** (v0.3.4): GitHub release automation
  - Creates releases
  - Uploads artifacts
  - Updates changelog
  - Configuration: `build.yaml` GitHubConfig section

#### Other Dependencies
- **Plaster** (v1.1.4): Template engine (used for initial scaffolding)
- **PowerShellForGitHub** (v0.17.0): GitHub API interaction
- **powershell-yaml** (v0.4.12): YAML parsing
- **NTFSSecurity** (v4.2.6): File system permissions (if needed)

## Development Environment Setup

### Prerequisites
```powershell
# Windows PowerShell 5.1 or PowerShell 7+
$PSVersionTable

# Git for version control
git --version

# .NET SDK (for GitVersion)
dotnet --version
```

### Initial Setup
```powershell
# Clone repository
git clone https://github.com/raandree/RaandreeSamplerTest2.git
cd RaandreeSamplerTest2

# Restore dependencies (downloads all required modules)
.\build.ps1 -ResolveDependency

# Build module
.\build.ps1

# Run tests
.\build.ps1 -Tasks test
```

### Directory Configuration

**Output Directory**: `output/`
- Created during build
- Contains compiled module and test results
- Excluded from git (in .gitignore)

**Source Directory**: `source/`
- Contains module source files
- Version-controlled
- Manually edited

**Tests Directory**: `tests/`
- Unit tests in `Unit/`
- QA tests in `QA/`
- Mirrors source structure

## Build Configuration

### build.yaml Structure

**ModuleBuilder Section:**
```yaml
BuiltModuleSubdirectory: module      # Output to output/module/
CopyPaths: [en-US]                   # Copy help files
Encoding: UTF8                       # Consistent encoding
VersionedOutputDirectory: true       # Create version folders
```

**Build Workflows:**
- `.` (default): build → test
- `build`: Clean, build module, create changelog
- `test`: Run Pester tests, check coverage
- `pack`: Build + create .nupkg package
- `publish`: Publish to GitHub and PSGallery

**Pester Configuration:**
```yaml
OutputFormat: NUnitXML               # For Azure Pipelines
CodeCoverageThreshold: 85            # Minimum coverage
```

**Task Sources:**
```yaml
ModuleBuildTasks:
  Sampler: '*.build.Sampler.ib.tasks'
  Sampler.GitHubTasks: '*.ib.tasks'
```

### GitVersion Configuration

**File**: `GitVersion.yml`

**Key Settings:**
- `mode: ContinuousDelivery` - Increments on each commit
- `next-version: 0.0.1` - Starting version
- Branch strategies for main, feature, hotfix, PR

**Version Bump Triggers:**
- `major-version-bump-message`: `(breaking change|breaking|major)`
- `minor-version-bump-message`: `(adds?|features?|minor)`
- `patch-version-bump-message`: `(fix|patch)`
- `no-bump-message`: `+semver: (none|skip)`

**Branch Configurations:**
- `main`: No tag (stable releases)
- `feature/*`: `feature-name` tag, minor increment
- `hotfix/*`: `fix` tag, patch increment
- `pull-request`: `PR` tag with PR number

## CI/CD Platform

### Azure Pipelines Configuration

**File**: `azure-pipelines.yml`

**Trigger Configuration:**
```yaml
trigger:
  branches: [main]
  paths: 
    exclude: [CHANGELOG.md]  # Don't trigger on changelog-only changes
  tags:
    include: ["v*"]
    exclude: ["*-*"]         # Only trigger on stable tags
```

**Variables:**
```yaml
buildFolderName: output
buildArtifactName: output
testResultFolderName: testResults
defaultBranch: main
Agent.Source.Git.ShallowFetchDepth: 0  # Full git history for GitVersion
```

**Stages:**

1. **Build** (Ubuntu)
   - Install GitVersion
   - Calculate version
   - Build and package module
   - Publish artifact

2. **Test** (Multi-platform parallel)
   - Linux (ubuntu-latest, PowerShell 7.x)
   - Windows PowerShell (windows-latest, PowerShell 5.1)
   - Windows Core (windows-latest, PowerShell 7.x)
   - Download build artifact
   - Run tests
   - Publish test results and coverage

3. **Publish** (Conditional)
   - Create GitHub release
   - Publish to PowerShell Gallery

## Technical Constraints

### PowerShell Version Support
- **Minimum**: PowerShell 5.0
- **Tested On**: 5.1, 7.5.4
- **Compatibility**: Must work on both Windows PowerShell and PowerShell Core

### Platform Support
- **Primary**: Windows
- **Secondary**: Linux (via PowerShell Core)
- **Not Supported**: macOS (not tested)

### Module Limitations
- No binary cmdlets (all script-based)
- No DSC resources (structure supports but none implemented)
- UTF8 encoding required for all files
- No external dependencies (no RequiredModules)

### Build System Requirements
- Git repository with full history (for GitVersion)
- Internet access (for dependency download)
- PowerShell execution policy allowing scripts
- Write permissions to output directory

## File Encodings
- **Source Files**: UTF-8
- **Module Manifest**: UTF-8
- **Built Module**: UTF-8
- **CHANGELOG**: UTF-8

## Tool Usage Patterns

### Common Build Commands
```powershell
# Full build
.\build.ps1

# Build with dependency resolution
.\build.ps1 -ResolveDependency

# Run tests only
.\build.ps1 -Tasks test

# Build and package
.\build.ps1 -Tasks pack

# Clean output
.\build.ps1 -Tasks clean
```

### VS Code Tasks
```json
// Available in tasks.json
- "build": Runs ./build.ps1
- "test": Runs ./build.ps1 -AutoRestore -Tasks test
```

### Direct Test Execution
```powershell
# Run Pester directly (after build)
Import-Module Pester
Invoke-Pester -Path ./tests
```

## Dependencies and Versions

### Required at Build Time
```powershell
# From RequiredModules.psd1
InvokeBuild         = 'latest'  # (5.14.22)
PSScriptAnalyzer    = 'latest'  # (1.24.0)
Pester              = 'latest'  # (5.7.1)
ModuleBuilder       = 'latest'  # (3.1.8)
ChangelogManagement = 'latest'  # (3.1.0)
Sampler             = 'latest'  # (0.118.3)
Sampler.GitHubTasks = 'latest'  # (0.3.4)
```

### Runtime Dependencies
- None (module has no RequiredModules in manifest)

### Platform-Specific Notes
- **Windows**: Fully supported on PowerShell 5.1 and 7+
- **Linux**: Supported on PowerShell 7+
- **GitVersion**: Requires .NET SDK on build machine
