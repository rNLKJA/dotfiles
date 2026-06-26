

```markdown:README.md
# Yabai Window Manager Installation Guide

## Overview
Yabai is a tiling window manager for macOS. Some of its advanced features require System Integrity Protection (SIP) to be partially disabled.

## Prerequisites

Before installing yabai, you'll need to partially disable System Integrity Protection (SIP). This is required for features like:
- Managing spaces (create/destroy/focus/move)
- Window shadows and transparency
- Window animations
- Sticky windows
- Picture-in-picture controls

## Disabling System Integrity Protection

### Step 1: Boot into Recovery Mode
1. Shut down your Mac
2. For Intel Macs:
   - Hold Command (⌘) + R while booting
3. For Apple Silicon Macs:
   - Press and hold the power button until "Loading startup options" appears
   - Click Options, then Continue

### Step 2: Disable SIP
1. Open Terminal from the Utilities menu
2. Run the appropriate command for your system:

For Apple Silicon (macOS 13+):
```bash
csrutil enable --without fs --without debug --without nvram
```

### Step 3: Additional Setup for Apple Silicon
After rebooting, open Terminal and run:
```bash
sudo nvram boot-args=-arm64e_preview_abi
```

### Step 4: Verify SIP Status
Check your SIP status by running:
```bash
csrutil status
```

**Note:** SIP will be re-enabled if your device is serviced at an Apple Store or Authorized Service Provider.

## Installation
[Installation steps to be added]

## Re-enabling SIP
To re-enable SIP after uninstalling yabai:
1. Boot into Recovery Mode
2. Open Terminal
3. Run: `csrutil enable`
4. Reboot

