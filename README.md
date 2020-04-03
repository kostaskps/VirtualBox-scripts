# VirtualBox scripts
This project is a collection of usefull scripts that can help Developers as well DevOps engineers to create and spin up some virtual machines for their development or testing scenarios via the VirtualBox.

## Getting Started
The following instructions will help you setup your local environment

### Prerequisites
Download and install
* **Oracle VM VirtualBox** - [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)

### Add VBoxManage.exe to your PATH environment
Add installation directory to your PATH
1. Right click you computer icon => Select **Advanced system settings** => Press button **Environment Variables**
2. In the dialog that opens, find the variable **PATH** and double click on it or press the button edit
3. Press button **NEW** and set the installation directory of VBox, it should be 
```
C:\Program Files\Oracle\VirtualBox\
```
4. Press OK

### Verify that VBoxManage.exe is available
You should now be able to run VBoxManage.exe from the command prompt.
Open the command prompt and run
```
VBoxManage --version
```
The output should be the version of the application, something like 6.1.4r136177

## Examples
### CreateUbuntuVM
* Create an Ubuntu(64-bit) virtual machine with 2 CPU's, 2GB RAM, with 32GB dynamic disk attached.
  Open the command prompt and run
  ```
  CreateUbuntuVM <name of vm>
  ```
  This will create a new virtual machine with the above specs and it will start the installation process