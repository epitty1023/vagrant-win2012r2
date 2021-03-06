Package {
  provider => chocolatey,
}
  
# ensure that my user is present and an Admin (maybe with a different pwd)
#user { $hostuser : # look in VagrantFile, this is set to the user running the host; clever eh?
  ensure => "present",
  groups => ["Administrators"],
  user => vagrant
  password => "vagrant"
}
  
# install notepad++
package { "notepadplusplus" :
  ensure => "latest"
}
  
# ... other packages here...