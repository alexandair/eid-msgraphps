
#region LAB: Working with Azure AD Privileged Identity Management (PIM)

Connect-MgGraph -Scopes 'RoleManagement.ReadWrite.Directory'

$User = Get-MgUser -UserId 'diegos@mo3ak.onmicrosoft.com'
$principalId = $User.Id
Get-MgDirectoryRole | Select-Object DisplayName, id | Sort-Object DisplayName
<#
DisplayName                      Id
-----------                      --
Application Administrator        412ce2a5-17d0-4fe9-a870-25d176163a44
Attribute Definition Reader      e007b68b-ea8b-4619-92fc-7c270d8a9562
Conditional Access Administrator e05af7e2-f97a-4fd1-bb9d-14d4843ab00f
Directory Readers                9d8400da-b63f-4cb7-b754-cff2b910a04f
Global Administrator             3cd44634-341c-4ba8-9737-83bde252db17
Global Reader                    8365a3e8-1aed-4ddc-8f77-f3fe72a48da4
Printer Administrator            406a76e1-dce2-4e7b-8026-634fab5a10b8
Security Administrator           3eefcd38-e765-4cb1-8e19-5b0b110ad5ff
Security Reader                  5840b313-a13a-4a73-9249-a0151cd6609f
User Administrator               ec7703f3-9df3-477f-afc8-d09041b171c1
#>

<#
According to the API reference docs https://docs.microsoft.com/en-us/graph/api/directoryrole-list?view=graph-rest-1.0&tabs=http,
when assigning a role using the Azure portal, the role activation step is implicitly done on the admin's behalf.
To get the full list of roles that are available in Entra ID, use List directoryRoleTemplates.

You should be using Get-MgDirectoryRoleTemplate | select DisplayName, Id | Sort-Object DisplayName to get a list of roles that are available in Entra ID.
#>
Get-MgDirectoryRoleTemplate | Select-Object DisplayName, Id | Sort-Object DisplayName

$RoleDefinitionId = (Get-MgDirectoryRoleTemplate | Where-Object displayname -Match 'security reader').id

$params = @{
    'PrincipalId'      = $principalId
    'RoleDefinitionId' = $RoleDefinitionId
    'Justification'    = 'Add eligible assignment'
    'DirectoryScopeId' = '/'
    'Action'           = 'AdminAssign'
    'ScheduleInfo'     = @{
        'StartDateTime' = Get-Date
        'Expiration'    = @{
            'Type'     = 'AfterDuration'
            'Duration' = 'PT1H'
        }
    }
}
  
New-MgRoleManagementDirectoryRoleEligibilityScheduleRequest -BodyParameter $params | Format-List *

<#
Action               : adminAssign
AppScope             : Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppScope
AppScopeId           : 
ApprovalId           : 
CompletedDateTime    : 6/10/2024 11:18:16 PM
CreatedBy            : Microsoft.Graph.PowerShell.Models.MicrosoftGraphIdentitySet
CreatedDateTime      : 6/10/2024 11:18:15 PM
CustomData           : 
DirectoryScope       : Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
DirectoryScopeId     : /
Id                   : cc06aa26-28e0-4d38-9e9f-23501f090864
IsValidationOnly     : False
Justification        : Add eligible assignment
Principal            : Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
PrincipalId          : 4b1fda38-cc2e-42e9-afd1-18f1d1887487
RoleDefinition       : Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRoleDefinition
RoleDefinitionId     : 5d6b6bb7-de71-4623-b4af-96380a352509
ScheduleInfo         : Microsoft.Graph.PowerShell.Models.MicrosoftGraphRequestSchedule
Status               : Provisioned
TargetSchedule       : Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRoleEligibilitySchedule
TargetScheduleId     : cc06aa26-28e0-4d38-9e9f-23501f090864
TicketInfo           : Microsoft.Graph.PowerShell.Models.MicrosoftGraphTicketInfo
AdditionalProperties : {[@odata.context,
                       https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleEligibilityScheduleRequests/$entity]}
