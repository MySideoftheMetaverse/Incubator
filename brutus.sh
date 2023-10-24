#!/bin/bash
# Script Name: install_script.sh
# Description: This script automates the installation of various packages and tools.
# Author: Your Name
# Date: 2023-10-24
# Version: 1.0
set -e

# Define an array of categories
categories=("Compatibility Layer" "Entertainment" "Emulators" "\*Arr .NET" "Amenities" "Tools" "Blackbox")

# Function to display package options for Blackbox
display_blackbox_options() {
    echo "Blackbox:"
    echo "1. Install h8mail"
    echo "2. Install Keylogger"
    echo "3. Install Search.0t.rocks"
    echo "4. Install VeraCrypt Container"
    # Add more options as needed
}

# Function to install Eggs
install_eggs() {
    git clone https://github.com/pieroproietti/addaura
    cd addaura
    sudo ./addaura.sh
}

# Define an array of packages in each category
compatibility_layer=("Bedrock Linux")
entertainment=("Jellyfin" "Notifiarr" "RetroPie Emulator")
emulators=("Cassowary" "Darling")
dotnet_arr=("Lidarr" "Prowlarr" "Radarr" "Readarr" "Whisparr")

# Function to install Kali Repos
install_kali_repos() {
    echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list
}

# Function to install Homebrew
install_homebrew() {
    sudo apt install build-essential procps curl file git
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/user_name/.profile
    echo "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew update
    brew install gcc
}

# Function to install Thefuck
install_thefuck() {
    brew install thefuck
    sudo apt install thefuck
}

# Function to install Birthday
install_birthday() {
    sudo npm install --global birthday
}

# Function to install Onetimeshare
install_onetimeshare() {
    brew install ots
}

# Function to install Undollar
install_undollar() {
    sudo npm install -g undollar
}

# Function to install Google Font Installer
install_google_font_installer() {
    sudo npm install -g google-font-installer
}

# Function to install Nipe for Tor
install_nipe_for_tor() {
    sudo apt install cpanminus tor 
    git clone https://github.com/htrgouvea/nipe && cd nipe
    sudo cpanm --installdeps .
    sudo perl nipe.pl install
    sudo perl nipe.pl start
}

# Function to display package options for Amenities
display_amenities_options() {
    echo "Amenities:"
    for i in "${!amenities_packages[@]}"; do
        echo "$((i+1)). ${amenities_packages[i]}"
    done
}

# Function to install Bedrock Linux
install_bedrock_linux() {
    wget https://github.com/bedrocklinux/bedrocklinux-userland/releases/download/0.7.29/bedrock-linux-0.7.29-x86_64.sh
    sudo chmod +x bedrock-linux-0.7.29-x86_64.sh
    sudo sh bedrock-linux-0.7.29-x86_64.sh --hijack
}

# Function to install Cassowary
install_cassowary() {
git clone https://github.com/casualsnek/cassowary
cd cassowary
chmod +x buildall.sh
./buildall.sh


sudo sed -i "s/#user = \"root\"/user = \"$(id -un)\"/g" /etc/libvirt/qemu.conf
sudo sed -i "s/#group = \"root\"/group = \"$(id -gn)\"/g" /etc/libvirt/qemu.conf
sudo usermod -a -G kvm $(id -un)
sudo usermod -a -G libvirt $(id -un)
sudo systemctl restart libvirtd
sudo ln -s /etc/apparmor.d/usr.sbin.libvirtd /etc/apparmor.d/disable/

wget https://gitlab.com/apparmor/apparmor/-/raw/master/profiles/apparmor.d/usr.sbin.dnsmasq -O ~/usr.sbin.dnsmasq
sudo mv ~/usr.sbin.dnsmasq /etc/apparmor.d/
sudo sed -i "s/\/usr\/libexec\/libvirt_leaseshelper m,/\/usr\/libexec\/libvirt_leaseshelper mr,/g" /etc/apparmor.d/usr.sbin.dnsmasq

mkdir -p ~/.config/libvirt
echo "uri_default = \"qemu:///system\"" >> ~/.config/libvirt/libvirt.conf

wget https://github.com/casualsnek/cassowary/releases/download/0.6/cassowary-0.6-py3-none-any.whl
wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1c0quJMKV1MCw1HzWYvMWzPUHOYIHuz7y' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1c0quJMKV1MCw1HzWYvMWzPUHOYIHuz7y -O Win10.iso && rm -rf /tmp/cookies.txt

sudo apt install python3 python3-pip freerdp2-x11
pip3 install PyQt5 --break-system-packages

pip install cassowary* --break-system-packages
echo "PATH=\$PATH:$HOME/.local/bin" >> $HOME/.profile

echo 'you will have to complete setup manually'
}

