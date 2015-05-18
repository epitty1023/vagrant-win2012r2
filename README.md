win2012_vagrant-deployment
=============

Vagrant can be used to deploy an operating system environment using VirtualBox, vmware and HyperV, this deployment repo will help you configure a windows 2012 base box in your local machine with a few steps.

<b>Dependencies (Windows7)</b><br>
VirtualBox   Download URL= https://www.virtualbox.org/wiki/Downloads<br>
Ruby   -download URL = http://rubyinstaller.org/<br>
ruby gems  - download URL = http://rubygems.org/pages/download<br>
git    Download URL= http://git-scm.com/download/win  (command line)  or  https://windows.github.com/ (gui)<br>
or  use powershell as your terminal emulator to run your commands.

on Windows make sure to add the PATH variable  = \path\to\Vagrant\embedded\gnuwin32\bin<br>
<img src=http://www.computerhope.com/issues/pictures/winpath.jpg><br>
1. From the Desktop, right-click My Computer and click Properties.<br>
2. Click Advanced System Settings link in the left column.<br>
3. In the System Properties window click the Environment Variables button.<br>
Windows enviromental path settings.<br>
This will prevent getting errors uncompressing the .box file.<br>

<b>Dependencies (MAC)</b><br>
VirtualBox     Download URL= https://www.virtualbox.org/wiki/Downloads<br>
git   #brew install git  (command terminal)
ruby

<b>Plugins needed in vagrant</b><br>
vagrant plugin install unf<br>
vagrant plugin install vagrant-aws<br>
vagrant plugin install vagrant-windows<br>

<b>Deployment Steps</b><br>
Step 1 - Bring the project settings into your machine

$git clone git@github.com:GCC-CM/win2012deploy.git<br>

Step 2 – Working Locally

use Vagrant to create & provision your local environment:

$ vagrant up<br>
Once the local deployment has completed you should be able to see your project in the URL http://local.project.dev (or 172.16.16.16)!

If the site doesn't load for you, you may have to manually provision your local machine:

$ vagrant provision<br>
Or, update your local /etc/hosts with Vagrant Host Manager:

$ vagrant hostmanager<br>
vagrant hostmaster uses your host file and add the project name to the /etc/hosts file, "in windows" c:/windows/systems32/drivers/etc/host

$ vagrant reload<br>
Vagrant reload will simply to what it say it will rebot the virtual machine.

Step 3 – Wrapping Up

When you're done working on your site, suspend the VM to save on CPU & memory:

$ vagrant suspend<br>
You can destroy the VM entirely (while keeping your local files) to save on disk space:

$ vagrant destroy<br>
Vagrant Destroy will completely remove the virtual machine, if you are absolutely sure yo udon't need to use it, sure go ahead,  if you are going to use it again,  I recommend keep it.  anyways  you can always do a vagrant up and rebuild it.
