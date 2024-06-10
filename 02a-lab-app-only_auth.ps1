#region LAB: Configuring app-only access for a simple script to list users and groups in your Microsoft 365 tenant

# Use this method to authenticate from an application running from your machine
# For example, authenticate from PowerShell 7 or Windows PowerShell

# You can later run your script from PowerShell 7, BUT PERFORM THE FOLLOWING STEPS IN WINDOWS POWERSHELL

$cert = New-SelfSignedCertificate -Subject "CN=PowerShellTrainingCert" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256

$certPath = "C:\eid-msgraphps\PowerShellTrainingCert.cer"

Export-Certificate -Cert $cert -FilePath $certPath

# Register the application

# First, you're using the PowerShell SDK with delegated access, logging in as an administrator, and creating the app registration.
# Then, using that app registration, you're able to use the PowerShell SDK with app-only access, allowing for unattended scripts.

cd c:\eid-msgraphps
code .\RegisterAppOnly.ps1

.\RegisterAppOnly.ps1 -AppName "Graph PSTraining Script" -CertPath $certPath

# Follow the instructions in the output to grant admin consent.

# Authenticate using the Connect-MgGraph command in the output to test if you can connect to Microsoft Graph using app-only access.

Get-MgContext

Disconnect-MgGraph

# Write a script to list users and groups in your Microsoft 365 tenant
# Output should contain only users' and groups' IDs and display names.
# Don't forget to authenticate in your script using the Connect-MgGraph command in the output of RegisterAppOnly.ps1.
# Don't forget to disconnect from Microsoft Graph at the end of your script.

# Test your script. 

#endregion