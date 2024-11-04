## Task: Create Users and Manage Group Membership

1. **Create Two Users**:
    - Use the `New-MgUser` cmdlet to create two users. Set the necessary properties such as `DisplayName`, `UserPrincipalName`, `MailNickname`, and `PasswordProfile`.

    ```powershell
    $user1 = New-MgUser -DisplayName "User One" -UserPrincipalName "userone@mo3ak.onmicrosoft.com" -MailNickName "userone" -AccountEnabled -PasswordProfile @{Password = "P@ssw0rd!"}

    $user2 = New-MgUser -DisplayName "User Two" -UserPrincipalName "usertwo@mo3ak.onmicrosoft.com" -MailNickname "usertwo" -AccountEnabled -PasswordProfile @{Password = "P@ssw0rd!"}
    ```

2. **Create a Security Group**:
    - Use the `New-MgGroup` cmdlet to create a security group and add the first user as a member.

    ```powershell
    $groupParams = @{
        DisplayName = "SG-Lab04"
        MailEnabled = $false
        SecurityEnabled = $true
        MailNickname = "sg-lab04"
        "Members@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user1.Id)")
    }
    $group = New-MgGroup -BodyParameter $groupParams
    ```

3. **Add Second User to the Existing Group**:
    - Use the `New-MgGroupMember` cmdlet to add the second user to the existing group.

    ```powershell
    New-MgGroupMember -GroupId $group.Id -DirectoryObjectId $user2.Id
    ```

4. **Verify Group Membership**:
    - Use the `Get-MgGroupMember` cmdlet to verify that both users are members of the group.

    ```powershell
    Get-MgGroupMember -GroupId $group.Id | Select-Object -ExpandProperty AdditionalProperties
    ```
Can you do a group membership verification using the `Get-MgGroup` cmdlet?

Complete these steps to successfully create and manage users and group memberships using Microsoft Graph PowerShell.