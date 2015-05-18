# Install Installing IIS Rewrite Module
$MsiUrl = "https://s3.amazonaws.com/GCC_vagrant/rewrite_2.0_rtw_x64.msi"

  # Install it - msiexec will download from the url
  $install_args = @("/qn", "/norestart","/i", $MsiUrl)
  Write-Host "Installing IIS Rewrite Module. Running msiexec.exe $install_args"
  $process = Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
  if ($process.ExitCode -ne 0) {
    Write-Host "Installer failed."
    Exit 1
  }
 
  Write-Host "IIS Rewrite Module was successfully installed."
