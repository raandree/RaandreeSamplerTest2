# System Patterns

## Architecture Overview

This module follows the **Sampler framework architecture** for PowerShell module development, which implements a clear separation of concerns and automated build process.

```
┌─────────────────────────────────────────────────────────────┐
│                     Source Files (source/)                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Public/    │  │   Private/   │  │    en-US/    │      │
│  │  Functions   │  │  Functions   │  │  Help Files  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│           ▼                 ▼                 ▼             │
│  ┌────────────────────────────────────────────────────┐    │
│  │         Module Manifest (.psd1)                    │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼ (build.ps1 + ModuleBuilder)
┌─────────────────────────────────────────────────────────────┐
│                    Built Module (output/)                   │
│  ┌────────────────────────────────────────────────────┐    │
│  │  RaandreeSamplerTest2/0.3.0/                      │    │
│  │    ├── RaandreeSamplerTest2.psd1 (manifest)       │    │
│  │    ├── RaandreeSamplerTest2.psm1 (merged module)  │    │
│  │    └── en-US/ (help files)                        │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## Directory Structure Pattern

### Source Structure
```
source/
├── RaandreeSamplerTest2.psd1     # Module manifest (source)
├── RaandreeSamplerTest2.psm1     # Root module (can be empty)
├── Public/                        # Exported functions
│   ├── Get-Something.ps1
│   ├── Get-CurrentDateTime.ps1
│   ├── Get-OsVersionString.ps1
│   └── Test-Is64BitOperatingSystem.ps1
├── Private/                       # Internal functions
│   └── Get-PrivateFunction.ps1
└── en-US/                        # Help files
    └── about_RaandreeSamplerTest2.help.txt
```

### Build Output Structure
```
output/
├── module/                       # Built modules
│   └── RaandreeSamplerTest2/
│       └── 0.3.0/               # Versioned output
├── RequiredModules/             # Build dependencies
└── testResults/                 # Test output files
```

### Test Structure
```
tests/
├── Unit/                        # Unit tests (mirror source)
│   ├── Public/
│   │   ├── Get-CurrentDateTime.tests.ps1
│   │   ├── Get-OsVersionString.tests.ps1
│   │   └── Get-Something.tests.ps1
│   └── Private/
│       └── Get-PrivateFunction.tests.ps1
└── QA/                          # Quality assurance tests
    └── module.tests.ps1
```

## Key Design Patterns

### 1. Function Organization Pattern

**Public Functions**: Exported to users, placed in `source/Public/`
- One function per file
- File name matches function name
- Complete comment-based help required
- Added to FunctionsToExport in manifest

**Private Functions**: Internal helpers, placed in `source/Private/`
- One function per file
- Not exported from module
- Can be called by public functions
- Still tested via unit tests

### 2. Module Building Pattern (ModuleBuilder)

**Build Process:**
1. Read all `.ps1` files from Public/ and Private/
2. Merge into single `.psm1` file
3. Update manifest with metadata
4. Copy help files
5. Create versioned output directory
6. Package as `.nupkg` for distribution

**Configuration:** `build.yaml`
- `BuiltModuleSubdirectory: module` - Output location
- `VersionedOutputDirectory: true` - Creates version folders
- `Encoding: UTF8` - Consistent encoding

### 3. Versioning Pattern (GitVersion)

**Version Calculation:**
- Main branch: `X.Y.Z` (stable)
- Feature branch: `X.Y.Z-feature-name.N`
- Pull request: `X.Y.Z-PR###.N`
- Hotfix: `X.Y.Z-fix.N`

**Version Sources:**
1. GitVersion calculates from git history
2. Passed to build as `ModuleVersion` environment variable
3. Updated in module manifest during build
4. Appears in output directory path

**Configuration:** `GitVersion.yml`
- `mode: ContinuousDelivery`
- Branch-specific tagging strategies
- Commit message parsing for version bumps

### 4. Testing Pattern (Pester 5.x)

