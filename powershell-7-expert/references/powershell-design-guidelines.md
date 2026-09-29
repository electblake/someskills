# PowerShell Design Guidelines

Comprehensive design guidelines for PowerShell cmdlet development based on Microsoft's official documentation. These guidelines ensure consistent user experience and proper PowerShell integration.

## Required Design Guidelines

These guidelines **MUST** be followed when designing cmdlets.

### Use Only Approved Verbs (RD01)

**Requirement:** The verb specified in the Cmdlet attribute must come from the recognized set of verbs provided by PowerShell.

**Approved Verb Categories:**
- `System.Management.Automation.VerbsCommon`
- `System.Management.Automation.VerbsCommunications` 
- `System.Management.Automation.VerbsData`
- `System.Management.Automation.VerbsDiagnostic`
- `System.Management.Automation.VerbsLifecycle`
- `System.Management.Automation.VerbsSecurity`
- `System.Management.Automation.VerbsOther`

**Examples:**
```powershell
# ✅ Correct - Uses approved verb
Get-Command Start-*

# ❌ Incorrect - Uses unapproved verb
Retrieve-Process  # Use Get-Process instead
```

**Why:** Users need discoverable and expected cmdlet names. Approved verbs enable quick assessment of cmdlet functionality.

### Cmdlet Names: Characters that Cannot be Used (RD02)

**Prohibited Characters:**
| Character | Name | Notes |
|-----------|------|-------|
| `#` | number sign | |
| `,` | comma | |
| `()` | parentheses | |
| `{}` | braces | |
| `[]` | brackets | |
| `&` | ampersand | |
| `-` | hyphen | Can separate verb from noun, but not within verb/noun |
| `/` | slash mark | |
| `\` | backslash | |
| `$` | dollar sign | |
| `^` | caret | |
| `;` | semicolon | |
| `:` | colon | |
| `"` | double quotation mark | |
| `'` | single quotation mark | |
| `<>` | angle brackets | |
| `|` | vertical bar | |
| `?` | question mark | |
| `@` | at sign | |
| `` ` `` | back tick (grave accent) | |
| `*` | asterisk | |
| `%` | percent sign | |
| `+` | plus sign | |
| `=` | equals sign | |
| `~` | tilde | |

### Parameter Names that Cannot be Used (RD03)

**Reserved Parameter Names:**
PowerShell provides these common parameters automatically - do not use these names:

- `Confirm`
- `Debug`
- `ErrorAction`
- `ErrorVariable`
- `OutBuffer`
- `OutVariable`
- `WarningAction`
- `WarningVariable`
- `WhatIf`
- `UseTransaction`
- `Verbose`

### Support Confirmation Requests (RD04)

**Requirement:** Cmdlets that modify the system must call `ShouldProcess` method.

```csharp
[Cmdlet(VerbsLifecycle.Stop, "Process", SupportsShouldProcess = true)]
public class StopProcessCommand : Cmdlet
{
    protected override void ProcessRecord()
    {
        if (ShouldProcess("Process", "Stop"))
        {
            // Perform the operation
        }
    }
}
```

**Key Points:**
- Set `SupportsShouldProcess = true` in Cmdlet attribute
- Use `ShouldProcess` for system modifications
- Use `ShouldContinue` for dangerous operations
- Support `Force` parameter to bypass confirmations

### Support Force Parameter for Interactive Sessions (RD05)

**Requirement:** Interactive cmdlets must provide a `Force` parameter to override prompts.

**Interactive methods that require Force parameter:**
- `PSHostUserInterface.Prompt*`
- `PSHostUserInterface.PromptForChoice`
- `IHostUISupportsMultipleChoiceSelection.PromptForChoice`
- `PSHostUserInterface.PromptForCredential*`
- `PSHostUserInterface.ReadLine*`
- `PSHostUserInterface.ReadLineAsSecureString*`

### Document Output Objects (RD06)

**Requirement:** Document all objects returned by cmdlets and their members.

**Documentation should include:**
- Object types returned
- Properties and methods available
- Usage scenarios for returned objects
- Examples of consuming the output

---

## Strongly Encouraged Design Guidelines

These guidelines should be followed for best user experience.

### Use Specific Nouns for Cmdlet Names (SD01)

**Guidelines:**
- Use very specific nouns for discoverability
- Prefix generic nouns with product abbreviation
- Use singular forms (not plural)

**Examples:**
```powershell
# ✅ Good - Specific and singular
Get-Process        # Not Get-Processes
Get-SQLServer      # Not Get-Server (when referring to SQL Server)
Set-NetworkAdapter # Not Set-Adapter

