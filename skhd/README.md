# skhd (simple hotkey daemon) config

using [the Zig implementation](https://github.com/jackielii/skhd.zig).

### interesting stuff

```bash
# Use custom shell (skips interactive shell overhead)
.shell "/bin/dash"

# Blacklist applications (skip hotkey processing)
.blacklist [
    "dota2"
    "Microsoft Remote Desktop"
    "VMware Fusion"
]

# Load additional config files
.load "~/.config/skhd/extra.skhdrc"

# Define aliases (New in skhd.zig!)
.alias $lowper cmd + alt + ctrl
.alias $hyper shift + cmd + alt + ctrl
.alias $super cmd + alt
.alias $grave 0x32

# Define process groups for reuse (New in skhd.zig!)
.define terminal_apps ["kitty", "wezterm", "terminal", "ghostty"]

# Define reusable commands with placeholders (New in skhd.zig!)
.define yabai_focus : yabai -m window --focus {{1}} || yabai -m display --focus {{1}}
.define yabai_swap : yabai -m window --swap {{1}} || (yabai -m window --display {{1}} && yabai -m display --focus {{1}})
.define toggle_app : open -a "{{1}}" || osascript -e 'tell app "{{1}}" to quit'
.define resize_window : yabai -m window --resize {{1}}:{{2}}:{{3}}
.define toggle_scratchpad : yabai -m window --toggle {{1}} || open -a "{{2}}"

# Declare a keyboard by VendorID/ProductID (v0.1.0)
# See "Device-aware remapping" below for full details.
.device builtin { vendor: 0x05AC, product: 0x0342 }

# Per-device HID remap — colon form (1:1 swap, applied via hidutil)
.remap caps_lock [device builtin] : escape

# Per-device tap-hold (routed through skhd-grabber)
.remap caps_lock [device builtin] {
    tap  : escape
    hold : lctrl
}
```