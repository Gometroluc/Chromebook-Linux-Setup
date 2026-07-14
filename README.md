# Chromebook Linux Setup

This project provides an adapted version of the MrChromebox Firmware Utility workflow for the Lenovo Yoga Chromebook C630.

## About this modification

The original MrChromebox firmware utility had issues downloading required files correctly on the Lenovo Yoga C630 in some environments.

This adaptation changes only the file layout and startup process:

- MrChromebox utility scripts are stored locally;
- the script runs from a local working copy;
- the original firmware modification logic is preserved.

## Supported device

Currently tested only on:

- Lenovo Yoga Chromebook C630

Other Chromebook models are not tested and may not work.

## Usage

1. Open the VT-2 Terminal: `ctrl` + `alt` + `f2` (Use `Ctrl + Alt + F1` to return to the ChromeOS interface)

2. Log in as `chronos` and navigate to the script directory (usually `~/MyFiles/Downloads/Chromebook-Linux-Setup-main`)

3. Run the script:

```bash
sudo bash CONFIGURE.sh
```

The script may take a few seconds to initialize

4. Select `Install/Update RW_LEGACY Firmware`

5. Then select `SeaBIOS` or `edk2/Tianocore`

6. Shut down the Chromebook

7. Insert a bootable Linux USB drive

8. At the `OS verification is OFF` screen, press `ctrl` + `L`

9. Boot from USB and install Linux

# Disclaimer

This project is provided for convenience and personal use.

Modifying Chromebook firmware can permanently damage your device if something goes wrong. Make sure you understand the process before using this utility.

The author is not responsible for hardware damage, data loss, failed firmware updates, or any other issues caused by using this project.

# Credits

Based on the original work by MrChromebox:

https://mrchromebox.tech/

All original credits and licenses belong to their respective authors.