# Function to install Darling
install_darling() {
    echo "Installing Darling..."
    sudo apt install cmake clang bison flex xz-utils libfuse-dev libudev-dev pkg-config libc6-dev-i386 libcap2-bin git git-lfs libglu1-mesa-dev libcairo2-dev libgl1-mesa-dev libtiff5-dev libfreetype6-dev libxml2-dev libegl1-mesa-dev libfontconfig1-dev libbsd-dev libxrandr-dev libxcursor-dev libgif-dev libpulse-dev libavformat-dev libavcodec-dev libswresample-dev libdbus-1-dev libxkbfile-dev libssl-dev llvm-dev
    git clone --recursive https://github.com/darlinghq/darling.git

    git lfs install
    git pull
    git submodule update --init --recursive

    # Move into the cloned sources
    cd darling

    # Remove prior install of Darling
    tools/uninstall

    # Make a build directory
    mkdir build && cd build

    # Configure the build
    cmake ..

    # Build and install Darling
    make
    sudo make install
}


# Function to install Go
install_go() {
    echo "Installing Go..."
    wget https://golang.org/dl/go1.20.2.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz
    echo "export PATH=/usr/local/go/bin:${PATH}" | sudo tee -a $HOME/.profile
    source $HOME/.profile
    echo "Go installation completed."
}


# Function to install Miniconda
install_miniconda() {
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
}

# Function to install Waydroid
install_waydroid() {
    curl -s https://gist.githubusercontent.com/cniw/7a0220ce8b75368f7f57aa422d3fea97/raw | bash
}

# Function to install Wine
install_wine() {
    sudo dpkg --add-architecture i386 
    sudo mkdir -pm755 /etc/apt/keyrings
    sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
    sudo apt update
    sudo apt install --install-recommends winehq-stable
}

# Function to install Git LFS
install_git_lfs() {
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
}

# Function to install Flatpak Repos
install_flatpak_repos() {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

# Function to install Rust
install_rust() {
    curl https://sh.rustup.rs -s | sh
}

# Function to install Jellyfin
install_jellyfin() {
    curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
    sudo setfacl -m u:jellyfin:rx /media/sean.
}

# Function to install Notifiarr
install_notifiarr() {
    curl -s https://golift.io/repo.sh | sudo bash -s - notifiarr
}

# Function to install RetroPie Emulator
install_retropie() {
    git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
    sudo ./RetroPie-Setup/retropie_setup.sh
    rm -rf RetroPie-Setup
}

# Function to install \*Arr .NET applications
install_arr_net() {
   scriptversion="3.0.9a"
scriptdate="2023-07-14"

set -euo pipefail

echo "Running \*Arr Install Script - Version [$scriptversion] as of [$scriptdate]"

# Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

echo "Select the application to install: "

select app in lidarr prowlarr radarr readarr whisparr quit; do

    case $app in
    lidarr)
        app_port="8686"                                          # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3 libchromaprint-tools mediainfo" # Required packages
        app_umask="0002"                                         # UMask the Service will run as
        branch="master"                                          # {Update me if needed} branch to install
        break
        ;;
    prowlarr)
        app_port="9696"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="master"          # {Update me if needed} branch to install
        break
        ;;
    radarr)
        app_port="7878"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="master"           # {Update me if needed} branch to install
        break
        ;;
    readarr)
        app_port="8787"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="develop"          # {Update me if needed} branch to install
        break
        ;;
    whisparr)
        app_port="6969"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="nightly"          # {Update me if needed} branch to install
        break
        ;;
    quit)
        exit 0
        ;;
    *)
        echo "Invalid option $REPLY"
        ;;
    esac
