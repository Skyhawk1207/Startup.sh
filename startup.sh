#!/bin/bash


printf "\nRunning sudo apt update and upgrade!\n\n"
sudo apt update
sudo apt upgrade -y

printf "\nReinstalling plank!\n\n"
sudo apt purge -y plank
sudo apt install -y plank

function chrome(){
	printf "\nDownloading Chrome!\n\n"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	printf "\nInstalling Chrome!\n\n"
	sudo apt install -y ./google-chrome-stable_current_amd64.deb
	printf "\nUpdating and Upgrading again!\n\n"
	sudo apt update && sudo apt upgrade -y
	}

function edge(){
	printf "\nAdding Sources for Edge!\n\n"
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
	sudo rm microsoft.gpg
	printf "\n Installing Microsoft Edge!\n\n"
	sudo apt update && sudo apt install microsoft-edge-stable
	}

function brave(){
	printf "\nAdding Sources for Brave!\n\n"
	sudo apt install apt-transport-https curl
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update && sudo apt install brave-browser
	}

function chromium(){
	printf "\nAdding Sources for Chromium!\n\n"
	sudo echo "deb http://deb.debian.org/debian buster main">> /etc/apt/sources.list.d/debian.list
	sudo echo "deb http://deb.debian.org/debian buster-updates main" >> /etc/apt/sources.list.d/debian.list
	sudo echo "deb http://deb.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list.d/debian.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50	
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A
	sudo echo "# Note: 2 blank lines are required between entries" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Package: *" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Pin: release a=eoan" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Pin-Priority: 500" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Package: *" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Pin: origin "ftp.debian.org"" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Pin-Priority: 300" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " # Pattern includes 'chromium', 'chromium-browser' and similarly" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " # named dependencies:" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Package: chromium*" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Pin: origin "ftp.debian.org"" >> /etc/apt/preferences.d/chromium.pref
	sudo echo " Pin-Priority: 700" >> /etc/apt/preferences.d/chromium.pref

	printf "\n\n Installing Chromium Browser!\n\n"
	sudo apt update
	sudo apt install -y chromium
	}

function opera(){
	printf "\nAdding Sources for Opera!\n\n"
	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
	sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
	printf "\nInstalling Opera Browser!\n\n"
	sudo apt install opera-stable
	}

function browser(){
	if [[ $1 = "1" ]];then
		chrome
	else
		if [[ $1 = "2" ]];then
		edge
		else
			if [[ $1 = "3" ]];then
			chromium
			else
				if [[ $1 = "4" ]];then
				brave
				else
					if [[ $1 = "5" ]];then
					opera
					else
						if [[ $1 = "6" ]];then
						printf "\nDone Installing!\n"
						else	
						printf "\nInvalid choice!\n"
						fi
					fi
				fi
			fi
		fi
	fi
	} 

printf "\nInstalling curl!\n\n"
sudo apt install -y curl
  
printf "\nChoose a browser to install -\n"
printf "1. Chrome      4. Brave\n"
printf "2. Edge        5. Opera\n"
printf "3. Chromium    0. MULTI BROWSER MODE\n"
printf "Your Choice : "
read choice

if [[ $choice = 0 ]];then
	mulchoice=0
	while [[ $choice = 0 ]];do
			printf "\n\nChoose a browser to install [MULTI BROWSER MODE] -\n"
			printf "1. Chrome      4. Brave\n"
			printf "2. Edge        5. Opera\n"
			printf "3. Chromium    6. Done Installing.\n"
			printf "Your Choice : "
			read mulchoice
			if [[ $mulchoice = 6 ]];then
                break
            else
			    browser $mulchoice
			fi
	done
fi


printf "\nInstalling git!\n\n"
sudo apt install -y git
mkdir ${HOME}/github
cd ${HOME}/github

y=0
while [[ $y = 0 ]]; do
	printf "\n\nPlease choose a theme to install : \n1. Fluent Gtk Theme \n2. Orchis Theme\n3. No Theme \n\nPlease choose: "
	read choice
	if [[ $choice = 1 ]];then
		printf "\nGetting Fluent Gtk Theme!\n\n"
		git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
		printf "\nGetting Fluent Icon Theme!\n\n"
		git clone https://github.com/vinceliuice/Fluent-icon-theme.git
		printf "\nInstalling the theme and icons!\n\n"
		cd
		sudo ./github/Fluent-gtk-theme/install.sh
		sudo ./github/Fluent-icon-theme/install.sh
    	printf "\nInstalled! Would you like to apply the theme automatically? (y/n) - "
    	read auto_theme
    	if [[ $auto_theme = "y" ]]; then
			printf "\nApplying the theme! \n\n"
    		dconf write /org/mate/desktop/interface/gtk-theme "'Fluent-dark'"
    		dconf write /org/mate/marco/general/theme "'Fluent-dark'"
    		dconf write /org/mate/desktop/interface/icon-theme "'Fluent-dark'"
    		printf "\n\nDone!\n"
    	else
    		 printf "\nYou can now change the theme from the Control Center!\n"
    	fi
		y=1
	else
		if [[ $choice = 2 ]];then
			printf "\nGetting Orchis Theme!\n\n"
			git clone https://github.com/vinceliuice/Orchis-theme.git
			printf "\nGetting Tela Circle Icon Theme!\n\n"
			git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
			printf "\nInstalling the theme and icons!\n\n"
			cd
			sudo ./github/Orchis-theme/install.sh
			sudo ./github/Tela-circle-icon-theme/install.sh
			printf "\nInstalled! Would you like to apply the theme automatically? (y/n) - "
			read auto_theme
		   	if [[ $auto_theme = "y" ]]; then
				printf "\nApplying the theme! \n\n"
		   		dconf write /org/mate/desktop/interface/gtk-theme "'Orchis-dark'"
		   		dconf write /org/mate/marco/general/theme "'Orchis-dark'"
		   		dconf write /org/mate/desktop/interface/icon-theme "'Tela-circle-dark'"
		   		printf "\n\nDone!\n"
		   	else
				printf "\nYou can now change the theme from the Control Center!\n"
			fi
			y=1
		else
			if [[ $choice = 3 ]];then
				printf "\nContinuing with no theme!\n"
				y=1
			else
				printf "\nInvalid choice!\n"
			fi
		fi
	fi
