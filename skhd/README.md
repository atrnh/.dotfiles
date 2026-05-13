# skhd (simple hotkey daemon) config

using [the Zig implementation](https://github.com/jackielii/skhd.zig).

## roadmap

- [ ] migrate karabiner config
- [ ] set up qmk style layers
- [ ] use reuseable command templates for sketchybar updates
- [ ] add aliases for lowper (hyper w/o shift), hyper, and backtick (`0x32`)

## cheatsheet

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
.define resize_window : yabai -m window --resize {{1}}:{{2}}:{{3}}

# Then use the commands like this:
cmd - h : @yabai_focus("west")
cmd + ctrl - h : @resize_window("left", "-20", "0")

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