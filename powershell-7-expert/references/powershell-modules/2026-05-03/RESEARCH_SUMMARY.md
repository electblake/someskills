# Research Summary

- Research Date: `2026-05-03`
- Official Version: Microsoft Learn PowerShellGet and PSResourceGet pages mirrored on `2026-05-03`
- Key Findings:
  - `Install-Module` downloads modules from a repository and does not import them automatically.
  - `Install-PSResource` is the newer package-management path and also does not import the module automatically.
  - PowerShell Gallery package pages can expose multiple install surfaces, including Install Module, Install PSResource, Azure Automation, and manual download.
  - `Get-PSRepository`, `Get-InstalledModule`, and `Get-InstalledPSResource` are useful before choosing an install path.
- Compatibility Notes:
  - Prefer the install surface that matches the user's installed toolchain and the module's gallery instructions.
  - Use `Import-Module` after install or open a new session before assuming the module is loaded.
