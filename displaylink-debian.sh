#!/bin/bash
#
# DisplayLink driver installer for Debian (Stretch)
#
# Copyleft: Adnan Hodzic <adnan@hodzic.org>
# License: GPLv3

driver_dir=1.0.138
mkdir -p $driver_dir

install(){
echo -e "\nDownloading DisplayLink Ubuntu driver:"
wget http://downloads.displaylink.com/publicsoftware/DisplayLink-Ubuntu-1.0.138.zip

# prep
echo -e "\nPrepring for install ...\n"
unzip -d $driver_dir DisplayLink-Ubuntu-1.0.138.zip
chmod +x $driver_dir/displaylink-driver-1.0.138.run
./$driver_dir/displaylink-driver-1.0.138.run --keep --noexec

# prep2
mv displaylink-driver-1.0.138/ $driver_dir/displaylink-driver-1.0.138
cp -f displaylink-installer.sh $driver_dir/displaylink-driver-1.0.138

# install
echo -e "\nInstalling ... \n"
cd $driver_dir/displaylink-driver-1.0.138 && sudo ./displaylink-installer.sh install

echo -e "\nInstall complete\n"
}

# uninstall
uninstall(){

# ToDo: add confirmation before uninstalling?
echo -e "\Uninstalling ...\n"

cd $driver_dir/displaylink-driver-1.0.138 && sudo ./displaylink-installer.sh uninstall
sudo rmmod evdi

# clean-up
# ToDo: 
# find and display dir/file for cleanup
# after confirmation delete them
#
#echo -e "Performing clean-up"
#rm -r $driver_dir
#rm DisplayLink-Ubuntu-1.0.138.zip

echo -e "\nUninstall complete\n"
}

echo -e "\nDisplayLink driver for Debian Stretch (kernel 4.2)\n"

read -p "[I]nstall
[U]ninstall

Select a key: [i/u]: " answer

if [[ $answer == [Ii] ]];
then
	install
elif [[ $answer == [Uu] ]];
then
	uninstall
else
	echo -e "\nWrong key, aborting ...\n"
	exit 1
fi
