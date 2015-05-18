# Install OctopusClient
$MsiUrl = "http://download.octopusdeploy.com/octopus/Octopus.Tentacle.2.4.8.107-x64.msi"
 
$octopusclientInstalled = $false
try {
  $ErrorActionPreference = "Stop";
  Get-Command octopusclient | Out-Null
  $octopusclientInstalled = $true
  $octopusclientVersion=&octopusclient "--version"
  Write-Host "octopusclient $octopusclientVersion is installed. This process does not ensure the exact version or at least version specified, but only that octopusclient is installed. Exiting..."
  Exit 0
} catch {
  Write-Host "Octopus Client is not installed, continuing..."
}
 
if (!($octopusclientInstalled)) {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  if (! ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Host -ForegroundColor Red "You must run this script as an administrator."
    Exit 1
  }
 
  # Install it - msiexec will download from the url
  $install_args = @("/qn", "/norestart","/i", $MsiUrl)
  Write-Host "Installing Cctopus Client. Running msiexec.exe $install_args"
  $process = Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
  if ($process.ExitCode -ne 0) {
    Write-Host "Installer failed."
    Exit 1
  }
 
  # Stop the service that it autostarts
  Write-Host "Stopping Octopus Client service that is running by default..."
  Start-Sleep -s 5
  Stop-Service -Name octopusclient
 
  Write-Host "octopusclient successfully installed."
}