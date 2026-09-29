# PowerShell Code Guidelines

Comprehensive code guidelines for PowerShell cmdlet development based on Microsoft's official documentation. These guidelines ensure proper implementation and robust cmdlet behavior.

## Required Code Guidelines

These guidelines **MUST** be followed when implementing cmdlets.

### Derive from Cmdlet or PSCmdlet Classes (RC01)

**Requirement:** All cmdlets must derive from either `Cmdlet` or `PSCmdlet` base class.

**Class Selection:**
- **`Cmdlet`:** No dependency on PowerShell runtime, can be called from any .NET language
- **`PSCmdlet`:** Depends on PowerShell runtime, executes within runspace, provides additional features

```csharp
// Basic cmdlet
public class GetProcessCommand : Cmdlet
{
    // Implementation
}

// Advanced cmdlet with PowerShell runtime features
public class GetServiceCommand : PSCmdlet  
{
    // Can use Host property, runspace features
}
```

**Additional Requirements:**
- All cmdlet classes must be **public**
- Must follow proper inheritance patterns

### Specify the Cmdlet Attribute (RC02)

**Requirement:** Decorate cmdlet class with `[Cmdlet]` attribute.

```csharp
[Cmdlet(VerbsCommon.Get, "Process", 
        DefaultParameterSetName = "Name",
        SupportsShouldProcess = true,
        ConfirmImpact = ConfirmImpact.Medium)]
public class GetProcessCommand : Cmdlet
```

**Attribute Properties:**
- **Verb and Noun:** Identifies the cmdlet
- **DefaultParameterSetName:** Default when multiple parameter sets exist
- **SupportsShouldProcess:** Enables confirmation requests
- **ConfirmImpact:** Sets confirmation prompt sensitivity

### Override Input Processing Method (RC03)

**Requirement:** Override at least one input processing method.

**Available Methods:**

#### BeginProcessing
- Called **once** at start
- Use for initialization and setup
```csharp
protected override void BeginProcessing()
{
    // One-time setup
    WriteVerbose("Starting process enumeration");
}
```

#### ProcessRecord  
- Called **multiple times** (once per pipeline object)
- Use for main processing logic
```csharp
protected override void ProcessRecord()
{
    // Process each input object
    foreach (var name in Name)
    {
        var processes = Process.GetProcessesByName(name);
        WriteObject(processes, true);
    }
}
```

#### EndProcessing
- Called **once** at end  
- Use for cleanup and final output
```csharp
protected override void EndProcessing()
{
    // Final cleanup
    WriteVerbose("Completed process enumeration");
}
```

### Specify OutputType Attribute (RC04)

**Requirement:** Declare output types with `[OutputType]` attribute.

```csharp
[Cmdlet("Get", "Process")]
[OutputType(typeof(Process))]
[OutputType(typeof(ProcessInfo), ParameterSetName = "Detailed")]
public class GetProcessCommand : Cmdlet
```

**Benefits:**
- Makes output types discoverable
- Enables better IntelliSense
- Supports pipeline analysis

### Do Not Retain Handles to Output Objects (RC05)

**Requirement:** Don't keep references to objects passed to `WriteObject`.

```csharp
// ❌ Don't do this - retaining handle
private List<Process> processCache = new List<Process>();

protected override void ProcessRecord()
{
    var process = Process.GetProcessById(Id);
    processCache.Add(process);  // BAD - retaining handle
    WriteObject(process);
}

// ✅ Do this - no retained handles
protected override void ProcessRecord()
{
    var process = Process.GetProcessById(Id);
    WriteObject(process);  // Object passed to pipeline
    // No local references retained
}
```

**Why:** Objects are owned by pipeline; retaining handles causes errors.

### Handle Errors Robustly (RC06)

**Terminating Errors:**
Use for errors that prevent continued processing.

```csharp
try
{
    var process = Process.GetProcessById(Id);
}
catch (ArgumentException ex)
{
    var errorRecord = new ErrorRecord(
        ex,
        "ProcessNotFound", 
        ErrorCategory.ObjectNotFound,
        Id);
    ThrowTerminatingError(errorRecord);
}
```

**Non-Terminating Errors:**
Use for errors that allow continued processing.

