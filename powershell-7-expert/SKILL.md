---
name: powershell-7-expert
description: PowerShell and pwsh skill for scripts, commands, pipelines, automation, troubleshooting, and modern PowerShell 7 features. Specializes in cross-platform behavior, shell detection, Git Bash and MSYS2 compatibility, parallel processing, REST API integration, and modern PowerShell runtime patterns.
---

# PowerShell 7 Expert with Shell Detection

## Critical Shell Rule

- Always run shell commands with an explicit no-profile PowerShell invocation: `powershell -NoProfile -Command "<command>"`.
- If the initial shell has loaded the user's profile or emits profile startup errors, immediately switch subsequent commands to explicit `powershell -NoProfile`; do not keep using a profile-loaded shell.
- Preserve mise shims and project toolchain behavior; do not bypass mise-managed binaries when running PowerShell commands.

## Purpose
Provides expertise in modern PowerShell 7+ (PowerShell Core) for cross-platform automation with comprehensive shell detection and cross-shell compatibility guidance. Specializes in parallel processing, REST API integration, modern scripting patterns, shell environment detection, and seamless compatibility between PowerShell and Git Bash/MSYS2.

## When to Use
- Broad PowerShell scripting and automation
- Fixing `pwsh` commands and object pipelines
- Cross-platform automation (Windows, Linux, macOS)
- Parallel processing with ForEach-Object -Parallel
- REST API integrations
- Modern PowerShell scripting patterns
- Pipeline chain operators (&& ||)
- Ternary expressions and null coalescing
- SSH-based remoting
- JSON/YAML data manipulation
- Shell environment detection and adaptation
- Cross-shell compatibility (PowerShell vs Git Bash/MSYS2)
- Path handling across different shell environments
- Windows development with multiple shell environments

## Quick Start
**Invoke this skill when:**
- Writing or fixing PowerShell scripts
- Troubleshooting `pwsh` commands
- Using PowerShell 7+ specific features
- Implementing parallel processing
- Building REST API integrations
- Modernizing scripts from 5.1
- Detecting shell environment (PowerShell vs Git Bash/MSYS2)
- Building cross-shell compatible scripts
- Handling path format differences between shells
- Working in mixed shell environments on Windows

**Do NOT invoke when:**
- Legacy Windows PowerShell 5.1-only constraints (no PowerShell 7) -> call out limitations and avoid PS7-only features
- GUI development tasks -> out of scope for this skill
- Security hardening or policy configuration -> out of scope unless explicitly requested and grounded in references
- Reusable named solution patterns or capability lookups such as "multi-select menu" -> use `$powershell-patterns`
- PowerShell module lifecycle (install/import/discovery) → use `$powershell-modules-use`
- PowerShell module implementation or prototype scaffolding → use `$powershell-module-design`
- Cmdlet naming, verb selection, and semantic command design → use `$powershell-naming-conventions`

## Decision Framework
```text
PowerShell 7 Feature Selection?
├── Shell Detection
│   ├── PowerShell detection → Check $PSVersionTable, $env:PSModulePath
│   ├── Git Bash detection → Check $env:MSYSTEM, $(uname -s)
│   └── Cross-shell script → Detect and adapt behavior
├── Parallel Processing
│   ├── Simple iteration → ForEach-Object -Parallel
│   └── Complex workflows → Start-ThreadJob
├── API Integration
│   └── Invoke-RestMethod with modern options
├── Path Handling
│   ├── PowerShell paths → Join-Path, [System.IO.Path]
│   ├── Git Bash paths → Unix-style, cygpath conversion
│   └── Cross-shell paths → Environment-aware handling
├── Null Handling
│   ├── Default value → ?? operator
│   └── Conditional access → ?. operator
└── Pipeline Control
    └── && and || chain operators
```

## Core Workflows

### 1. Shell Detection and Adaptation
1. Detect current shell environment using reliable indicators
2. Adapt script behavior based on shell type
3. Handle path format differences appropriately
4. Use shell-specific features when available
5. Provide fallbacks for cross-shell compatibility
6. Test in all target shell environments

### 2. Parallel Processing
1. Identify parallelizable workload
2. Use ForEach-Object -Parallel
3. Set -ThrottleLimit appropriately
4. Handle thread-safe data access
5. Aggregate results
6. Handle errors from parallel runs

### 3. REST API Integration
1. Construct request parameters
2. Handle authentication (Bearer, OAuth)
3. Use Invoke-RestMethod
4. Parse JSON response
5. Implement pagination
6. Add retry logic for failures