done

# Constants
### Update these variables as required for your specific instance
installdir="/opt"              # {Update me if needed} Install Location
bindir="${installdir}/${app^}" # Full Path to Install Location
datadir="/var/lib/$app/"       # {Update me if needed} AppData directory to use
app_bin=${app^}                # Binary Name of the app

if [[ $app != 'prowlarr' ]]; then
    echo "It is critical that the user and group you select to run ${app^} as will have READ and WRITE access to your Media Library and Download Client Completed Folders"
fi

# Prompt User
read -r -p "What user should ${app^} run as? (Default: $app): " app_uid
app_uid=$(echo "$app_uid" | tr -d ' ')
app_uid=${app_uid:-$app}
# Prompt Group
read -r -p "What group should ${app^} run as? (Default: media): " app_guid
app_guid=$(echo "$app_guid" | tr -d ' ')
app_guid=${app_guid:-media}

echo "${app^} selected"
echo "This will install [${app^}] to [$bindir] and use [$datadir] for the AppData Directory"
if [[ $app == 'prowlarr' ]]; then
    echo "${app^} will run as the user [$app_uid] and group [$app_guid]."
else
    echo "${app^} will run as the user [$app_uid] and group [$app_guid]. By continuing, you've confirmed that that user and group will have READ and WRITE access to your Media Library and Download Client Completed Download directories"
fi
echo "Continue with the installation [Yes/No]?"
select yn in "Yes" "No"; do
    case $yn in
    Yes) break ;;
    No) exit 0 ;;
    esac
done

# Create User / Group as needed
if [ "$app_guid" != "$app_uid" ]; then
    if ! getent group "$app_guid" >/dev/null; then
        groupadd "$app_guid"
    fi
fi
if ! getent passwd "$app_uid" >/dev/null; then
    adduser --system --no-create-home --ingroup "$app_guid" "$app_uid"
    echo "Created and added User [$app_uid] to Group [$app_guid]"
fi
if ! getent group "$app_guid" | grep -qw "$app_uid"; then
    echo "User [$app_uid] did not exist in Group [$app_guid]"
    usermod -a -G "$app_guid" "$app_uid"
    echo "Added User [$app_uid] to Group [$app_guid]"
fi

# Stop the App if running
if service --status-all | grep -Fq "$app"; then
    systemctl stop "$app"
    systemctl disable "$app".service
    echo "Stopped existing $app"
fi

# Create Appdata Directory

# AppData
mkdir -p "$datadir"
chown -R "$app_uid":"$app_guid" "$datadir"
chmod 775 "$datadir"
echo "Directories created"
# Download and install the App

# prerequisite packages
echo ""
echo "Installing pre-requisite Packages"
# shellcheck disable=SC2086
apt update && apt install $app_prereq
echo ""
ARCH=$(dpkg --print-architecture)
# get arch
dlbase="https://$app.servarr.com/v1/update/$branch/updatefile?os=linux&runtime=netcore"
case "$ARCH" in
"amd64") DLURL="${dlbase}&arch=x64" ;;
"armhf") DLURL="${dlbase}&arch=arm" ;;
"arm64") DLURL="${dlbase}&arch=arm64" ;;
*)
    echo "Arch not supported"
    exit 1
    ;;
