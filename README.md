# Sole Hub - Roblox Dark UI Library

This repository contains a Roblox Dark UI library with whitelist protection and script delivery via GitHub Pages.

## Quick Start

### Load Script
```lua
loadstring(httpget("https://sxmplehere.github.io/sole-hub/script.lua"))()
```

### Files
- `script.lua` - Main Roblox executable script
- `src/` - DarkUI library source code
- `.github/workflows/pages.yml` - GitHub Pages deployment

## Whitelist

Edit `script.lua` and add your User IDs:

```lua
local whitelist = {
    123456789, -- Your ID
    987654321, -- Friend's ID
}
```

## Requirements

- Roblox game with HttpGet enabled
- DarkUI library (optional - falls back to basic mode)