### 4. Cross-Platform Script
1. Avoid Windows-specific paths
2. Use $PSVersionTable and $IsLinux/$IsWindows
3. Handle path separators correctly
4. Test on all target platforms
5. Use compatible modules
6. Document platform requirements

## Best Practices
- Use ternary operator for concise conditionals
- Leverage null-coalescing for defaults
- Use ForEach-Object -Parallel for CPU-bound tasks
- Prefer SSH remoting over WinRM for cross-platform
- Use Join-Path for cross-platform paths
- Test on all target operating systems
- Detect shell environment before path operations
- Use $env:PSModulePath for reliable PowerShell detection
- Use $env:MSYSTEM for Git Bash/MSYS2 detection
- Avoid hardcoded path formats - detect and adapt
- Test scripts in both PowerShell and target shells
- Document shell requirements clearly

## Shell Detection Patterns

### PowerShell Detection (Most Reliable)
```powershell
function Test-PowerShellContext {
    return ($null -ne $PSVersionTable)
}

function Get-PowerShellInfo {
    if ($PSVersionTable) {
        return @{
            IsPS = $true
            Version = $PSVersionTable.PSVersion
            Edition = $PSVersionTable.PSEdition
            Platform = if ($IsWindows) { "Windows" } elseif ($IsLinux) { "Linux" } else { "macOS" }
        }
    }
    return @{ IsPS = $false }
}
```

### Git Bash / MSYS2 Detection
```bash
detect_shell_environment() {
    if [ -n "$MSYSTEM" ]; then
        echo "git-bash-$MSYSTEM"
    elif [ -n "$PSModulePath" ]; then
        echo "powershell"
    elif [ -n "$WSL_DISTRO_NAME" ]; then
        echo "wsl"
    else
        echo "unix-$(uname -s)"
    fi
}
```

### Cross-Shell Compatible Path Handling
```powershell
function Get-NormalizedPath {
    param([string]$Path)

    if (Test-PowerShellContext) {
        if (Test-Path $Path) {
            return (Resolve-Path $Path).Path
        }
        return [System.IO.Path]::GetFullPath($Path)
    }

    Write-Warning "Cross-shell path handling - verify path format"
    return $Path -replace '\\', '/'
}
```

## Environment Variable Compatibility

| Purpose | PowerShell | Git Bash/MSYS2 | Cross-Shell Function |
| --- | --- | --- | --- |
| Username | `$env:USERNAME` | `$USER` | `$env:USERNAME ?? $env:USER` |
| Home Directory | `$env:USERPROFILE` | `$HOME` | `$env:USERPROFILE ?? $env:HOME` |
| Temp Directory | `$env:TEMP` | `/tmp` | `$env:TEMP ?? '/tmp'` |
| Shell Detection | `$env:PSModulePath` | `$env:MSYSTEM` | Check both |

## Anti-Patterns
| Anti-Pattern | Problem | Correct Approach |
| --- | --- | --- |
| Hardcoded backslashes | Breaks on Linux/macOS | Join-Path or `/` |
| Windows-only cmdlets | Cross-platform failure | Check availability |
| Over-parallelization | Thread overhead | Tune `ThrottleLimit` |
| Ignoring `$Error` | Silent failures | Proper error handling |
| Assuming WinRM | Not cross-platform | SSH remoting |
| Assuming shell type | Script fails in wrong environment | Detect shell first |
| Hardcoded path formats | Fails across shells | Environment-aware paths |
| Ignoring `MSYSTEM` | Git Bash compatibility issues | Check `$env:MSYSTEM` |
| Mixed shell aliases | Different behavior per shell | Use full cmdlet names |

## References

- `references/ps7_quickstart.md`
- `references/powershell-code-guidelines.md`
- `references/powershell-design-guidelines.md`
- `references/powershell-verbs-reference.md`
- `references/dsc_patterns.md`
- `../../../powershell-patterns/references/patterns/*.md` for the separate PowerShell Patterns plugin library when the task matches a named pattern
- `../../references/powershell-differences-on-non-windows-platforms.md` for Linux/macOS behavior, remoting, aliases, cmdlet availability, and XDG path defaults

## Related Workflows

- Use `$powershell-patterns` for named reusable solution patterns such as menus, dialogs, and other implementation idioms.
- Use `$powershell-pattern-creator` to add or revise a curated pattern reference from an official sample or provided markdown.
