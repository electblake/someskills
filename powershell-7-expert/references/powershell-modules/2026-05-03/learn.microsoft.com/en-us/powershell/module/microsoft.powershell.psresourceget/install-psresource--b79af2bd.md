<!--
source: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget/install-psresource?view=powershellget-3.x
retrieved: 2026-05-04T00:01:18.271016+00:00
final_url: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget/install-psresource?view=powershellget-3.x
content_type: text/markdown
-->

---
layout: Reference
monikers:
- powershellget-3.x
defaultMoniker: powershellget-3.x
versioningType: Ranged
title: Install-PSResource (Microsoft.PowerShell.PSResourceGet) - PowerShell | Microsoft Learn
canonicalUrl: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget/install-psresource?view=powershellget-3.x
config_moniker_range: powershellget-3.x
uid: Microsoft.PowerShell.PSResourceGet.Install-PSResource
module: Microsoft.PowerShell.PSResourceGet
description: "This cmdlet installs resources from a registered repository to an installation path on a machine. By default, the cmdlet doesn't return any object. Other parameters allow you to specify the repository, scope, and version for a resource, and suppress license prompts. This cmdlet combines the functions of the Install-Module and Install-Script cmdlets from PowerShellGet v2. Install-PSResource doesn't load the newly installed module into the current session. You must import the new version or start a new session to use the updated module. For more information, see Import-Module.  Note Install-PSResource doesn't install dependent resources from repositories that use the NuGet v3 protocol. You must install the dependent resources individually. We intend to add this feature in a future release.  "
breadcrumb_path: /powershell/gallery/breadcrumb/toc.json
feedback_system: OpenSource
feedback_help_link_url: https://learn.microsoft.com/powershell/scripting/community/community-support
feedback_help_link_type: ask-the-community
author: sdwheeler
manager: jasongroce
ms.author: sewhee
ms.devlang: powershell
ms.service: powershell
ms.tgt_pltfr: windows, macos, linux
toc_preview: true
uhfHeaderId: MSDocsHeader-Powershell
feedback_product_url: https://github.com/powershell/psresourceget/issues/new
ms.subservice: cmdlets
ms.topic: reference
products:
- https://authoring-docs-microsoft.poolparty.biz/devrel/56936876-97d9-45cc-ad1b-9d63320447c8
- https://authoring-docs-microsoft.poolparty.biz/devrel/8bce367e-2e90-4b56-9ed5-5e4e9f3a2dc3
document type: cmdlet
external help file: Microsoft.PowerShell.PSResourceGet.dll-Help.xml
HelpUri: https://learn.microsoft.com/powershell/module/microsoft.powershell.psresourceget/install-psresource?view=powershellget-3.x&WT.mc_id=ps-gethelp
Module Name: Microsoft.PowerShell.PSResourceGet
ms.custom: 1.2.0-p5
ms.date: 2025-12-10T00:00:00.0000000Z
PlatyPS schema version: 2024-05-01T00:00:00.0000000Z
locale: en-us
document_id: e013049f-f90d-1acc-a387-b02c31c6efd2
document_version_independent_id: 556098ad-1f6a-66b6-99bd-15d2327fc912
updated_at: 2025-12-11T23:08:00.0000000Z
original_content_git_url: https://github.com/MicrosoftDocs/powershell-docs-psget/blob/live/powershell-gallery/powershellget-3.x/Microsoft.PowerShell.PSResourceGet/Install-PSResource.md
gitcommit: https://github.com/MicrosoftDocs/powershell-docs-psget/blob/fad3a5764cdf9aaf770970984e410baafc8637b7/powershell-gallery/powershellget-3.x/Microsoft.PowerShell.PSResourceGet/Install-PSResource.md
git_commit_id: fad3a5764cdf9aaf770970984e410baafc8637b7
default_moniker: powershellget-3.x
site_name: Docs
depot_name: MSDN.powershell-gallery
in_right_rail: h2h3
page_type: powershell
page_kind: command
toc_rel: ../powershellget/toc.json
asset_id: module/microsoft.powershell.psresourceget/install-psresource
moniker_range_name: a3d63f4e22b91eefff22c698db89a949
monikers:
- powershellget-3.x
item_type: Content
source_path: powershell-gallery/powershellget-3.x/Microsoft.PowerShell.PSResourceGet/Install-PSResource.md
cmProducts: []
platformId: 031d21b5-fc49-4e3d-7ae1-45325b076677
---