```csharp
foreach (var name in Names)
{
    try
    {
        var processes = Process.GetProcessesByName(name);
        WriteObject(processes, true);
    }
    catch (Exception ex)
    {
        var errorRecord = new ErrorRecord(
            ex,
            "ProcessEnumFailed",
            ErrorCategory.NotSpecified,
            name);
        WriteError(errorRecord);
        // Continue with next name
    }
}
```

**Error Categories:**
- Use appropriate `ErrorCategory` enumeration values
- Group related errors consistently
- Consider user's `$ErrorView` preference

**Threading Considerations:**
- Unhandled exceptions in created threads terminate process
- Handle exceptions in destructors and Dispose methods
- PowerShell won't catch errors from background threads

### Use PowerShell Module for Deployment (RC07)

**Requirement:** Package cmdlets as PowerShell modules.

**Module Benefits:**
- Better deployment experience
- Automatic discovery
- Version management
- Dependency handling

**Module Types:**
- **Binary Module:** Assembly containing cmdlet classes
- **Manifest Module:** `.psd1` file referencing assemblies
- **Script Module:** `.psm1` file with PowerShell code

```powershell
# Example module manifest
@{
    ModuleVersion = '1.0.0'
    RootModule = 'MyCmdlets.dll'
    CmdletsToExport = @('Get-MyProcess', 'Stop-MyProcess')
    FunctionsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
}
```

---

## Strongly Encouraged Code Guidelines

These guidelines should be followed for best implementation practices.

### Coding Parameters (SC01)

#### Support Windows PowerShell Paths

**Use PowerShell path resolution:**

```csharp
[Parameter()]
[Alias("PSPath")]
public string[] Path { get; set; }

[Parameter()]
public string[] LiteralPath { get; set; }

protected override void ProcessRecord()
{
    foreach (var path in Path)
    {
        var resolvedPaths = SessionState.Path
            .GetResolvedProviderPathFromPSPath(path, out var provider);
        
        foreach (var resolvedPath in resolvedPaths)
        {
            ProcessFile(resolvedPath);
        }
    }
}
```

**Key Path Methods:**
- `GetResolvedProviderPathFromPSPath` - Resolves wildcards
- `GetUnresolvedProviderPathFromPSPath` - No wildcard resolution
- Support PowerShell drives and providers

#### Support Wildcard Characters

```csharp
protected override void ProcessRecord()
{
    if (WildcardPattern.ContainsWildcardCharacters(Name))
    {
        var pattern = new WildcardPattern(Name, WildcardOptions.IgnoreCase);
        var processes = Process.GetProcesses()
            .Where(p => pattern.IsMatch(p.ProcessName));
        WriteObject(processes, true);
    }
    else
    {
        var processes = Process.GetProcessesByName(Name);
        WriteObject(processes, true);
    }
}
```

#### Define Objects for Cmdlets

**Standard Members:**
Create `Types.ps1xml` file to define standard members:

```xml
<Type>
    <Name>System.IO.FileInfo</Name>
    <Members>
        <ScriptProperty>
            <Name>Mode</Name>
            <GetScriptBlock>
                "{0}{1}{2}{3}" -f 
                @(if($this.PsIsContainer){"d"}else{"-"}),
                @(if($this.Mode -match "r"){"r"}else{"-"}),
                @(if($this.Mode -match "w"){"w"}else{"-"}),
                @(if($this.Mode -match "x"){"x"}else{"-"})
            </GetScriptBlock>
        </ScriptProperty>
    </Members>
</Type>
```

**Object Members for Parameters:**
Design objects so their properties map to cmdlet parameters:

```csharp
public class ServiceInfo
{
    public string Name { get; set; }        // Maps to -Name parameter
    public ServiceState State { get; set; } // Maps to -State parameter
    public string DisplayName { get; set; } // Maps to -DisplayName parameter
}
```

**IComparable Implementation:**
```csharp
public class ProcessInfo : IComparable<ProcessInfo>
{
    public int CompareTo(ProcessInfo other)
    {
        return String.Compare(this.Name, other?.Name, StringComparison.OrdinalIgnoreCase);
    }
}
```

**Custom Format Files:**
Create `Format.ps1xml` for custom display:

```xml
<View>
    <Name>Process</Name>
    <ViewSelectedBy>
        <TypeName>System.Diagnostics.Process</TypeName>
    </ViewSelectedBy>
    <TableControl>
        <TableHeaders>
            <TableColumnHeader><Label>Name</Label></TableColumnHeader>
            <TableColumnHeader><Label>Id</Label></TableColumnHeader>
        </TableHeaders>
        <TableRowEntries>
            <TableRowEntry>
                <TableColumnItems>
                    <TableColumnItem><PropertyName>Name</PropertyName></TableColumnItem>
                    <TableColumnItem><PropertyName>Id</PropertyName></TableColumnItem>
                </TableColumnItems>
            </TableRowEntry>
        </TableRowEntries>
    </TableControl>
</View>
```

### Support Well-Defined Pipeline Input (SC02)

#### Implement for Pipeline Middle

**Design cmdlets assuming they're in pipeline middle:**

```csharp
[Cmdlet("Stop", "MyProcess")]
public class StopProcessCommand : Cmdlet
{
    [Parameter(ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
    public int[] Id { get; set; }
    
    [Parameter(ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
    public string[] Name { get; set; }
}

// Usage: Get-Process | Stop-MyProcess
```

#### Support Input from Pipeline

**Pipeline Input Options:**

```csharp
// By value - entire object
[Parameter(ValueFromPipeline = true)]
public Process InputObject { get; set; }

// By property name - object properties  
[Parameter(ValueFromPipelineByPropertyName = true)]
public string Name { get; set; }

// Both
[Parameter(ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
public int Id { get; set; }
```

#### Support ProcessRecord Method

**Always implement ProcessRecord for pipeline support:**

```csharp
protected override void ProcessRecord()
{
    // Process each pipeline input
    if (InputObject != null)
    {
        ProcessSingleObject(InputObject);
    }
    else if (Name != null)
    {
        foreach (var name in Name)
        {
            ProcessByName(name);
        }
    }
}
```

### Write Single Records to Pipeline (SC03)

**Stream objects immediately:**

```csharp
// ✅ Good - Immediate output
protected override void ProcessRecord()
{
    foreach (var process in Process.GetProcesses())
    {
        if (MatchesCriteria(process))
        {
            WriteObject(process); // Immediate output
        }
    }
}

// ❌ Bad - Buffering all objects
private List<Process> results = new List<Process>();

protected override void ProcessRecord()
{
    results.AddRange(Process.GetProcesses()); // Buffering
}

protected override void EndProcessing()
{
    WriteObject(results, true); // All at once - BAD
}
```

**Benefits of immediate output:**
- Lower memory usage
- Better perceived performance  
- Enables pipeline streaming

### Make Cmdlets Case-Insensitive and Case-Preserving (SC04)

```csharp
protected override void ProcessRecord()
{
    // ✅ Case-insensitive comparison
    var processes = Process.GetProcesses()
        .Where(p => string.Equals(p.ProcessName, Name, StringComparison.OrdinalIgnoreCase));
    
    foreach (var process in processes)
    {
        // ✅ Preserve original case in output
        WriteObject(process);
    }
}
```

**Key Principles:**
- Accept input in any case
- Preserve original case in output
- Use `StringComparison.OrdinalIgnoreCase` for comparisons

---

## Advisory Code Guidelines

Consider these guidelines for enhanced implementation.

### Follow Cmdlet Class Naming Conventions (AC01)

#### Correct Namespace
```csharp
// ✅ Correct namespace pattern
namespace Microsoft.PowerShell.Commands
namespace Company.Product.Commands
namespace MyModule.Commands

// ❌ Avoid generic namespaces
namespace Utilities
namespace Tools
```

#### Match Class Name to Cmdlet
```csharp
// ✅ Correct naming
[Cmdlet("Get", "Process")]
public class GetProcessCommand : Cmdlet

[Cmdlet("Stop", "Service")]  
public class StopServiceCommand : Cmdlet

// ❌ Incorrect naming
[Cmdlet("Get", "Process")]
public class ProcessGetter : Cmdlet
```

### No Pipeline Input - Use BeginProcessing (AC02)