done

printf "\nInstall Slaze Grub2 theme and Plymouth Animations(y/n) - "
read answer
if [[ $answer = "y" ]]; then
	cd ${HOME}/github
	printf "\n\nGetting Vimix (Slaze) Grub2 Theme!\n\n"
	git clone https://github.com/vinceliuice/grub2-themes.git
	printf "\n\nInstalling Theme!\n\n"
	cd
	
	sudo ./github/grub2-themes/install.sh -b -t slaze
	cd github
	printf "\n\nGetting Plymouth Themes!\n\n"
	git clone https://github.com/adi1090x/plymouth-themes.git

	printf "\n\nFor reference for following questions - https://github.com/adi1090x/plymouth-themes.git\n"
	printf "Please select the pack with your prefered theme (1,2,3,4) - "
	read pack
	pack_path="pack_"$pack
	printf "\nPlease enter the name of the theme (correct spelling and lower case) - " 	
	read theme

	theme_path=${HOME}/github/plymouth-themes/${pack_path}/${theme}

	printf "\n\nCopying theme to /usr/share/plymouth/themes!\n\n"
	sudo cp -r ${theme_path} /usr/share/plymouth/themes/
	printf "\nInstalling theme!\n\n"
	sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/${theme}/${theme}.plymouth 100
	printf "\nApplying the theme!\n\n"
	sudo update-alternatives --config default.plymouth
	printf "\nUpdating initramfs!\n\n"
	sudo update-initramfs -u

	printf "\nPlymouth Theme Installed!\n"
	printf "\nRemove remaining themes? (y/n) - "
	read option
	if [[ $option = "y" ]];then
		rm -rf ${HOME}/github/plymouth-themes/
		printf "\nDeleted!"
	fi
else
	printf "\nKeeping the themes!\n\n"
fi

printf "\nInstalling rofi and exo-open!\n\n"
sudo apt install -y rofi
sudo apt install -y exo-utils
printf "\nConfiguring rofi finder!\n\n"
git clone https://github.com/davatorium/rofi-scripts.git
chmod +x ${HOME}/github/rofi-scripts/rofi-finder/finder.sh
sudo mv ${HOME}/github/rofi-scripts/rofi-finder/finder.sh /usr/local/bin/finder
rm -rf ${HOME}/github/rofi-scripts
printf "\nInstalling Artha!\n\n"
sudo apt install -y artha
printf "\nInstalling Microsoft fonts!\n\n"
sudo apt install -y ttf-mscorefonts-installer
printf "\nInstalling Ubuntu Software Center!\n\n"
sudo apt install -y ubuntu-software
printf "\nInstalling Synaptic Package Manager!\n\n"
sudo apt install -y synaptic
printf "\nInstalling VLC!\n\n"
sudo apt install -y vlc
printf "\nRemoving snap packages!\n\n"
sudo apt purge -y snapd
printf "\nCleaning unnecessary packages!\n\n"
sudo apt -y autoremove && sudo apt autoclean
printf "\nSetting swappiness to 10.\n"
sudo bash -c "echo 'vm.swappiness = 10' >> /etc/sysctl.conf"
sudo sysctl -p

printf "\nDone! All the things this script can do is over."
printf "\nHere's some more things you can do -"
printf "\n1. Customize Plank. \n2. Add keyboard shortcut for window change, browser and Caja."
printf "\n3. Add keyboard shortcut for rofi application launcher (Suggested shortcut - (Super+Space).\n   Here's the command - rofi -show drun"
printf "\n4. Add keyboard shortcut for rofi file search (Suggested shortcut - (Super+F).\n   Here's the command - rofi -show find -modi find:finder"
printf "\n5. Configure Artha and add it to Startup Applications."
printf "\n6. Customize panel."
printf "\n7. Check for drivers and check apt sources."
printf "\n8. Configure firewall."
printf "\n9. Configure Windscribe VPN."
printf "\n10. Reboot!"
printf "\nFinally, enjoy the experience!"
