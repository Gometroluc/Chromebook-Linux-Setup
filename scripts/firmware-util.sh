#!/bin/bash
#
# This script offers provides the ability to update the
# Legacy Boot payload, set boot options, and install
# a custom coreboot firmware for supported
# ChromeOS devices
#
# Created by Mr.Chromebox <mrchromebox@gmail.com>
#
# May be freely distributed and modified as needed,
# as long as proper attribution is given.
#

# shellcheck disable=SC2164

#path to directory where script is saved
script_dir="$(dirname "$(readlink -f "$0")")"

PROJECT_DIR="$(cd "$script_dir/.." && pwd)"
WORK_DIR="$PROJECT_DIR/work"
TOOLS_DIR="$PROJECT_DIR/tools"

#where the stuff is
script_url="https://raw.githubusercontent.com/MrChromebox/scripts/main/"

#ensure output of system tools in en-us for parsing
export LC_ALL=C

# session logging (override path with MRCBX_LOG env var)
MRCBX_VERBOSE=0
for _arg in "$@"; do
	case "$_arg" in
		-v|--verbose) MRCBX_VERBOSE=1 ;;
	esac
done
export MRCBX_VERBOSE
export MRCBX_LOG="${MRCBX_LOG:-/tmp/mrchromebox-$(date +%Y%m%d-%H%M%S).log}"



######################
#### Download List ###
######################

download_lines=0

draw_download_list() {
    
    # стереть предыдущий список
    if [ "$download_lines" -gt 0 ]; then
        for ((i=0;i<download_lines;i++)); do
            printf "\033[A\033[K"
        done
    fi

    echo "Downloading required files:"
    echo

    download_lines=2

    for file in "${required_files[@]}"; do
        case "${download_status[$file]}" in
            done)
                echo "  ✓ $file"
                ;;
            downloading)
                echo "  → $file"
                ;;
            fail)
                echo "  ✗ $file"
                ;;
            *)
                echo "  ○ $file"
                ;;
        esac

        ((download_lines++))
    done
}






{
	echo "=== MrChromebox Firmware Utility session log ==="
	date
	echo "verbose: ${MRCBX_VERBOSE}"
	echo
} > "$MRCBX_LOG"
ln -sf "$MRCBX_LOG" /tmp/mrchromebox_latest.log 2>/dev/null || true

#set working dir
PROJECT_DIR="$(cd "$script_dir/.." && pwd)"
WORK_DIR="$PROJECT_DIR/work"

mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# clear screen / show banner
printf "\ec"
echo
echo "=============================================="
echo "        MrChromebox Firmware Utility"
echo "              Modified by Gometroluc"
echo "=============================================="
echo
echo "          Starting up..."
echo
#check for cmd line param, expired CrOS certs
if ! curl -sLo /dev/null https://mrchromebox.tech/index.html || [[ "$1" = "-k" ]]; then
	export CURL="curl -k"
else
	export CURL="curl"
fi

required_files=(
    "device-db.sh"
    "device-db-functions.sh"
    "firmware.sh"
    "functions.sh"
    "sources.sh"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$script_dir/$file" ]; then
        echo "Missing $file in scripts/"
        exit 1
    fi
done

source "$script_dir/device-db.sh"
source "$script_dir/device-db-functions.sh"
source "$script_dir/sources.sh"
source "$script_dir/firmware.sh"
source "$script_dir/functions.sh"


session_log_init



#set working dir
cd "$WORK_DIR"

#do setup stuff
prelim_setup
prelim_setup_result="$?"



#saving setup state for troubleshooting
diagnostic_report_save
troubleshooting_msg=(
	" * diagnostics report has been saved to /tmp/mrchromebox_diag.txt"
	" * session log: ${MRCBX_LOG}"
	" * go to https://forum.chrultrabook.com/ for help"
)
if [ "$prelim_setup_result" -ne 0 ]; then
	IFS=$'\n'
	echo "MrChromebox Firmware Utility setup was unsuccessful" >/dev/stderr
	echo "${troubleshooting_msg[*]}" >/dev/stderr
	exit 1
fi

#show menu

trap 'check_unsupported' EXIT
function check_unsupported() {
	if [ "$isUnsupported" = true ]; then
		IFS=$'\n'
		echo "MrChromebox Firmware Utility didn't recognize your device" >/dev/stderr
		echo "${troubleshooting_msg[*]}" >/dev/stderr
	fi
}


menu_fwupdate