# Install-PSResource

- Module:
    - [Microsoft.PowerShell.PSResourceGet Module](./)

Installs resources from a registered repository.

## Syntax

### NameParameterSet (Default)

```Syntax
Install-PSResource
    [-Name] <String[]>
    [-Version <String>]
    [-Prerelease]
    [-Repository <String[]>]
    [-Credential <PSCredential>]
    [-Scope <ScopeType>]
    [-TemporaryPath <String>]
    [-TrustRepository]
    [-Reinstall]
    [-Quiet]
    [-AcceptLicense]
    [-NoClobber]
    [-SkipDependencyCheck]
    [-AuthenticodeCheck]
    [-PassThru]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

### InputObjectParameterSet

```Syntax
Install-PSResource
    [-InputObject] <PSResourceInfo[]>
    [-Repository <String[]>]
    [-Credential <PSCredential>]
    [-Scope <ScopeType>]
    [-TemporaryPath <String>]
    [-TrustRepository]
    [-Reinstall]
    [-Quiet]
    [-AcceptLicense]
    [-NoClobber]
    [-SkipDependencyCheck]
    [-AuthenticodeCheck]
    [-PassThru]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

### RequiredResourceFileParameterSet

```Syntax
Install-PSResource
    -RequiredResourceFile <String>
    [-Credential <PSCredential>]
    [-Scope <ScopeType>]
    [-TemporaryPath <String>]
    [-TrustRepository]
    [-Reinstall]
    [-Quiet]
    [-AcceptLicense]
    [-NoClobber]
    [-SkipDependencyCheck]
    [-AuthenticodeCheck]
    [-PassThru]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

### RequiredResourceParameterSet

```Syntax
Install-PSResource
    -RequiredResource <Object>
    [-Credential <PSCredential>]
    [-Scope <ScopeType>]
    [-TemporaryPath <String>]
    [-TrustRepository]
    [-Reinstall]
    [-Quiet]
    [-AcceptLicense]
    [-NoClobber]
    [-SkipDependencyCheck]
    [-AuthenticodeCheck]
    [-PassThru]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

## Description

This cmdlet installs resources from a registered repository to an installation path on a machine. By default, the cmdlet doesn't return any object. Other parameters allow you to specify the repository, scope, and version for a resource, and suppress license prompts.

This cmdlet combines the functions of the `Install-Module` and `Install-Script` cmdlets from **PowerShellGet** v2.

`Install-PSResource` doesn't load the newly installed module into the current session. You must import the new version or start a new session to use the updated module. For more information, see [Import-Module](/en-us/powershell/module/microsoft.powershell.core/import-module).

Note

`Install-PSResource` doesn't install dependent resources from repositories that use the NuGet v3 protocol. You must install the dependent resources individually. We intend to add this feature in a future release.

## Examples

### Example 1

Installs the latest stable (non-prerelease) version of the **Az** module from the PowerShell Gallery.

```powershell
Install-PSResource Az -Repository PSGallery
```

The Az module is a meta-module that includes all the Az PowerShell modules as dependencies. This command installs the Az module and all its dependencies.

### Example 2

Installs the latest stable **Az** module within the between versions `7.3.0` and `8.3.0`.

```powershell
Install-PSResource Az -Version '[7.3.0, 8.3.0]'
```

### Example 3

Installs the latest stable version of the **Az** module. When the **Reinstall** parameter is used, the cmdlet writes over any previously installed version.

```powershell
Install-PSResource Az -Reinstall
```

### Example 4

Installs the PSResources specified in the psd1 file.

