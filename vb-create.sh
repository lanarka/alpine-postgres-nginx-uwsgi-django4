MACHINENAME=test-pc

VBoxManage createvm \
	--name $MACHINENAME \
	--ostype "Linux_64" \
	--register \
	--basefolder /tmp/`pwd`

VBoxManage modifyvm $MACHINENAME --nic1 bridged --nictype1 virtio  --bridgeadapter1 enp0s31f6
VBoxManage modifyvm $MACHINENAME --memory 4096 --vram 128 --cpus 2 --biosbootmenu disabled --boot1 disk

VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" \
	--port 0 --device 0 --type hdd --medium  mach.vmdk
