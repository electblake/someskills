<!--
source: https://learn.microsoft.com/en-us/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x
retrieved: 2026-05-04T00:01:18.814591+00:00
final_url: https://learn.microsoft.com/en-us/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x
content_type: text/markdown
-->

---
layout: Conceptual
monikers:
- powershellget-2.x
- powershellget-3.x
defaultMoniker: powershellget-3.x
versioningType: Ranged
title: Install a package manager for PowerShell - PowerShell | Microsoft Learn
canonicalUrl: https://learn.microsoft.com/en-us/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x
config_moniker_range: '>=powershellget-2.x'
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
ms.topic: install-set-up-deploy
products:
- https://authoring-docs-microsoft.poolparty.biz/devrel/2bdae855-045f-4535-b365-7b2e23824328
- https://authoring-docs-microsoft.poolparty.biz/devrel/8bce367e-2e90-4b56-9ed5-5e4e9f3a2dc3
description: This article explains how install PowerShellGet.
ms.date: 2026-01-26T00:00:00.0000000Z
locale: en-us
document_id: 37109275-0052-bf36-067d-cea9c4e7685d
document_version_independent_id: f7fb765f-9559-f5f0-da69-ad7280b4f2d7
updated_at: 2026-01-27T13:50:00.0000000Z
original_content_git_url: https://github.com/MicrosoftDocs/powershell-docs-psget/blob/live/powershell-gallery/docs-conceptual/powershellget/install-powershellget.md
gitcommit: https://github.com/MicrosoftDocs/powershell-docs-psget/blob/09842ad084eecc3aa2338b7c95c7ed616045e6ca/powershell-gallery/docs-conceptual/powershellget/install-powershellget.md
git_commit_id: 09842ad084eecc3aa2338b7c95c7ed616045e6ca
default_moniker: powershellget-3.x
site_name: Docs
depot_name: MSDN.powershell-gallery
page_type: conceptual
toc_rel: ../toc.json
word_count: 577
asset_id: gallery/powershellget/install-powershellget
moniker_range_name: 9ffe2c6b225c924cac876a5b47d8ec30
monikers:
- powershellget-2.x
- powershellget-3.x
item_type: Content
source_path: powershell-gallery/docs-conceptual/powershellget/install-powershellget.md
cmProducts: []
platformId: 15609a8a-e31f-dceb-fa26-2aa082f55221
---

# Install a package manager for PowerShell - PowerShell | Microsoft Learn

If you are running PowerShell 6.0 or later, you already have a newer version of **PowerShellGet** and **PackageManagement** installed. You should ensure you are running the latest versions of those modules.

If you are running PowerShell 7.4 or later, you also have **Microsoft.PowerShell.PSResourceGet** installed. **Microsoft.PowerShell.PSResourceGet** is the new package management solution for PowerShell. With this module, you no longer need to use **PowerShellGet** and **PackageManagement**. It's installed side-by-side with the existing **PowerShellGet** and **PackageManagement** modules.

Windows PowerShell ships with version 1.0.0.1 of **PowerShellGet** and **PackageManagement**. If you're running Windows PowerShell 5.1, you must upgrade to the latest version of PowerShellGet and PackageManagement. All versions of PowerShellGet v1.x are no longer supported.

Use the following instructions to install or update to the latest versions of these modules.

## Step 1: Enable TLS 1.2

To access the PowerShell Gallery, you must use Transport Layer Security (TLS) 1.2 or higher. Use the following command to enable TLS 1.2 in your PowerShell session.

```powershell
[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
```

Add this command to your PowerShell profile script to ensure TLS 1.2 is configured for every PowerShell session. For more information about profiles, see [about_Profiles](/en-us/powershell/module/microsoft.powershell.core/about/about_profiles).

## Step 2: Check the installed versions

To check the currently installed versions of the modules, run the following command:

```powershell
$Names = @('PowerShellGet', 'PackageManagement', 'Microsoft.PowerShell.PSResourceGet')
Get-Module -Name $Names -ListAvailable
```

In Windows PowerShell 5.1 on a newly installed Windows system, you should get the following output:

```Output
    Directory: C:\Program Files\WindowsPowerShell\Modules

ModuleType Version  Name               ExportedCommands
---------- -------  ----               ----------------
Binary     1.0.0.1  PackageManagement  {Find-Package, Get-Package, ...
Script     1.0.0.1  PowerShellGet      {Install-Module, Find-Module, ...
```

If the version of **PowerShellGet** is newer than `1.0.0.1` then you can check for updates and install the latest release.

If you are still running version `1.0.0.1`, you must follow the steps to let **PowerShellGet** install an updated NuGet provider and the `nuget.exe` command-line tool. Continue to the next step.

## Step 3: Check for updates

To check for the latest versions of the modules available from the PowerShell Gallery, run the following command:

```powershell
$Names = @('PowerShellGet', 'PackageManagement', 'Microsoft.PowerShell.PSResourceGet')
Find-Module -Name $Names -Repository PSGallery
```

You should get a result similar to the following output:

```Output
Version   Name                                Repository   Description
-------   ----                                ----------   -----------
1.4.8.1   PackageManagement                   PSGallery    PackageManagement (a.k.a. OneGet) is a n…
2.2.5     PowerShellGet                       PSGallery    PowerShell module with commands for disc…
1.1.1     Microsoft.PowerShell.PSResourceGet  PSGallery    PowerShell module with commands for disc…
```

## Step 4: Update NuGet components (if required)

An updated NuGet provider is required by **PowerShellGet** commands to work with the PowerShell Gallery. The `Publish-*` commands use `nuget.exe` or `dotnet.exe` to publish resources. If neither tool is available, PowerShellGet installs `nuget.exe`. If you are still running version `1.0.0.1` of **PowerShellGet**, `Find-Module` prompts you to install the NuGet provider. Enter Y to install the provider.

```Output
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet
-based repositories. The NuGet provider must be available in 'C:\Program Files\PackageMan
agement\ProviderAssemblies' or 'C:\Users\user1\AppData\Local\PackageManagement\ProviderAs
semblies'. You can also install the NuGet provider by running 'Install-PackageProvider -N
ame NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install and imp
ort the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
VERBOSE: Installing NuGet provider.
```

When you answer Y, PowerShellGet installs the NuGet provider and the `nuget.exe` command-line tool (if necessary).

## Step 5: Install the latest release

To install the latest versions of these modules run the following:

```powershell
Install-Module PowerShellGet -Repository PSGallery -Force -AllowClobber
Install-Module Microsoft.PowerShell.PSResourceGet -Repository PSGallery
```

Note

When you install **PowerShellGet**, it automatically installs the latest version of **PackageManagement**.