```powershell
Install-PSResource -RequiredResourceFile myRequiredModules.psd1
```

### Example 5

Installs the PSResources specified in the hashtable.

```powershell
Install-PSResource -RequiredResource  @{
    TestModule = @{
        version = '[0.0.1,1.3.0]'
        repository = 'PSGallery'
      }
    TestModulePrerelease = @{
        version = '[0.0.0,0.0.5]'
        repository = 'PSGallery'
        prerelease = 'true'
    }
    TestModule99 = @{}
}
```

## Parameters

### -AcceptLicense

Specifies that the resource should accept any request to accept the license agreement. This suppresses prompting if the module mandates that a user accept the license agreement.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -AuthenticodeCheck

Validates Authenticode signatures and catalog files on Windows.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Confirm

Prompts you for confirmation before running the cmdlet.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |
| Aliases: | cf |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Credential

Optional credentials used when accessing a repository.

#### Parameter properties

| Type: | [PSCredential](/en-us/dotnet/api/system.management.automation.pscredential) |
| --- | --- |
| Default value: | None |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -InputObject

Used for pipeline input.

#### Parameter properties

| Type: | Microsoft.PowerShell.PSResourceGet.UtilClasses.PSResourceInfo[] |
| --- | --- |
| Default value: | None |
| Supports wildcards: | False |
| DontShow: | False |
| Aliases: | ParentResource |

#### Parameter sets

 InputObjectParameterSet 

| Position: | 0 |
| --- | --- |
| Mandatory: | True |
| Value from pipeline: | True |
| Value from pipeline by property name: | True |
| Value from remaining arguments: | False |

### -Name

The name of one or more resources to install.

#### Parameter properties

| Type: | [String](/en-us/dotnet/api/system.string)[] |
| --- | --- |
| Default value: | None |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 NameParameterSet 

| Position: | 0 |
| --- | --- |
| Mandatory: | True |
| Value from pipeline: | True |
| Value from pipeline by property name: | True |
| Value from remaining arguments: | False |

### -NoClobber

Prevents installing a package that contains cmdlets that already exist on the machine.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -PassThru

When specified, outputs a **PSResourceInfo** object for the saved resource.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Prerelease

When specified, includes prerelease versions in search results returned.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |
| Aliases: | IsPrerelease |

#### Parameter sets

 NameParameterSet 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | True |
| Value from remaining arguments: | False |

### -Quiet

Suppresses installation progress bar.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Reinstall

Installs the latest version of a module even if the latest version is already installed. The installed version is overwritten. This allows you to repair a damaged installation of the module.

If an older version of the module is installed, the new version is installed side-by-side in a new version-specific folder.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Repository

Specifies one or more repository names to search. If not specified, search includes all registered repositories, in priority order (highest first), until a repository is found that contains the package. Repositories are sorted by priority then by name. Lower **Priority** values have a higher precedence.

When searching for resources across multiple repositories, the **PSResourceGet** cmdlets search the repositories using this sort order. `Install-PSResource` installs the first matching package from the sorted list of repositories.

The parameter supports the `*` wildcard character. If you specify multiple repositories, all names must include or omit the wildcard character. You can't specify a mix of names with and without wildcards.

#### Parameter properties

| Type: | [String](/en-us/dotnet/api/system.string)[] |
| --- | --- |
| Default value: | None |
| Supports wildcards: | True |
| DontShow: | False |

#### Parameter sets

 NameParameterSet 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | True |
| Value from remaining arguments: | False |

 InputObjectParameterSet 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | True |
| Value from remaining arguments: | False |

### -RequiredResource

A hashtable or JSON string that specifies resources to install. Wildcard characters aren't allowed. See the NOTES section for a description of the file formats.

#### Parameter properties

| Type: | [Object](/en-us/dotnet/api/system.object) |
| --- | --- |
| Default value: | None |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 RequiredResourceParameterSet 

| Position: | Named |
| --- | --- |
| Mandatory: | True |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -RequiredResourceFile

