# LAB: Migrate from AzureAD PowerShell to Microsoft Graph PowerShell

#region Revoke all permissions granted to the application
# This is a PowerShell code you get when you click in the Entra portal:
# AAD > Enterprise applications > All applications > TrainingApp > Permissions > Review permissions > This application has more permissions than I want

Connect-AzureAD

# Get Service Principal using objectId
$sp = Get-AzureADServicePrincipal -ObjectId "dc3bda93-4a18-4a8f-8d04-55fef196047c"

# Get all delegated permissions for the service principal
$spOAuth2PermissionsGrants = Get-AzureADOAuth2PermissionGrant -All $true| Where-Object { $_.clientId -eq $sp.ObjectId }

# Remove all delegated permissions
$spOAuth2PermissionsGrants | ForEach-Object {
    Remove-AzureADOAuth2PermissionGrant -ObjectId $_.ObjectId
}

# Get all application permissions for the service principal
$spApplicationPermissions = Get-AzureADServiceAppRoleAssignedTo -ObjectId $sp.ObjectId -All $true | Where-Object { $_.PrincipalType -eq "ServicePrincipal" }

# Remove all application permissions
$spApplicationPermissions | ForEach-Object {
    Remove-AzureADServiceAppRoleAssignment -ObjectId $_.PrincipalId -AppRoleAssignmentId $_.objectId
}
#endregion

<# TASK

The above code is based on Azure AD PowerShell cmdlets. Convert it to Microsoft Graph PowerShell cmdlets.
Hints:
- Consult the Cmdlet Map (https://learn.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map)
- Use Find-MgGraphCommand and Find-MgGraphPermission to find the equivalent cmdlets and permissions
- Use Get-Command or Get-Help to learn a syntax of a cmdlet

#>