# Chromebook Linux Setup

This tutorial uses a modified version of the MrChromebox Firmware Utility adapted for the Lenovo Yoga Chromebook C630

## About Modification

The original MrChromebox script had trouble downloading its dependencies

This adaptation modifies the file layout and startup process:

- MrChromebox scripts are stored locally;
- firmware utilities are kept in a separate `tools` directory;
- the startup process uses a working copy in `/usr/local/bin`;
- the original firmware utility logic is preserved.

## Supported device

Currently tested only on Lenovo Yoga Chromebook C630 (Pantheon)

Other Chromebook models are not tested and may not work.

## Usage

Press `ctrl` + `alt` + `f2`
The VT-2 terminal would open (`ctrl` + `alt` + `f1` to get back to the normal interface)

Then navigate to the script directory (usually `~/MyFiles/Downloads/chromebook-linux-setup`)

Run:

```bash
sudo bash CONFIGURE.sh
```


# Disclaimer

This project is provided for convenience and personal use.

Firmware modification can permanently damage your device if something goes wrong. Make sure you understand what the utility does before using it.

I am not responsible for any damage, data loss, or failed firmware updates.

# Credits

Based on the original work by MrChromebox:

https://mrchromebox.tech/

All original credits and licenses belong to their respective authors.
