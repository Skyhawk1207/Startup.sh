# Startup.sh
A bash script for theming and installing apps to Ubuntu/Debian systems with MATE to match my usual preferences. Useful when distrohopping/reinstalling. 

A personal automation script created in 2021 to theme, style, and set up Ubuntu/Debian-based Linux systems running the **MATE desktop environment**. Originally written for distro-hopping convenience, this script helps streamline system setup — from browser installation to UI theming and app configuration.

Although written for personal use, it’s open to anyone who finds it useful.

---

## What It Does

This script automates:

*  **System Update**: Updates and upgrades system packages.
*  **Browser Installation**: Lets you choose from:

  * Google Chrome
  * Microsoft Edge
  * Brave
  * Chromium (via Debian sources)
  * Opera
  * Or install multiple at once
*  **Theme Installation**: Choose from:

  * Fluent GTK & icon theme
  * Orchis GTK theme & Tela icon theme
  * Or skip theming
*  **Grub2 + Plymouth Theming** *(Optional)*:

  * Slaze Grub2 theme
  * Custom Plymouth boot animations
*  **Extra Tools**:

  * Rofi with custom file finder
  * Artha (dictionary)
  * VLC media player
  * Microsoft fonts
  * Synaptic package manager
  * Ubuntu Software Center
*  **System Cleanup**:

  * Removes Snap
  * Autoremoves unused packages
*  **Performance Tweak**:

  * Sets `vm.swappiness` to 10 for improved RAM usage
*  **Aliases Setup**:

  * Creates a `.bash_aliases` file with custom helpers for system management and Windscribe VPN

---

##  Included Aliases & Functions

After running the script, a `.bash_aliases` file will be created with the following convenient shortcuts:

### Aliases

| Alias       | Description                                   |
| ----------- | --------------------------------------------- |
| `upgrade`   | Update and upgrade the system                 |
| `rb`        | Reboot immediately                            |
| `off`       | Shutdown immediately                          |
| `clean`     | Autoremove and autoclean packages             |
| `xwsc`      | Disconnect Windscribe VPN                     |
| `bt`        | Start Bluetooth service                       |
| `clcache`   | Clear RAM cache                               |
| `maintain`  | Run `upgrade`, `clean`, and `clcache`         |
| `big-clean` | Delete common config/cache folders and reboot |

### Functions

```bash
uinst <package>   # Update & install a package
install <package> # Install a package
wsc <location>    # Connect Windscribe VPN to location
```

These aliases are automatically sourced by `.bashrc` if not already configured.

---

##  How to Use

1. **Make it executable**:

   ```bash
   chmod +x startup.sh
   ```

2. **Run the script**:

   ```bash
   ./startup.sh
   ```

3. Follow on-screen prompts to:

   * Choose which browser(s) to install
   * Select a GTK and icon theme
   * Optionally install boot themes and animations

---

##  Dependencies

Most dependencies are installed during the script. Ensure you're on an Ubuntu or Debian-based system using **MATE Desktop** for best results.

---

##  Notes

* Meant for **MATE desktop** specifically. Some features (like `dconf` theme settings) are MATE-specific.
* You’ll be prompted throughout the process. No destructive actions are taken without confirmation.
* Uses some GitHub repos for themes — make sure you have internet access.

---

##  Optional Manual Steps

After script execution, you might want to:

* Customize **Plank dock**
* Set keyboard shortcuts for:

  * App launcher: `rofi -show drun` (e.g. Super+Space)
  * File finder: `rofi -show find -modi find:finder` (e.g. Super+F)
* Add **Artha** to startup
* Adjust panel settings
* Set up **Windscribe VPN**
* Reboot to finalize boot theme changes

---

##  License

This script is shared with the community without any warranty. Use at your own discretion.