**Test Organization:**
- Mirror source structure in tests/
- `.tests.ps1` suffix for test files
- Describe/It blocks for test cases
- Code coverage enabled

**Test Execution:**
- Run via `build.ps1 -Tasks test`
- Generates NUnit XML for Azure Pipelines
- Calculates code coverage
- Enforces 85% coverage threshold

**Configuration:** `build.yaml` Pester section
```yaml
Pester:
  OutputFormat: NUnitXML
  CodeCoverageThreshold: 85
```

### 5. CI/CD Pipeline Pattern (Azure Pipelines)

**Multi-Stage Pipeline:**

**Stage 1: Build**
- Install GitVersion
- Calculate version
- Build and package module
- Publish build artifact

**Stage 2: Test** (parallel jobs)
- Linux (Ubuntu, PowerShell Core)
- Windows PowerShell (Windows, PowerShell 5.1)
- Windows Core (Windows, PowerShell Core)
- Download build artifact
- Run tests with coverage
- Publish test results

**Stage 3: Publish** (manual/automated)
- GitHub release creation
- PowerShell Gallery publishing

## Component Relationships

### Function Call Flow
```
User
  └─> Get-Something (Public)
        ├─> Parameter validation
        ├─> ShouldProcess check
        └─> Get-PrivateFunction (Private)
              └─> Return data
```

### Build Flow
```
Commit → GitVersion → Environment Variable
                           ↓
Source Files → ModuleBuilder → Built Module
                           ↓
                      Test Execution → Results
                           ↓
                      Package (.nupkg)
```

### Module Loading Flow
```
Import-Module RaandreeSamplerTest2
  ├─> Load manifest (.psd1)
  ├─> Load merged module (.psm1)
  │     ├─> Private functions loaded (not exported)
  │     └─> Public functions loaded and exported
  └─> Module ready for use
```

## Critical Implementation Paths

### Adding a New Public Function

1. **Create function file**: `source/Public/New-Function.ps1`
2. **Add comment-based help**: Synopsis, Description, Examples, Parameters
3. **Implement function**: With [CmdletBinding()], proper parameters
4. **Create test file**: `tests/Unit/Public/New-Function.tests.ps1`
5. **Write tests**: Cover main scenarios and edge cases
6. **Build module**: Run `./build.ps1`
7. **Run tests**: Run `./build.ps1 -Tasks test`
8. **Update changelog**: Add to [Unreleased] section
9. **Commit**: Use conventional commit message (e.g., `feat: add New-Function`)

**Note**: ModuleBuilder automatically adds functions to FunctionsToExport

### Releasing a New Version

1. **Ensure all tests pass**: `./build.ps1 -Tasks test`
2. **Update CHANGELOG.md**: Move [Unreleased] items to new version section
3. **Commit changes**: `git commit -am "chore: prepare release"`
4. **Merge to main**: Create PR and merge
5. **Pipeline runs**: Azure Pipelines triggers automatically
6. **GitVersion calculates**: New version based on commits
7. **Module built**: On all platforms
8. **Tests run**: Multi-platform validation
9. **GitHub release**: Created automatically
10. **PSGallery publish**: Module published

## Design Decisions

### Why Sampler Framework?
- Standard in DSC Community
- Automated build and test workflows
- Consistent module structure
- Integrated tooling (ModuleBuilder, Pester, PSScriptAnalyzer)
- Best practices built-in

### Why GitVersion?
- Eliminates manual version management
- Ensures semantic versioning compliance
- Branch-based versioning strategies
- CI/CD integration
- Consistent version calculation

### Why Separate Public/Private?
- Clear API surface (only Public functions exported)
- Encapsulation of internal logic
- Easier testing (can unit test private functions)
- Better documentation (focus on public API)

### Why 85% Code Coverage?
- High enough to ensure quality
- Low enough to be achievable
- Industry-standard threshold
- Catches most untested code paths
