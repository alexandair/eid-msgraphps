
# LAB: Programatically grant app role to an application (script)

<# TASK

Your task is to write a code that will grant the "Application.Read.All" app role to the "Graph PSTraining Script" application.

You will need IDs of the "Microsoft Graph" service principal and the "Graph PSTraining Script" service principal.
And the identifier of the "Application.Read.All" permission.

Pass a hash table with the following parameters to the New-MgServicePrincipalAppRoleAssignment cmdlet:

$params = @{
  'PrincipalId' = $sp.Id
  'ResourceId'  = $graph.Id
  'AppRoleId'   = $appRole.Id
}

Check the result in the Azure portal or Entra portal.

Modify the script from the previous lab to also list all the applications, not just users and groups.

Test the script.

#>