# ❌ Avoid - Generic or plural
Get-Thing
Get-Items
```

### Use Pascal Case for Cmdlet Names (SD02)

**Format:** Capitalize first letter of verb and all terms in noun.

**Examples:**
```powershell
# ✅ Correct
Clear-ItemProperty
Get-WinEvent
Set-ExecutionPolicy

# ❌ Incorrect
clear-itemProperty
GET-WINEVENT
set-executionpolicy
```

### Parameter Design Guidelines (SD03)

#### Use Standard Parameter Names
- Use standard parameter names when possible
- Provide specific aliases for standard names

**Example:**
```powershell
# Standard name with specific alias
[Parameter()]
[Alias("ServiceName")]
[string] $Name
```

#### Use Singular Parameter Names
- Avoid plural names for single-element parameters
- Use plural only when parameter always takes multiple values

#### Use Pascal Case for Parameter Names
```powershell
# ✅ Correct
[Parameter()] [string] $ErrorAction
[Parameter()] [string] $ComputerName

# ❌ Incorrect  
[Parameter()] [string] $errorAction
[Parameter()] [string] $computername
```

#### Parameters with Option Lists
Two approaches for parameters with limited options:

1. **Enumeration Type:**
```csharp
public enum ProcessState
{
    Running,
    Stopped,
    Suspended
}

[Parameter()]
public ProcessState State { get; set; }
```

2. **ValidateSet Attribute:**
```csharp
[Parameter()]
[ValidateSet("Running", "Stopped", "Suspended")]
public string State { get; set; }
```

#### Use Strongly-Typed .NET Framework Types
```csharp
// ✅ Correct - Strongly typed
[Parameter()]
public Uri ServerUri { get; set; }

[Parameter()]
public ProcessState State { get; set; }

// ❌ Avoid - Basic string for structured data
[Parameter()]
public string ServerUri { get; set; }
```

#### Use Consistent Parameter Types
- Same parameter across cmdlets should use same type
- Don't vary types between similar parameters

#### Support True/False Parameters
```csharp
// ✅ Use SwitchParameter for true/false
[Parameter()]
public SwitchParameter Force { get; set; }

// ✅ Use Nullable<bool> for true/false/unspecified
[Parameter()]
public bool? Enabled { get; set; }

// ❌ Don't use Boolean parameters
[Parameter()]
public bool Force { get; set; }  // Avoid this
```

#### Support Arrays for Parameters
```csharp
// ✅ Support arrays for multiple items
[Parameter()]
public string[] Name { get; set; }

// Usage
Get-Process -Name "chrome", "firefox", "edge"
```

#### Support PassThru Parameter
```csharp
// For cmdlets that modify but don't normally return objects
[Parameter()]
public SwitchParameter PassThru { get; set; }

protected override void ProcessRecord()
{
    // Perform operation
    var result = StopTheProcess();
    
    if (PassThru)
    {
        WriteObject(result);
    }
}
```

#### Support Parameter Sets
```csharp
[Cmdlet("Get", "Process")]
public class GetProcessCommand : Cmdlet
{
    [Parameter(ParameterSetName = "ByName", Position = 0)]
    public string[] Name { get; set; }
    