esac
echo ""
echo "Removing previous tarballs"
# -f to Force so we fail if it doesnt exist
rm -f "${app^}".*.tar.gz
echo ""
echo "Downloading..."
wget --content-disposition "$DLURL"
tar -xvzf "${app^}".*.tar.gz
echo ""
echo "Installation files downloaded and extracted"

# remove existing installs
echo "Removing existing installation"
# If you happen to run this script in the installdir the line below will delete the extracted files and cause the mv some lines below to fail.
rm -rf "$bindir"
echo "Installing..."
mv "${app^}" $installdir
chown "$app_uid":"$app_guid" -R "$bindir"
chmod 775 "$bindir"
rm -rf "${app^}.*.tar.gz"
# Ensure we check for an update in case user installs older version or different branch
touch "$datadir"/update_required
chown "$app_uid":"$app_guid" "$datadir"/update_required
echo "App Installed"
# Configure Autostart

# Remove any previous app .service
echo "Removing old service file"
rm -rf /etc/systemd/system/"$app".service

# Create app .service with correct user startup
echo "Creating service file"
cat <<EOF | tee /etc/systemd/system/"$app".service >/dev/null
[Unit]
Description=${app^} Daemon
After=syslog.target network.target
[Service]
User=$app_uid
Group=$app_guid
UMask=$app_umask
Type=simple
ExecStart=$bindir/$app_bin -nobrowser -data=$datadir
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

# Start the App
echo "Service file created. Attempting to start the app"
systemctl -q daemon-reload
systemctl enable --now -q "$app"

# Finish Update/Installation
host=$(hostname -I)
ip_local=$(grep -oP '^\S*' <<<"$host")
echo ""
echo "Install complete"
sleep 10
STATUS="$(systemctl is-active "$app")"
if [ "${STATUS}" = "active" ]; then
    echo "Browse to http://$ip_local:$app_port for the ${app^} GUI"
else
    echo "${app^} failed to start"
fi

# Exit
exit 0
}



# Main script
display_options

# Prompt user for category selection
read -p "Enter the category number you want to install: " selected_category

case $selected_category in
    5)
        # Amenities category
        display_amenities_options
        read -p "Enter the package numbers you want to install (comma-separated): " selected_packages

        # Convert user input to an array
        IFS=',' read -r -a package_numbers <<< "$selected_packages"

        # Install selected packages
        for number in "${package_numbers[@]}"; do
            case $number in
                1)
                    install_kali_repos
                    ;;
                2)
                    install_homebrew
                    ;;
                3)
                    install_thefuck
                    ;;
                4)
                    install_birthday
                    ;;
                5)
                    install_onetimeshare
                    ;;
                6)
                    install_undollar
                    ;;
                7)
                    install_google_font_installer
                    ;;
                8)
                    install_nipe_for_tor
                    ;;
                *)
                    echo "Invalid option: $number"
                    ;;
            esac
        done
        ;;
    # ... (Other categories)
esac

# Function to install Tools
install_tools() {
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser

    wget https://github.com/Furfulka/Progenitor/raw/main/installEtcher.sh
    chmod +x installEtcher.sh
    ./installEtcher.sh
    rm installEtcher.sh

    sudo add-apt-repository ppa:trebelnik-stefina/grub-customizer
    sudo apt update
    sudo apt install grub-customizer

    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install ./keybase_amd64.deb
    run_keybase

    # (Additional commands for Tools installation)
}

# Function to install NTFY
install_ntfy() {
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://archive.heckel.io/apt/pubkey.txt | sudo gpg --dearmor -o /etc/apt/keyrings/archive.heckel.io.gpg
    sudo sh -c "echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/archive.heckel.io.gpg] https://archive.heckel.io/apt debian main' \
        > /etc/apt/sources.list.d/archive.heckel.io.list"  
    sudo apt update
    sudo apt install ntfy
    sudo systemctl enable ntfy
    sudo systemctl start ntfy
}