Path to a `.psd1` or `.json` that specifies resources to install. Wildcard characters aren't allowed. See the NOTES section for a description of the file formats.

#### Parameter properties

| Type: | [String](/en-us/dotnet/api/system.string) |
| --- | --- |
| Default value: | None |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 RequiredResourceFileParameterSet 

| Position: | Named |
| --- | --- |
| Mandatory: | True |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Scope

Specifies the installation scope. Accepted values are:

- `CurrentUser`
- `AllUsers`

The default scope is `CurrentUser`, which doesn't require elevation for install.

The `AllUsers` scope installs modules in a location accessible to all users of the computer. For example:

- `$env:ProgramFiles\PowerShell\Modules`

The `CurrentUser` installs modules in a location accessible only to the current user of the computer. For example:

- `$home\Documents\PowerShell\Modules`

#### Parameter properties

| Type: | Microsoft.PowerShell.PSResourceGet.UtilClasses.ScopeType |
| --- | --- |
| Default value: | None |
| Accepted values: | CurrentUser, AllUsers |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -SkipDependencyCheck

Skips the check for resource dependencies. Only found resources are installed. No resources of the found resource are installed.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -TemporaryPath

Specifies the path to temporarily install the resource before actual installation. If no temporary path is provided, the resource is temporarily installed in the current user's temporary folder.

#### Parameter properties

| Type: | [String](/en-us/dotnet/api/system.string) |
| --- | --- |
| Default value: | None |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -TrustRepository

Suppress prompts to trust repository. The prompt to trust repository only occurs if the repository isn't configured as trusted.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### -Version

Specifies the version of the resource to be returned. The value can be an exact version or a version range using the NuGet versioning syntax.

For more information about NuGet version ranges, see [Package versioning](/en-us/nuget/concepts/package-versioning#version-ranges).

PowerShellGet supports all but the *minimum inclusive version* listed in the NuGet version range documentation. Using `1.0.0.0` as the version doesn't yield versions 1.0.0.0 and higher (minimum inclusive range). Instead, the value is considered to be the required version. To search for a minimum inclusive range, use `[1.0.0.0, ]` as the version range.

#### Parameter properties

| Type: | [String](/en-us/dotnet/api/system.string) |
| --- | --- |
| Default value: | None |
| Supports wildcards: | True |
| DontShow: | False |

#### Parameter sets

 NameParameterSet 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | True |
| Value from remaining arguments: | False |

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

#### Parameter properties

| Type: | [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter) |
| --- | --- |
| Default value: | False |
| Supports wildcards: | False |
| DontShow: | False |
| Aliases: | wi |

#### Parameter sets

 (All) 

| Position: | Named |
| --- | --- |
| Mandatory: | False |
| Value from pipeline: | False |
| Value from pipeline by property name: | False |
| Value from remaining arguments: | False |

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable, -ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### [String](/en-us/dotnet/api/system.string)

### [String](/en-us/dotnet/api/system.string)

### [SwitchParameter](/en-us/dotnet/api/system.management.automation.switchparameter)

### Microsoft.PowerShell.PSResourceGet.UtilClasses.PSResourceInfo

## Outputs

### Microsoft.PowerShell.PSResourceGet.UtilClasses.PSResourceInfo

By default, the cmdlet doesn't return any objects. When the **PassThru** parameter is used, the cmdlet outputs a **PSResourceInfo** object for the saved resource.

## Notes

The module defines `isres` as an alias for `Install-PSResource`.

The **RequiredResource** and **RequiredResourceFile** parameters are used to find **PSResource** objects matching specific criteria. You can specify the search criteria using a hashtable or a JSON object. For the **RequiredResourceFile** parameter, the hashtable is stored in a `.psd1` file and the JSON object is stored in a `.json` file. For more information, see [about_PSResourceGet](about/about_psresourceget).

## Related Links

- [Package versioning](/en-us/nuget/concepts/package-versioning#version-ranges)
- [Uninstall-PSResource](uninstall-psresource)
