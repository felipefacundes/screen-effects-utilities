# Screen Effects Utilities: For strobe effects on your monitor

This repository contains three powerful shell scripts designed to create stunning strobe and color effects on your screen. These scripts utilize `xrandr` and other utilities to manipulate gamma settings dynamically, providing various visual effects. They are also part of the broader [shell_utils](https://github.com/felipefacundes/shell_utils) framework, one of the most comprehensive collections of scripts and utilities for simplifying tasks in the shell environment.

## Scripts Included

1. **psychedelic.sh**
   - Creates dynamic, psychedelic strobe effects by cycling through preconfigured gamma values.
   - Designed for X11 environments.
   
2. **flash-screen.sh**
   - Provides strobe effects for both X11 and Wayland environments, using `xrandr` and `wl-gammactl`.

3. **display_colors**
   - Adjusts the screen gamma to various predefined colors or resets it to default.

## Requirements

- **Dependencies:**
  - `xrandr`: Required for gamma adjustments in X11.
  - `wl-gammactl`: Needed for gamma adjustments in Wayland (flash-screen.sh only).

- **Supported Environments:**
  - X11 (all scripts).
  - Wayland (flash-screen.sh only).

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/felipefacundes/screen-effects-utilities.git
   cd screen-effects-utilities
   ```

2. Ensure the necessary dependencies are installed:
   ```bash
   sudo apt update
   sudo apt install x11-xserver-utils   # For xrandr
   sudo apt install wl-gammactl         # For Wayland (if applicable)
   ```

## Usage

### psychedelic.sh
```bash
bash psychedelic.sh
```
This script creates a psychedelic strobe effect. Use `Ctrl+C` to stop the script and restore the original gamma settings.

### flash-screen.sh
```bash
bash flash-screen.sh
```
This script creates strobe effects for both X11 and Wayland environments. It detects the current session type and uses the appropriate tools.

### display_colors
```bash
bash display_colors [color]
```
Replace `[color]` with one of the predefined options, such as `blue`, `red`, `green`, or `reset` to return to the default gamma settings.

## Part of the shell_utils Framework
These scripts are also integrated into the [shell_utils](https://github.com/felipefacundes/shell_utils) repository, a comprehensive library of scripts and utilities for shell environments. For further enhancements and additional utilities, visit the official repository.

## License
This project is licensed under the GPLv3 License. See the LICENSE file for details.

## Credits
Created by Felipe Facundes.
