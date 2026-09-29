# PowerShell Modules Official Sources

Local research bundle:

- `.agents/references/powershell-modules/2026-05-03/` from the repository root

Official source URLs mirrored into the bundle:

- `https://learn.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershellget-3.x`
- `https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget/install-psresource?view=powershellget-3.x`
- `https://learn.microsoft.com/en-us/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x`
- `https://www.powershellgallery.com/packages/SQLite/2.0`

Key takeaways for the skill:

- `Install-Module` downloads modules from a repository and does not import them automatically.
- `Install-PSResource` is the newer package-management path and also does not import automatically.
- PowerShell Gallery package pages can expose multiple install flows, including Install Module, Install PSResource, Azure Automation, and manual download.
- `Get-PSRepository`, `Get-InstalledModule`, and `Get-InstalledPSResource` are useful before guessing the install state.
