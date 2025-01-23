#!/bin/bash
# License: GPLv3
# Credits: Felipe Facundes

# Script name: psychedelic.sh

if ! command -v xrandr &> /dev/null; then
    echo "Error: 'xrandr' command not found. Please install it to proceed." >&2
    exit 1
fi

# Gamma configurations for X11
declare -A gamma_configs_psychedelic=(
    [BLUE]='1.0:1.0:2.0'
    [RED]='2.0:0.6:0.6'
    [GREEN]='0.5:2.5:0.5'
    #[RESET]='1.0:1.0:1.0' # Uncomment if needed
    [BROWN]='1.0:0.5:0.2'
    [PURPLE]='0.5:0.5:2.0'
    [PINK]='2.0:0.5:2.0'
    [CYAN]='0.8:1.2:2.0'
    [MAGENTA]='1.0:0.5:1.0'
    [YELLOW]='1.5:1.0:0.5'
    [ORANGE]='2.0:1.2:0.4'
    [LIGHT_PURPLE]='0.8:0.8:2.0'
    [DARK_PURPLE]='0.3:0.3:2.0'
    [VIBRANT_PURPLE]='1.0:0.4:2.0'
    [SOFT_PURPLE]='0.7:0.6:1.5'
    [DEEP_PURPLE]='0.4:0.2:2.0'
    [LIGHT_ORANGE]='2.0:1.4:0.6'
    [DARK_ORANGE]='1.8:0.8:0.2'
    [VIBRANT_ORANGE]='2.0:1.0:0.3'
    [SOFT_ORANGE]='1.6:1.2:0.5'
    [BURNT_ORANGE]='1.8:0.6:0.2'
    [LIGHT_BLUE]='1.0:1.0:2.5'
    [DARK_BLUE]='1.0:0.8:2.0'
    [LIGHT_RED]='2.0:1.0:1.0'
    [DARK_RED]='2.0:0.4:0.4'
    [LIGHT_GREEN]='1.0:2.0:1.0'
    [DARK_GREEN]='0.3:2.0:0.3'
    [LIGHT_YELLOW]='1.5:1.2:0.5'
    [DARK_YELLOW]='1.8:1.0:0.5'
)   # psychedelic

# Waiting time between gamma changes (in seconds)
wait_time=0.3

# Variables to restore original settings in X11
original_gamma=""
original_brightness=""

# Get the active monitor output name
output_name=$(xrandr --listmonitors | grep '+' | awk '{print $4}')

# Check if the monitor output was detected
if [[ -z "$output_name" ]]; then
    echo "Unable to detect monitor output"
    exit 1
fi

# Function to capture the current monitor settings (X11)
_capture_original_settings() {
    original_gamma=$(xrandr --verbose | grep -A 5 "^$output_name" | grep "Gamma:" | awk '{print $2}')
    original_brightness=$(xrandr --verbose | grep -A 5 "^$output_name" | grep "Brightness:" | awk '{print $2}')
    if [[ -z "$original_gamma" || -z "$original_brightness" ]]; then
        echo "Error capturing original settings. Check the xrandr status."
        exit 1
    fi
}

# Function to restore the original monitor settings (X11)
_restore_original_settings() {
    if [[ -n "$original_gamma" && -n "$original_brightness" ]]; then
        xrandr --output "$output_name" --gamma "$original_gamma" --brightness "$original_brightness"
    else
        echo "Original settings not captured. No restoration possible."
    fi
}

# Main function for the strobe effect
_flash_screen() {
    trap 'cleanup' EXIT  # Restore settings on exit

    if [[ ${XDG_SESSION_TYPE,,} == [xX]11 ]]; then
        _capture_original_settings  # Capture original settings before changing
        while :; do
            for gamma_config in "${gamma_configs_psychedelic[@]}"; do
                xrandr --output "$output_name" --gamma "$gamma_config"
                sleep "$wait_time"
            done
        done
    fi
}

# Cleanup function to restore settings
cleanup() {
    if [[ ${XDG_SESSION_TYPE,,} == [xX]11 ]]; then
        _restore_original_settings
    fi
    exit 0
}

# Script entry point
_flash_screen
