#!/bin/bash

# Define the replacement strings
old_term1="Bookworm"
new_term1="Angelhair"
old_term2="debian"
new_term2="Fulka OS"

# Define the list of files and directories
files=(
    "/etc/debian_version"
    "/etc/os-release"
    "/etc/hosts"
    "/etc/grub.d/05_debian_theme"
    # Add other files here...
    "/etc/default/grub.d/init-select.cfg"
    "/etc/default/useradd"
    "/etc/dpkg/origins/debian"
    "/etc/penguins-eggs.d/distros/bookworm/calamares/modules/users.yml"
    "/etc/penguins-eggs.d/distros/bookworm/calamares/modules/welcome.yml"
    "/etc/penguins-eggs.d/distros/bookworm/calamares/modules/bootloader.yml"
    "/etc/calamares/branding/eggs/branding.desc"
    "/etc/calamares/branding/eggs/show.qml"
    "/etc/calamares/modules/bootloader.conf"
    "/etc/calamares/modules/users.conf"
    "/etc/calamares/settings.conf"
    "/etc/appstream.conf"
    "/etc/calamares/branding/eggs/show.qml"
    "/etc/calamares/modules/bootloader.conf"
    "/etc/calamares/modules/removeuser.conf"
    "/etc/calamares/modules/users.conf"
    "/etc/calamares/modules/welcome.conf"
    "/etc/grub.d/05_debian_theme"
    "/etc/penguins-eggs.d/derivatives.yaml"
    "/etc/penguins-eggs.d/distros/bookworm/calamares/modules/bootloader.yml"
    "/etc/penguins-eggs.d/distros/bookworm/calamares/modules/users.yml"
)

# Add directories to the list
directories=(
    "/etc/apt/"
    "/etc/apt/sources.list.d/"
    "/etc/apt/preferences"
    "/etc/apt/preferences.d/"
    "/etc/apt/apt.conf.d/"
    "/etc/network/"
    "/etc/ssh/"
    "/etc/sudoers.d/"
    "/etc/ufw/"
    "/etc/udev/rules.d/"
    "/etc/systemd/"
    "/etc/sysctl.d/"
    "/etc/fstab"
    "/etc/logrotate.d/"
    "/etc/cron.d/"
    "/etc/cron.daily/"
    "/etc/cron.hourly/"
    "/etc/cron.monthly/"
    "/etc/cron.weekly/"
    "/etc/security/"
    "/etc/alternatives/"
    "/etc/environment"
    "/etc/default/grub.d/"
    "/etc/xdg/autostart/"
)

# Loop through the files
for file in "${files[@]}"
do
    # Check if file exists
    if [ -f "$file" ]; then
        # Perform replacements
        sed -i "s/$old_term1/$new_term1/gI" "$file"
        sed -i "s/$old_term2/$new_term2/gI" "$file"

        # Comment out vendor-related lines
        sed -i '/vendor/d' "$file"
    else
        echo "File not found: $file"
    fi
done

# Loop through the directories
for directory in "${directories[@]}"
do
    # Check if directory exists
    if [ -d "$directory" ]; then
        # Perform replacements in files within the directory
        find "$directory" -type f -exec sed -i "s/$old_term1/$new_term1/gI" {} \;
        find "$directory" -type f -exec sed -i "s/$old_term2/$new_term2/gI" {} \;

        # Comment out vendor-related lines in files within the directory
        find "$directory" -type f -exec sed -i '/vendor/d' {} \;
    else
        echo "Directory not found: $directory"
    fi
done

echo "Editing complete."