```csharp
// For cmdlets that don't accept pipeline input
protected override void BeginProcessing()
{
    // All processing logic here
    var data = GetAllData();
    WriteObject(data, true);
}

// Don't implement ProcessRecord for non-pipeline cmdlets
```

### Handle Stop Requests (AC03)

```csharp
protected override void ProcessRecord()
{
    foreach (var item in LargeDataSet)
    {
        // Check for stop signal
        if (Stopping)
        {
            break;
        }
        
        // Process item
        ProcessItem(item);
    }
}

protected override void StopProcessing()
{
    // Clean up resources
    // Cancel long-running operations
    WriteVerbose("Processing stopped by user");
}
```

### Implement IDisposable Interface (AC04)

```csharp
public class MyCommand : Cmdlet, IDisposable
{
    private FileStream fileStream;
    private bool disposed = false;
    
    protected override void BeginProcessing()
    {
        fileStream = new FileStream(Path, FileMode.Open);
    }
    
    protected override void EndProcessing()
    {
        Dispose();
    }
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                fileStream?.Dispose();
            }
            disposed = true;
        }
    }
    
    ~MyCommand()
    {
        Dispose(false);
    }
}
```

### Use Serialization-Friendly Parameter Types (AC05)

**Serialization-Friendly Types:**

**Primitive Types:**
- `Byte`, `SByte`, `Decimal`, `Single`, `Double`
- `Int16`, `Int32`, `Int64`, `UInt16`, `UInt32`, `UInt64`
- `Boolean`, `Guid`, `Byte[]`, `TimeSpan`, `DateTime`, `Uri`, `Version`
- `Char`, `String`, `XmlDocument`

**Built-in Rehydratable Types:**
- `PSPrimitiveDictionary`
- `SwitchParameter`
- `PSListModifier`
- `PSCredential`
- `IPAddress`, `MailAddress`
- `CultureInfo`
- `X509Certificate2`, `X500DistinguishedName`
- `DirectorySecurity`, `FileSecurity`, `RegistrySecurity`

**Other Supported Types:**
- `SecureString`
- Collections of the above types

### Use SecureString for Sensitive Data (AC06)

```csharp
[Parameter()]
public SecureString Password { get; set; }

protected override void ProcessRecord()
{
    // Convert SecureString to use
    var credential = new PSCredential("user", Password);
    
    // Use credential for authentication
    AuthenticateUser(credential);
}
```

**Important Notes:**
- PowerShell continues supporting SecureString for backward compatibility
- Still more secure than plain text strings
- Use carefully as it can be converted to plain text
- Avoid accidental exposure in console or logs

---

## Implementation Patterns

### Complete Cmdlet Example

```csharp
using System;
using System.Management.Automation;
using System.Diagnostics;
using System.Linq;

namespace MyCompany.PowerShell.Commands
{
    [Cmdlet(VerbsCommon.Get, "MyProcess", 
            DefaultParameterSetName = "Name",
            SupportsShouldProcess = true)]
    [OutputType(typeof(Process))]
    public class GetMyProcessCommand : Cmdlet, IDisposable
    {
        [Parameter(Position = 0, ParameterSetName = "Name")]
        [SupportsWildcards]
        public string[] Name { get; set; } = { "*" };
        
        [Parameter(ParameterSetName = "Id", ValueFromPipelineByPropertyName = true)]
        public int[] Id { get; set; }
        
        [Parameter()]
        public SwitchParameter IncludeUserName { get; set; }
        
        private bool disposed = false;
        
        protected override void BeginProcessing()
        {
            WriteVerbose("Starting process enumeration");
        }
        
        protected override void ProcessRecord()
        {
            try
            {
                if (ParameterSetName == "Id")
                {
                    ProcessById();
                }
                else
                {
                    ProcessByName();
                }
            }
            catch (Exception ex) when (!(ex is PipelineStoppedException))
            {
                var errorRecord = new ErrorRecord(
                    ex, 
                    "ProcessEnumerationFailed",
                    ErrorCategory.NotSpecified,
                    null);
                WriteError(errorRecord);
            }
        }
        
        private void ProcessById()
        {
            foreach (var id in Id)
            {
                if (Stopping) break;
                
                try
                {
                    var process = Process.GetProcessById(id);
                    WriteObject(process);
                }
                catch (ArgumentException)
                {
                    WriteWarning($"Process with ID {id} not found");
                }
            }
        }
        
        private void ProcessByName()
        {
            var allProcesses = Process.GetProcesses();
            
            foreach (var namePattern in Name)
            {
                if (Stopping) break;
                
                var pattern = new WildcardPattern(namePattern, WildcardOptions.IgnoreCase);
                var matchingProcesses = allProcesses
                    .Where(p => pattern.IsMatch(p.ProcessName));
                
                foreach (var process in matchingProcesses)
                {
                    WriteObject(process);
                }
            }
        }
        
        protected override void EndProcessing()
        {
            WriteVerbose("Completed process enumeration");
        }
        
        protected override void StopProcessing()
        {
            WriteVerbose("Process enumeration stopped by user");
        }
        
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    // Cleanup managed resources
                }
                disposed = true;
            }
        }
    }
}
```