# Function to install h8mail
install_h8mail() {
    git clone https://github.com/khast3x/h8mail.git
    cd h8mail
    sudo python3 setup.py install
}

# Function to install Keylogger
install_keylogger() {
    git clone https://github.com/GiacomoLaw/Keylogger/
    pip3 install pyxhook --break-system-packages
    nohup python3 keylogger.py &
}

# Function to install Search.0t.rocks
install_search_ot_rocks() {
    git clone https://github.com/MiyakoYakota/search.0t.rocks
    cd search.0t.rocks
    docker compose build
    docker compose up
}

# Function to display package options for Tools
display_tools_options() {
    echo "Tools:"
    echo "1. Brave Browser"
    echo "2. Etcher"
    echo "3. Grub Customizer"
    echo "4. Keybase"
    echo "5. Keybase (alternative)"
    echo "6. NTFY"
    echo "7. Eggs"
}

# ... (Previous code for other functions)

# Prompt user for category selection
read -p "Enter the category number you want to install: " selected_category

case $selected_category in
    # ... (Previous cases for other categories)
    6)
        # Tools category
        display_tools_options
        read -p "Enter the package number you want to install: " selected_package

        case $selected_package in
            1)
                install_brave_browser
                ;;
            2)
                install_etcher
                ;;
            3)
                install_grub_customizer
                ;;
            4)
                install_keybase
                ;;
            5)
                install_keybase
                ;;
            6)
                install_ntfy
                ;;
            7)
                install_eggs
                ;;
            *)
                echo "Invalid option: $selected_package"
                ;;
        esac
        ;;
esac

# Prompt user for category selection
read -p "Enter the category number you want to install: " selected_category

# Function to install and run VeraCrypt container
install_veracrypt_container() {
    # Request user input for variables
    read -p "Enter the container name: " CONTAINER_NAME
    read -p "Enter the mount point (e.g., /mnt/deru): " MOUNT_POINT
    read -p "Enter the path for split files: " SPLIT_FILES
    read -p "Enter the container size (e.g., 3G): " SIZE
    read -sp "Enter the password: " PASSWORD
    echo

    # Create a random file for the container
    dd if=/dev/urandom of=$CONTAINER_NAME bs=1M count=$((SIZE))

    # Create the mount point and split files directory
    mkdir -p $MOUNT_POINT
    mkdir -p $SPLIT_FILES

    # Create a VeraCrypt container
    veracrypt --text --create --volume-type=normal $CONTAINER_NAME --size $SIZE --password $PASSWORD --encryption AES --hash SHA-512 --filesystem FAT --pim 0 -k "" --random-source=/dev/urandom

    # Give user permissions to the mounted directory
    chown -R $(whoami) $MOUNT_POINT

    # Mount the VeraCrypt container with user permissions
    veracrypt --text --mount $CONTAINER_NAME --password $PASSWORD --filesystem FAT --slot=1 --mappings=$MOUNT_POINT

    # Display success message
    echo "VeraCrypt container created and mounted successfully at $MOUNT_POINT with user permissions"
    horcrux -t 3 -n 5 split $SPLIT_FILES
    rm $CONTAINER_NAME
}


    # Define the file path
    file_path="/home/sean/script.sh"

    # Write the script content to the file
    echo "$script_content" > "$file_path"
    chmod +x "$file_path"
    echo "Script generated successfully at $file_path"
}


# Prompt user for category selection
read -p "Enter the category number you want to install: " selected_category

case $selected_category in
    # ... (Previous cases for other categories)
    7)
        # Blackbox category
        display_blackbox_options
        read -p "Enter the package number you want to install: " selected_package

        case $selected_package in
            1)
                install_h8mail
                ;;
            2)
                install_keylogger
                ;;
            3)
                install_search_ot_rocks
                ;;
            4)
                install_veracrypt_container
                ;;
            *)
                echo "Invalid option: $selected_package"
                ;;
        esac
        ;;
esac