    [Parameter(ParameterSetName = "ById", ValueFromPipeline = true)]
    public int[] Id { get; set; }
}
```

### Provide Feedback to the User (SD04)

#### Support WriteWarning, WriteVerbose, and WriteDebug
```csharp
protected override void ProcessRecord()
{
    WriteVerbose("Processing item: " + Name);
    
    if (IsRiskyOperation)
    {
        WriteWarning("This operation may cause data loss");
    }
    
    WriteDebug("Internal state: " + debugInfo);
}
```

#### Support WriteProgress for Long Operations
```csharp
protected override void ProcessRecord()
{
    for (int i = 0; i < items.Length; i++)
    {
        var progress = new ProgressRecord(1, "Processing Items", 
            $"Processing item {i + 1} of {items.Length}")
        {
            PercentComplete = (i * 100) / items.Length
        };
        WriteProgress(progress);
        
        // Do work
    }
}
```

#### Use Host Interfaces Appropriately
- Derive from `PSCmdlet` for host interaction
- Use `Host` property for prompts and user interaction
- Avoid `System.Console` API

### Create Cmdlet Help File (SD05)

**Requirements:**
- Create Help.xml file for each cmdlet assembly
- Include cmdlet description
- Document all parameters
- Provide usage examples
- Show expected output

---

## Advisory Design Guidelines

Consider these guidelines for enhanced user experience.

### Support InputObject Parameter (AD01)

**Purpose:** Enable direct object input alongside other parameter types.

```csharp
[Parameter(ParameterSetName = "ByObject", ValueFromPipeline = true)]
public Process InputObject { get; set; }
```

**Benefits:**
- Allows manipulation before passing to cmdlet
- Supports complex object workflows
- Enhances pipeline scenarios

### Support Force Parameter (AD02)

**Use Cases:**
- Override read-only protections
- Bypass safety checks
- Force dangerous operations

**Example:**
```csharp
[Parameter()]
public SwitchParameter Force { get; set; }

if (!Force && IsReadOnly)
{
    WriteWarning("File is read-only. Use -Force to override.");
    return;
}
```

### Handle Credentials Through PowerShell (AD03)

```csharp
[Parameter()]
[Credential()]
public PSCredential Credential { get; set; }
```

**Benefits:**
- Automatic credential prompting
- Secure credential handling
- Consistent credential experience

### Support Encoding Parameters (AD04)

For text file operations:

```csharp
[Parameter()]
public Encoding Encoding { get; set; } = Encoding.UTF8;
```

### Test Cmdlets Should Return Boolean (AD05)

```csharp
[Cmdlet("Test", "Path")]
public class TestPathCommand : Cmdlet
{
    protected override void ProcessRecord()
    {
        bool exists = File.Exists(Path);
        WriteObject(exists);
    }
}
```

---

## Best Practices Summary

### Naming Conventions
1. ✅ Use approved verbs only
2. ✅ Use specific, singular nouns  
3. ✅ Use Pascal case throughout
4. ✅ Avoid prohibited characters
5. ✅ Don't use reserved parameter names

### Parameter Design
1. ✅ Use standard parameter names with aliases
2. ✅ Support arrays for multiple values
3. ✅ Use strongly-typed parameters
4. ✅ Implement parameter sets for different usage patterns
5. ✅ Support PassThru for modification cmdlets

### User Experience
1. ✅ Implement confirmation for system changes
2. ✅ Provide Force parameter for interactive operations
3. ✅ Support verbose, warning, and debug output
4. ✅ Show progress for long-running operations
5. ✅ Create comprehensive help documentation

### Advanced Features
1. ✅ Support InputObject for complex scenarios
2. ✅ Handle credentials properly
3. ✅ Support encoding for text operations
4. ✅ Return Boolean for test cmdlets
5. ✅ Use host interfaces appropriately

---

**Source:** Microsoft Learn PowerShell Documentation  
**Last Updated:** February 3, 2026  
**Applies To:** PowerShell 7.x