#>

Get-MgRoleManagementDirectoryRoleEligibilityScheduleInstance -Filter "principalId eq '$principalId'" | Format-List

$params = @{
    'PrincipalId'      = $principalId
    'RoleDefinitionId' = $RoleDefinitionId
    'Justification'    = 'Extend eligible assignment'
    'DirectoryScopeId' = '/'
    'Action'           = 'AdminExtend'
    'ScheduleInfo'     = @{
        'StartDateTime' = Get-Date
        'Expiration'    = @{
            'Type'        = 'AfterDateTime'
            'EndDateTime' = (Get-Date).AddDays(1)
        }
    }
}
  
New-MgRoleManagementDirectoryRoleEligibilityScheduleRequest -BodyParameter $params |
    Format-List Id, Status, Action, AppScopeId, DirectoryScopeId, RoleDefinitionID, IsValidationOnly, Justification, PrincipalId, CompletedDateTime, CreatedDateTime, TargetScheduleID

Get-MgRoleManagementDirectoryRoleEligibilityScheduleInstance -Filter "principalId eq '$principalId'" | Format-List

# Connect to Microsoft Graph as Diego Siciliani
Disconnect-MgGraph
Connect-MgGraph

$params = @{
    'PrincipalId'      = $principalId
    'RoleDefinitionId' = $RoleDefinitionId
    'Justification'    = 'Activate assignment'
    'DirectoryScopeId' = '/'
    'Action'           = 'SelfActivate'
    'ScheduleInfo'     = @{
        'StartDateTime' = Get-Date
        'Expiration'    = @{
            'Type'     = 'AfterDuration'
            'Duration' = 'PT1H'
        }
    }
}
      
New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $params |
    Format-List Id, Status, Action, AppScopeId, DirectoryScopeId, RoleDefinitionID, IsValidationOnly, Justification, PrincipalId, CompletedDateTime, CreatedDateTime, TargetScheduleID
<#
Id                : 9ffed7cf-108d-4628-b3c3-5d7c7aa8e07b
Status            : PendingProvisioning
Action            : selfActivate
AppScopeId        :
DirectoryScopeId  : /
RoleDefinitionId  : 5d6b6bb7-de71-4623-b4af-96380a352509
IsValidationOnly  : False
Justification     : Activate assignment
PrincipalId       : 4b1fda38-cc2e-42e9-afd1-18f1d1887487
CompletedDateTime : 6/9/2023 1:25:38 PM
CreatedDateTime   : 6/9/2023 1:25:36 PM
TargetScheduleId  : 9ffed7cf-108d-4628-b3c3-5d7c7aa8e07b
        #>

Get-MgRoleManagementDirectoryRoleAssignmentScheduleInstance -Filter "principalId eq '$principalId'" | Format-List

$params = @{
    'PrincipalId'      = $principalId
    'RoleDefinitionId' = $RoleDefinitionId
    'Justification'    = 'Deactivate assignment'
    'DirectoryScopeId' = '/'
    'Action'           = 'SelfDeactivate'
}
  
New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $params |
    Format-List Id, Status, Action, AppScopeId, DirectoryScopeId, RoleDefinitionID, IsValidationOnly, Justification, PrincipalId, CompletedDateTime, CreatedDateTime, TargetScheduleID

# doable also as logged in as a target user
$params = @{
    'PrincipalId'      = $principalId
    'RoleDefinitionId' = $RoleDefinitionId
    'Justification'    = 'Remove eligible assignment'
    'DirectoryScopeId' = '/'
    'Action'           = 'AdminRemove'
}
      
New-MgRoleManagementDirectoryRoleEligibilityScheduleRequest -BodyParameter $params |
    Format-List Id, Status, Action, AppScopeId, DirectoryScopeId, RoleDefinitionID, IsValidationOnly, Justification, PrincipalId, CompletedDateTime, CreatedDateTime, TargetScheduleID