@ECHO OFF

:: Read input parameters. The first is the name of the virtual machine.
SET VM_NAME=%1

SET UBUNTU_ISO="D:\ISO-files\ubuntu-18.04.4-live-server-amd64.iso"
SET VM_HDD="%VM_NAME%_disk.vdi"


ECHO ...............................................
ECHO Creating Virtual Machine %VM_NAME%
ECHO ...............................................
:: Create the VM
VBoxManage createvm --name %VM_NAME% --ostype "Ubuntu_64" --register

:: Set the number of virtual CPUs
VBoxManage modifyvm %VM_NAME% --cpus 2
:: Set RAM and video memory to 32MB
VBoxManage modifyvm %VM_NAME% --memory 2048 --vram 32
ECHO.

:: Setup VM ACPI support ON and Network Interface to Bridged mode
VBoxManage modifyvm %VM_NAME% --ioapic on
VBoxManage modifyvm %VM_NAME% --nic1 bridged --bridgeadapter1 "Intel(R) Ethernet Connection (7) I219-V"
VBoxManage modifyvm %VM_NAME% --nicpromisc1 allow-all
VBoxManage modifyvm %VM_NAME% --audio none
ECHO.

ECHO ...............................................
ECHO Creating a 32GB dynamic disk
ECHO ...............................................
:: Create a 32GB vdi "dynamic" disk.
:: VDI is the format used by VirtualBox
:: VHD is the format used by Microsoft products
:: VMDK is the format used by VMWare products
VBoxManage createhd --filename %VM_HDD% --size 32768 --format VDI
ECHO.

:: Add SATA controller with the dynamic disk attached
VBoxManage storagectl %VM_NAME% --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach %VM_NAME% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  %VM_HDD%
ECHO.

:: Add an IDE controller with a DVD drive attached, and the install ISO inserted into the drive:
VBoxManage storagectl %VM_NAME% --name "IDE Controller" --add ide
VBoxManage storageattach %VM_NAME% --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium %UBUNTU_ISO%
ECHO.

:: Set the boot order
VBoxManage modifyvm %VM_NAME% --boot1 dvd --boot2 disk --boot3 none --boot4 none
ECHO.

:: Finallly start the new MV
ECHO ...............................................
ECHO Starting Virtual Machine: %VM_NAME%
ECHO ...............................................
VBoxManage startvm %VM_NAME% --type headless
ECHO.

pause
