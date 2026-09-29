# PowerShell Approved Verbs Reference

This reference contains all approved PowerShell verbs as returned by `Get-Verb`, organized by functional groups. Use these verbs when creating PowerShell cmdlets, functions, and following PowerShell naming conventions.

## Common Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Add | a | Adds a resource to a container, or attaches an item to another item |
| Clear | cl | Removes all the resources from a container but does not delete the container |
| Close | cs | Changes the state of a resource to make it inaccessible, unavailable, or unusable |
| Copy | cp | Copies a resource to another name or to another container |
| Enter | et | Specifies an action that allows the user to move into a resource |
| Exit | ex | Sets the current environment or context to the most recently used context |
| Find | fd | Looks for an object in a container that is unknown, implied, optional, or specified |
| Format | f | Arranges objects in a specified form or layout |
| Get | g | Specifies an action that retrieves a resource |
| Hide | h | Makes a resource undetectable |
| Join | j | Combines resources into one resource |
| Lock | lk | Secures a resource |
| Move | m | Moves a resource from one location to another |
| New | n | Creates a resource |
| Open | op | Changes the state of a resource to make it accessible, available, or usable |
| Optimize | om | Increases the effectiveness of a resource |
| Push | pu | Adds an item to the top of a stack |
| Pop | pop | Removes an item from the top of a stack |
| Redo | re | Resets a resource to the state that was undone |
| Remove | r | Deletes a resource from a container |
| Rename | rn | Changes the name of a resource |
| Reset | rs | Sets a resource back to its original state |
| Resize | rz | Changes the size of a resource |
| Search | sr | Creates a reference to a resource in a container |
| Select | sc | Locates a resource in a container |
| Set | s | Replaces data on an existing resource or creates a resource that contains some data |
| Show | sh | Makes a resource visible to the user |
| Skip | sk | Bypasses one or more resources or points in a sequence |
| Split | sl | Separates parts of a resource |
| Step | st | Moves to the next point or resource in a sequence |
| Switch | sw | Specifies an action that alternates between two resources, such as to change between resources |
| Undo | un | Sets a resource to its previous state |
| Unlock | uk | Releases a resource that was locked |
| Watch | wc | Continually inspects or monitors a resource for changes |

## Communications Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Connect | cc | Creates a link between a source and a destination |
| Disconnect | dc | Breaks the link between a source and a destination |
| Read | rd | Acquires information from a source |
| Receive | rc | Accepts information sent from a source |
| Send | sd | Delivers information to a destination |
| Write | wr | Adds information to a target |

## Data Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Backup | ba | Stores data by replicating it |
| Checkpoint | ch | Creates a snapshot of the current state of the data or of its configuration |
| Compare | cr | Evaluates the data from one resource against the data from another resource |
| Compress | cm | Compacts the data of a resource |
| Convert | cv | Changes the data from one representation to another when the cmdlet supports bidirectional conversion |
| ConvertFrom | cf | Converts one primary type of input (the cmdlet noun indicates the input) to one or more output types |
| ConvertTo | ct | Converts from one or more types of input to a primary output type (the cmdlet noun indicates the output type) |
| Dismount | dm | Detaches a named entity from a location |
| Edit | ed | Modifies existing data by adding or removing content |
| Expand | en | Restores the data of a resource that has been compressed to its original state |
| Export | ep | Encapsulates the primary input into a persistent data store, such as a file, or into an interchange format |
| Group | gp | Arranges or associates one or more resources |
| Import | ip | Creates a resource from data that is stored in a persistent data store (such as a file) or in an interchange format |
| Initialize | in | Prepares a resource for use, and sets it to a default state |
| Limit | l | Applies constraints to a resource |
| Merge | mg | Creates a single resource from multiple resources |
| Mount | mt | Attaches a named entity to a location |
| Out | o | Sends data out of the environment |
| Publish | pb | Makes a resource available to others |
| Restore | rr | Sets a resource to a predefined state, such as a state set by Checkpoint |
| Save | sv | Preserves data to avoid loss |
| Sync | sy | Assures that two or more resources are in the same state |
| Unpublish | ub | Makes a resource unavailable to others |
| Update | ud | Brings a resource up-to-date to maintain its state, accuracy, conformance, or compliance |

## Diagnostic Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Debug | db | Examines a resource to diagnose operational problems |
| Measure | ms | Identifies resources that are consumed by a specified operation, or retrieves statistics about a resource |
| Ping | pi | Use the Test verb |
| Repair | rp | Restores a resource to a usable condition |
| Resolve | rv | Maps a shorthand representation of a resource to a more complete representation |
| Test | t | Verifies the operation or consistency of a resource |
| Trace | tr | Tracks the activities of a resource |

## Lifecycle Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Approve | ap | Confirms or agrees to the status of a resource or process |
| Assert | as | Affirms the state of a resource |
| Build | bd | Creates an artifact (usually a binary or document) out of some set of input files (usually source code or declarative documents) |
| Complete | cmp | Concludes an operation |
| Confirm | cn | Acknowledges, verifies, or validates the state of a resource or process |
| Deny | dn | Refuses, objects, blocks, or opposes the state of a resource or process |
| Deploy | dp | Sends an application, website, or solution to a remote target[s] in such a way that a consumer of that solution can access it after deployment is complete |
| Disable | d | Configures a resource to an unavailable or inactive state |
| Enable | e | Configures a resource to an available or active state |
| Install | is | Places a resource in a location, and optionally initializes it |
| Invoke | i | Performs an action, such as running a command or a method |
| Register | rg | Creates an entry for a resource in a repository such as a database |
| Request | rq | Asks for a resource or asks for permissions |
| Restart | rt | Stops an operation and then starts it again |
| Resume | ru | Starts an operation that has been suspended |
| Start | sa | Initiates an operation |
| Stop | sp | Discontinues an activity |
| Submit | sb | Presents a resource for approval |
| Suspend | ss | Pauses an activity |
| Uninstall | us | Removes a resource from an indicated location |
| Unregister | ur | Removes the entry for a resource from a repository |
| Wait | w | Pauses an operation until a specified event occurs |

## Other Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Use | u | Uses or includes a resource to do something |

## Security Verbs
| Verb | Alias | Description |
|------|-------|-------------|
| Block | bl | Restricts access to a resource |
| Grant | gr | Allows access to a resource |
| Protect | pt | Safeguards a resource from attack or loss |
| Revoke | rk | Specifies an action that does not allow access to a resource |
| Unblock | ul | Removes restrictions to a resource |
| Unprotect | up | Removes safeguards from a resource that were added to prevent it from attack or loss |

---

Generated on: February 3, 2026  
PowerShell Version: 7.x  
Source: `Get-Verb` cmdlet

## Usage Guidelines

1. **Always use approved verbs** when creating PowerShell functions or cmdlets
2. **Follow Verb-Noun pattern** for function names (e.g., `Get-Process`, `Set-Location`)
3. **Use aliases sparingly** in production scripts - prefer full verb names for clarity
4. **Choose the most specific verb** that accurately describes the function's action
5. **Avoid synonyms** - stick to the approved verbs rather than creating custom variations

## Common Naming Examples

```powershell
# ✅ Good - Uses approved verbs
Get-UserProfile
Set-NetworkConfiguration
Test-DatabaseConnection
Start-ServiceMonitor

# ❌ Avoid - Uses unapproved verbs
Retrieve-UserProfile    # Use 'Get' instead
Configure-Network       # Use 'Set' instead  
Check-Database          # Use 'Test' instead
Launch-Monitor          # Use 'Start' instead
```