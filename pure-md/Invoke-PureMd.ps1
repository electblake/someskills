<#
.SYNOPSIS
    Fetch web content as markdown via pure.md API.

.DESCRIPTION
    Downloads a URL through pure.md proxy and saves as markdown.
    Organizes output by source domain in references/<fqdn>/.

.PARAMETER Uri
    The URL to fetch.

.PARAMETER OutputDir
    Base output directory. Default: ./references

.PARAMETER Filename
    Output filename. If not specified, derived from content.

.PARAMETER ApiToken
    Optional pure.md API token for higher rate limits.

.PARAMETER Force
    Overwrite existing file without prompting.

.EXAMPLE
    .\Invoke-PureMd.ps1 -Uri "https://www.rfc-editor.org/rfc/rfc8878.html"

.EXAMPLE
    .\Invoke-PureMd.ps1 -Uri "https://example.com/doc.html" -Filename "DOC001_Example.md"

.NOTES
    Requires: powershell-yaml module (Install-Module powershell-yaml)
#>

#Requires -Modules powershell-yaml

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Uri,

    [Parameter()]
    [string]$OutputDir = "./references",

    [Parameter()]
    [string]$Filename,

    [Parameter()]
    [string]$ApiToken,

    [Parameter()]
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Extract FQDN from URI
$parsedUri = [System.Uri]$Uri
$fqdn = $parsedUri.Host

# Build output path
$domainDir = Join-Path $OutputDir $fqdn
if (-not (Test-Path $domainDir)) {
    New-Item -ItemType Directory -Path $domainDir -Force | Out-Null
    Write-Host "Created directory: $domainDir"
}

# Build pure.md proxy URL
$proxyUrl = "https://pure.md/$Uri"

# Prepare request parameters
$params = @{
    Uri = $proxyUrl
    Method = 'Get'
}
if ($ApiToken) {
    $params.Headers = @{ "x-puremd-api-token" = $ApiToken }
}

Write-Host "Fetching: $Uri"
Write-Host "Via: $proxyUrl"

# Fetch content using Invoke-RestMethod
try {
    $content = Invoke-RestMethod @params
} catch {
    Write-Error "Failed to fetch: $($_.Exception.Message)"
    exit 1
}

# Derive filename if not provided
if (-not $Filename) {
    $title = $null

    # Parse YAML frontmatter using powershell-yaml
    if ($content -match '^---\r?\n([\s\S]*?)\r?\n---') {
        $frontmatter = $Matches[1] | ConvertFrom-Yaml
        if ($frontmatter.title) {
            $title = $frontmatter.title
        }
    }

    # Fallback to markdown heading
    if (-not $title -and $content -match '(?m)^#\s+(.+)$') {
        $title = $Matches[1].Trim()
    }

    # Fallback to last path segment
    if (-not $title) {
        $title = $parsedUri.Segments[-1] -replace '\.[^.]+$', ''
        if (-not $title -or $title -eq '/') {
            $title = $fqdn
        }
    }

    # Extract ID from URL path (RFC, IEEE, etc.)
    $idPatterns = @{
        'rfc(\d+)' = 'RFC'
        'ieee[-_]?(\d+)' = 'IEEE'
        'iso[-_]?(\d+)' = 'ISO'
    }

    $id = $null
    foreach ($pattern in $idPatterns.Keys) {
        if ($Uri -match $pattern) {
            $id = $idPatterns[$pattern] + $Matches[1]
            break
        }
    }

    # Sanitize title for filename
    $safeTitle = $title -replace '[<>:"/\\|?*]', '' -replace '\s+', ' '
    $safeTitle = $safeTitle.Substring(0, [Math]::Min(80, $safeTitle.Length)).Trim()

    if ($id) {
        $Filename = "${id}_${safeTitle}.md"
    } else {
        $Filename = "${safeTitle}.md"
    }
}

# Ensure .md extension
if (-not $Filename.EndsWith(".md")) {
    $Filename = "$Filename.md"
}

$outputPath = Join-Path $domainDir $Filename

# Check if file exists
if ((Test-Path $outputPath) -and -not $Force) {
    Write-Host "`nFile already exists: $outputPath" -ForegroundColor Yellow
    $confirm = Read-Host "Overwrite? [y/N]"
    if ($confirm -notmatch '^[Yy]') {
        Write-Host "Skipped."
        exit 0
    }
}

# Write content
Set-Content -Path $outputPath -Value $content -Encoding UTF8
Write-Host "`nSaved: $outputPath" -ForegroundColor Green

# Return path for scripting
return $outputPath
