# Editor Colors Collection

A curated collection of 386 high-quality RGB colors with practical, real-world names, optimized for terminal and code editor themes.

## Overview

This collection started with 1,204 colors from various sources and has been refined to 386 unique colors through:
- **Deduplication** - Removed 956 duplicate hex values
- **Name curation** - Kept practical, real-world color names
- **Quality augmentation** - Added Crayola and PrintHue colors

## Collection Contents

### 📊 **Color Statistics**
- **Total Colors**: 386 unique colors
- **Readable on Black**: 288 colors (74.6% with 4.5:1+ contrast)
- **High Contrast**: 208 colors (53.9% with 7:1+ contrast)
- **Sources**: Curated web colors + 90 Crayola + 49 PrintHue colors

### 🎨 **Color Sources**
1. **Curated Web Colors** (247) - Deduplicated from original 1,204 colors
2. **Crayola Colors** (90) - Kid-friendly but practical color names
3. **PrintHue Colors** (49) - Professional color standards

### ✅ **Name Quality**
- ✅ Real-world references: "Forest Green", "Sky Blue", "Brick Red"
- ✅ Professional standards: "PrintHue Classic Blue", "PrintHue Emerald" 
- ❌ Eliminated cute/meaningless names: "waaaagh!", "existential angst"

## Files Structure

### 📁 **Core Data**
```
rgb.txt                    # Main color database (386 colors)
rgb_original_backup.txt    # Original 1,204 colors backup
rgb_pre_augmentation_backup.txt # Pre-Crayola/PrintHue backup
```

### 🔧 **Processing Scripts**
```
color_sorter.py           # Parse colors & generate sorted JSON files
deduplicate_colors.py     # Remove duplicates & curate names  
augment_colors.py         # Add Crayola & PrintHue colors
vim_colors_parser.py      # Parse vim colorscheme files
```

### 📊 **Generated Data**
```
sorted_colors.json        # Main JSON (LCH perceptual sorting)
sorted_colors_lch.json    # LCH perceptual sorted
sorted_colors_hsv.json    # HSV rainbow sorted  
sorted_colors_contrast.json # Contrast ratio sorted
vim_colors.json           # Vim colorscheme colors
```

### 🌐 **Web Viewers**
```
rgb_colors_sorted.html     # Color grid viewer with advanced sorting
terminal_preview_json.html # Terminal/vim color preview with code samples
vim_colors_preview.html    # Your vim colorscheme preview
```

## Quick Start

### 🚀 **View Colors in Browser**
```bash
cd /path/to/editor_colors
python3 -m http.server 8000
```

Then open in browser:
- **Color Grid**: http://localhost:8000/rgb_colors_sorted.html
- **Terminal Preview**: http://localhost:8000/terminal_preview_json.html  
- **Vim Colors**: http://localhost:8000/vim_colors_preview.html

### 📋 **Regenerate Data**
```bash
# Regenerate sorted JSON files from rgb.txt
python3 color_sorter.py

# Parse vim colorscheme colors
python3 vim_colors_parser.py
```

## Advanced Usage

### 🎯 **Color Selection Tips**

**For Terminal/Vim Themes:**
- Use **4.5:1+ contrast** colors for readability
- Filter by contrast in the web viewers
- Visual Similarity sorting groups color families intuitively
- LCH sorting provides smooth perceptual transitions

**For Professional Work:**
- PrintHue colors provide industry standards
- Use high contrast (7:1+) colors for accessibility

**For Friendly Interfaces:**
- Crayola colors offer approachable, familiar names
- Great balance of variety and practicality

**Sorting Options:**
- **Visual Similarity**: Groups colors by family (all reds, blues, greens together)
- **LCH Perceptual**: Smooth mathematical transitions, best for gradients
- **Contrast**: Highest contrast colors first, ideal for accessibility
- **Name**: Alphabetical sorting for easy lookup

### 🔄 **Updating the Collection**

**To add more colors:**
1. Add to `rgb.txt` in format: `Color Name\t#HEXCODE`
2. Run `python3 color_sorter.py` to regenerate JSON files
3. Refresh web pages to see updates

**To deduplicate new colors:**
1. Modify `deduplicate_colors.py` name priority patterns
2. Run script to clean duplicates and curate names

### 📖 **Color Naming Philosophy**

**Preferred Names:**
- Basic colors: "red", "blue", "green"
- Real objects: "copper", "ivory", "forest green"  
- Brands with meaning: "Barbie pink"
- Descriptive: "dark blue", "light coral"

**Avoided Names:**
- Marketing fluff: "hottest of pinks", "ultimate purple"
- Gaming references: "goblin warboss", "armor wash"
- Meaningless cute: "existential angst", "waaaagh!"

## Technical Details

### 🧮 **Color Sorting Algorithms**

**LCH Perceptual Sorting:**
Colors are sorted using the LCH color space for perceptually uniform transitions:
- **L** (Lightness): 0-100
- **C** (Chroma): Color intensity  
- **H** (Hue): 0-360° around color wheel

**Visual Similarity Sorting:**
Groups colors by intuitive color families for better visual organization:
- **Greys**: Low chroma colors (< 10) and named greys sorted by lightness
- **Color Families**: Reds, oranges, yellows, greens, blues, purples by hue ranges
- **Within Family**: Sorted by lightness, then saturation for natural progression

This creates visually logical groupings where similar colors appear together.

### 🖥️ **Terminal Compatibility**
- All colors include RGB hex values
- cterm/cterm16 values provided for vim integration
- Contrast ratios calculated for black backgrounds
- WCAG accessibility standards supported

### 📐 **Color Space Conversions**
The `color_sorter.py` uses the `colorspacious` library for accurate color space conversions:
- RGB → LCH for perceptual sorting
- RGB → HSV for rainbow sorting  
- WCAG contrast ratio calculations

## Dependencies

### 🐍 **Python Requirements**
```bash
pip install colorspacious
```

### 🌐 **Web Requirements**
- Modern browser with JavaScript support
- Local web server (Python's built-in server works)

## Integration Examples

### 🎨 **Vim Colorscheme**
```vim
" Use colors from the collection
let s:forest_green = { "gui": "#5FA777", "cterm": "72" }
let s:sky_blue = { "gui": "#76D7EA", "cterm": "117" }
```

### 🖥️ **Terminal Theme**
```bash
# Use hex values for terminal color schemes
export COLOR_FOREST_GREEN="#5FA777"
export COLOR_SKY_BLUE="#76D7EA"
```

### 🌐 **Web/CSS**
```css
:root {
  --forest-green: #5FA777;
  --sky-blue: #76D7EA;
  --brick-red: #C62D42;
}
```

## Contributing

When adding new colors, please:
1. Use practical, real-world names
2. Check for duplicates first
3. Verify good contrast on dark backgrounds
4. Test in actual terminal/editor environments

## License

This color collection is curated from public domain and widely-used color standards. Individual color names may have different origins (Crayola, PrintHue, etc.) but the compilation is provided for educational and development use.

---

*Generated collection of 386 curated colors for terminal and editor themes*