---

## Error Handling Best Practices

### Error Categories
Use appropriate `ErrorCategory` values:

- `CloseError` - Error closing resource
- `OpenError` - Error opening resource  
- `DeviceError` - Hardware device error
- `DeadlockDetected` - Deadlock detected
- `InvalidArgument` - Invalid parameter value
- `InvalidData` - Invalid data format
- `InvalidOperation` - Operation not valid in current state
- `InvalidResult` - Unexpected result
- `InvalidType` - Wrong type provided
- `MetadataError` - Error in metadata
- `NotImplemented` - Feature not implemented
- `NotInstalled` - Component not installed
- `ObjectNotFound` - Object doesn't exist
- `OperationStopped` - Operation cancelled by user
- `OperationTimeout` - Operation timed out
- `SyntaxError` - Syntax error
- `ParserError` - Parse error
- `PermissionDenied` - Access denied
- `ResourceBusy` - Resource in use
- `ResourceExists` - Resource already exists
- `ResourceUnavailable` - Resource not available
- `ReadError` - Read operation failed
- `WriteError` - Write operation failed
- `FromStdErr` - Error from stderr
- `SecurityError` - Security violation
- `ProtocolError` - Protocol error
- `ConnectionError` - Connection failed
- `AuthenticationError` - Authentication failed
- `LimitsExceeded` - Limits exceeded
- `QuotaExceeded` - Quota exceeded
- `NotSpecified` - General error

### Custom Exceptions

```csharp
public class ProcessNotFoundException : Exception
{
    public ProcessNotFoundException() { }
    
    public ProcessNotFoundException(string message) : base(message) { }
    
    public ProcessNotFoundException(string message, Exception innerException) 
        : base(message, innerException) { }
    
    public int ProcessId { get; set; }
}

// Usage in cmdlet
catch (ProcessNotFoundException ex)
{
    var errorRecord = new ErrorRecord(
        ex,
        "ProcessNotFound",
        ErrorCategory.ObjectNotFound,
        ex.ProcessId);
    ThrowTerminatingError(errorRecord);
}
```

---

## Testing Guidelines

### Unit Testing Cmdlets

```csharp
[TestMethod]
public void GetMyProcess_WithValidId_ReturnsProcess()
{
    // Arrange
    var cmdlet = new GetMyProcessCommand();
    cmdlet.Id = new[] { Process.GetCurrentProcess().Id };
    
    var results = new List<PSObject>();
    cmdlet.CommandRuntime = new TestCommandRuntime(results);
    
    // Act
    cmdlet.Invoke();
    
    // Assert
    Assert.AreEqual(1, results.Count);
    Assert.IsInstanceOfType(results[0].BaseObject, typeof(Process));
}
```

### Integration Testing

```powershell
# Test pipeline integration
Describe "Get-MyProcess Pipeline Tests" {
    It "Should accept process IDs from pipeline" {
        $processes = Get-Process | Select-Object -First 3
        $result = $processes | Get-MyProcess
        $result.Count | Should -Be 3
    }
    
    It "Should support wildcards in names" {
        $result = Get-MyProcess -Name "power*"
        $result | Should -Not -BeNullOrEmpty
    }
}
```

---

**Source:** Microsoft Learn PowerShell Documentation  
**Last Updated:** February 3, 2026  
**Applies To:** PowerShell 7.x
