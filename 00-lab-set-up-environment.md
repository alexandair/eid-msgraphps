# LAB: How to set up your environment

## Log in to your lab VM

Perform the following steps on your laptop: 
1. Open https://labs.azure.com in your browser.
2. Sign in using the credentials provided by an instructor
3. The instructor will approve a login on his Microsoft Authenticator
4. If the **MSGraphPSLabVM** tile doesn't show "Running", click the toggle button showing "Stopped" to start the VM. Wait for a couple of minutes. Refresh the page, if the status doesn't change to "Running"
5. If the **MSGraphPSLabVM** tile shows "Running", click the icon next to the "Running" button to download an RDP file you will use to connect to your lab VM
6. Log in to your lab VM as "labuser" using the password provided by the instructor

## Install the required applications

Perform the following steps on your lab VM.

Install/update Windows Package Manager (winget) via App Installer using the instructions at
https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget

1. Open the Power User menu (Win+X) and select **Terminal**.
Windows PowerShell session will start.
2. Install the required applications using Windows Package Manager (winget).

```powershell
winget install microsoft.powershell # UAC is required
winget install git.git
winget install Microsoft.VisualStudioCode
```

3. Close Windows Terminal.
4. Open the Power User menu (Win+X) and select **Terminal** again.
5. Change default profile to be PowerShell instead of Windows PowerShell.
(Settings > Startup > Default profile > PowerShell)
6. Click **Save** and close Windows Terminal.
7. Open Windows Terminal again.
It should open PowerShell tab now.

Proceed with the installation of Visual Studio Code extensions.

## Install Visual Studio Code extensions

Open another PowerShell tab.
Run the following commands.

```powershell
# Installation of the Visual Studio Code extensions from the command line
code --install-extension ms-vscode.powershell # PowerShell
```

More details about the extension:

[PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)


## Download the lab files from the eid-msgraphps GitHub repo

```powershell
cd\
git clone https://github.com/alexandair/eid-msgraphps
cd eid-msgraphps
# open Visual Studio Code; click 'Yes, I trust the authors'
code .
```




