import os
import shutil

def replace_logo(logo_path):
    # Paths for the Breeze theme logos
    breeze_icons_path = "/usr/share/plasma/desktoptheme/default/icons/"
    logo_filenames = ["start-here.svg", "start-here-kde.svg"]

    for filename in logo_filenames:
        logo_src = os.path.join(logo_path, filename)
        logo_dest = os.path.join(breeze_icons_path, filename)

        # Check if the logo source file exists
        if os.path.exists(logo_src):
            # Backup the original logo
            if os.path.exists(logo_dest):
                shutil.move(logo_dest, logo_dest + ".bak")

            # Copy the new logo to the destination
            shutil.copy(logo_src, breeze_icons_path)

if __name__ == "__main__":
    # Get the path of the user-chosen logo
    user_logo_path = input("Enter the path to your custom logo: ")

    # Check if the file exists
    if os.path.exists(user_logo_path):
        replace_logo(user_logo_path)
        print("Logo replaced successfully!")
    else:
        print("Error: File not found.")
