param([Switch]$WaitForKey)

Function Move-IfExists($path)
{
	if (Test-Path -Path "$path")
	{
		Move-Item -Path "$path" "$path.bak"
	}
}

if (([Version](Get-CimInstance Win32_OperatingSystem).version).Major -lt 10)
{
    Write-Host -ForegroundColor Red "The DeveloperMode is only supported on Windows 10"
    exit 1
}

# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($myWindowsPrincipal.IsInRole($adminRole))
{

    $RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
    if (! (Test-Path -Path $RegistryKeyPath)) 
    {
        New-Item -Path $RegistryKeyPath -ItemType Directory -Force
    }

    if (! (Get-ItemProperty -Path $RegistryKeyPath -Name AllowAllTrustedApps))
    {
        # Add registry value to enable side loading
        New-ItemProperty -Path $RegistryKeyPath -Name AllowAllTrustedApps -PropertyType DWORD -Value 1
    }

    if (! (Get-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense))
    {
        # Add registry value to enable Developer Mode
        New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1
    }
    $feature = Get-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online
    if ($feature -and ($feature.State -eq "Disabled"))
    {
        Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -All -LimitAccess -NoRestart
    }

    if ($WaitForKey)
    {
        Write-Host -NoNewLine "Press any key to continue..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}
else
{
   # We are not running "as Administrator" - so relaunch as administrator
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

   # Specify the current script path and name as a parameter
   $newProcess.Arguments = "-NoProfile",$myInvocation.MyCommand.Definition,"-WaitForKey";

   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";

   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);

   # Exit from the current, unelevated, process
   exit
}



foreach ($line in Get-Content .\packages)
{
    &"Install-Module $line"
}

# Make a link for vim
Move-IfExists("~/vimfiles")
New-Item -Type SymbolicLink -Path "~/vimfiles" -Target "$PSScriptRoot/vim"

Move-IfExists("~/_vimrc")
New-Item -Type SymbolicLink -Path "~/_vimrc" -Target "$PSScriptRoot/vim/vimrc"

# Make a link for powershell
Move-IfExists("$HOME/Documents/WindowsPowershell")
New-Item -ItemType Directory -Force -Path "$HOME/Documents/Powershell"
New-Item -Type SymbolicLink -Path "$HOME/Documents/WindowsPowershell" -Target "$HOME/Documents/Powershell"
Move-IfExists("$HOME/Documents/Powershell/Microsoft.PowerShell_profile.ps1")
New-Item -Type SymbolicLink -Path "$HOME/Documents/Powershell/Microsoft.PowerShell_profile.ps1" -Target "$PSScriptRoot/powershell/powershell-profile.ps1"
Move-IfExists("$HOME/Documents/Powershell/.ps1")
New-Item -Type SymbolicLink -Path "$HOME/Documents/Powershell/powershellprofile-local.ps1" -Target "$PSScriptRoot/powershell/powershellprofile-local.ps1"
