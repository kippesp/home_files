#!/usr/bin/env python3
"""
Color Augmentation Script - Adds Crayola and PrintHue colors to RGB collection

Fetches colors from reliable sources and merges with existing deduplicated colors.
"""

import os
import re
from typing import Dict, List, Set, Tuple


def get_crayola_colors() -> List[Tuple[str, str]]:
    """Get Crayola colors from W3Schools standard list."""
    # W3Schools standard Crayola colors
    crayola_colors = [
        ("Red", "#ED0A3F"),
        ("Maroon", "#C32148"),
        ("Scarlet", "#FD0E35"),
        ("Brick Red", "#C62D42"),
        ("English Vermilion", "#CC474B"),
        ("Madder Lake", "#CC3336"),
        ("Permanent Geranium Lake", "#E12C2C"),
        ("Maximum Red", "#D92121"),
        ("Indian Red", "#B94E48"),
        ("Orange Red", "#FF5349"),
        ("Sunset Orange", "#FE4C40"),
        ("Bittersweet", "#FE6F5E"),
        ("Dark Venetian Red", "#B33B24"),
        ("Venetian Red", "#CC553D"),
        ("Light Venetian Red", "#E6735C"),
        ("Vivid Tangerine", "#FF9980"),
        ("Middle Red", "#E58E73"),
        ("Burnt Orange", "#FF7F49"),
        ("Red Orange", "#FF681F"),
        ("Orange", "#FF8833"),
        ("Yellow Orange", "#FFAE42"),
        ("Apricot", "#FBD5AB"),
        ("Peach", "#FFCBA4"),
        ("Atomic Tangerine", "#FF9966"),
        ("Vivid Tangerine", "#FF9980"),
        ("Burnt Sienna", "#E97451"),
        ("Brown", "#AF593E"),
        ("Sepia", "#9E5B40"),
        ("Orange", "#FF8833"),
        ("Yellow Orange", "#FFAE42"),
        ("Yellow", "#FBE870"),
        ("Green Yellow", "#F0E68C"),
        ("Spring Green", "#ECEBBD"),
        ("Olive Green", "#B5B35C"),
        ("Forest Green", "#5FA777"),
        ("Green", "#3AA655"),
        ("Jungle Green", "#29AB87"),
        ("Pine Green", "#01786F"),
        ("Teal Blue", "#008080"),
        ("Sky Blue", "#76D7EA"),
        ("Turquoise Blue", "#6CDAE7"),
        ("Cornflower", "#93CCEA"),
        ("Midnight Blue", "#003366"),
        ("Navy Blue", "#0066CC"),
        ("Denim", "#1560BD"),
        ("Periwinkle", "#C5C5DD"),
        ("Cadet Blue", "#A9B2C3"),
        ("Indigo", "#4B0082"),
        ("Plum", "#8E3179"),
        ("Red Violet", "#BB3385"),
        ("Magenta", "#F653A6"),
        ("Fuchsia", "#C154C1"),
        ("Lavender", "#FBAED2"),
        ("Carnation Pink", "#FFA6C9"),
        ("Violet Red", "#F7468A"),
        ("Bittersweet", "#FE6F5E"),
        ("Salmon", "#FF91A4"),
        ("White", "#FFFFFF"),
        ("Black", "#000000"),
        ("Gray", "#8B8680"),
        ("Silver", "#C0C0C0"),
        ("Tan", "#D99A6C"),
        ("Desert Sand", "#EDD19C"),
        ("Antique Brass", "#C88A65"),
        ("Copper", "#DA8A67"),
        ("Gold", "#E6BE8A"),
        # Extended Crayola colors from 64/96/120 packs
        ("Mahogany", "#CA3435"),
        ("Chestnut", "#B94E48"),
        ("Raw Sienna", "#D68A59"),
        ("Tumbleweed", "#DE9E6B"),
        ("Raw Umber", "#714B23"),
        ("Burnt Umber", "#8A3324"),
        ("Melon", "#FEBAAD"),
        ("Pink Flamingo", "#FC74FD"),
        ("Violet", "#8359A3"),
        ("Blue Violet", "#6456B7"),
        ("Ultramarine Blue", "#3F26BF"),
        ("Cerulean", "#02A4D3"),
        ("Green Blue", "#2887C8"),
        ("Pacific Blue", "#009DC4"),
        ("Robin Egg Blue", "#00CCCC"),
        ("Aquamarine", "#95E0E8"),
        ("Turquoise Blue", "#6CDAE7"),
        ("Sea Green", "#9FE2BF"),
        ("Yellow Green", "#C5E384"),
        ("Spring Green", "#ECEBBD"),
        ("Granny Smith Apple", "#9DE093"),
        ("Fern", "#71BC78"),
        ("Asparagus", "#7BA428"),
        ("Dandelion", "#FED85D"),
        ("Goldenrod", "#FCD975"),
        ("Banana Yellow", "#FAE7B5"),
        ("Peach", "#FFCBA4"),
        ("Orange", "#FF8833"),
        ("Burnt Orange", "#FF7F49"),
        ("Macaroni and Cheese", "#FFBD88"),
        ("Mango Tango", "#E77200"),
        ("Burnt Sienna", "#E97451"),
        ("Brick Red", "#C62D42"),
        ("Mahogany", "#CA3435"),
        ("Maroon", "#C32148"),
        ("Raspberry", "#E30B5C"),
        ("Magenta", "#F653A6"),
        ("Red Violet", "#BB3385"),
        ("Plum", "#8E3179"),
        ("Orchid", "#E29CD2"),
        ("Lavender", "#FBAED2"),
        ("Wisteria", "#C9A0DC"),
        ("Purple Mountains Majesty", "#D6AEDD"),
        ("Violet", "#8359A3"),
        ("Blue Violet", "#6456B7"),
        ("Periwinkle", "#C5C5DD"),
        ("Cadet Blue", "#A9B2C3"),
        ("Cornflower", "#93CCEA"),
        ("Sky Blue", "#76D7EA"),
        ("Midnight Blue", "#003366"),
        ("Navy Blue", "#0066CC"),
        ("Denim", "#1560BD"),
        ("Blue Green", "#199EBD"),
        ("Pine Green", "#01786F"),
        ("Forest Green", "#5FA777"),
        ("Jungle Green", "#29AB87"),
        ("Olive Green", "#B5B35C"),
        ("Shadow", "#837050"),
        ("Timberwolf", "#D9D6CF"),
    ]
    
    print(f"Loaded {len(crayola_colors)} Crayola colors")
    return crayola_colors


def get_printhue_colors() -> List[Tuple[str, str]]:
    """Get essential PrintHue colors."""
    # Key PrintHue colors with practical names
    printhue_colors = [
        ("PrintHue Yellow", "#FEDD00"),
        ("PrintHue Yellow 012", "#FFD700"),
        ("PrintHue Orange 021", "#FE5000"),
        ("PrintHue Warm Red", "#F9423A"),
        ("PrintHue Red 032", "#EF3340"),
        ("PrintHue Rubine Red", "#CE0058"),
        ("PrintHue Rhodamine Red", "#E10098"),
        ("PrintHue Purple", "#BB29BB"),
        ("PrintHue Violet", "#440099"),
        ("PrintHue Blue 072", "#10069F"),
        ("PrintHue Reflex Blue", "#001489"),
        ("PrintHue Process Blue", "#0085CA"),
        ("PrintHue Green", "#00AB84"),
        ("PrintHue Black", "#2D2926"),
        ("PrintHue Cool Gray 1", "#F4F4F4"),
        ("PrintHue Cool Gray 3", "#D1D3D4"),
        ("PrintHue Cool Gray 5", "#B1B3B3"),
        ("PrintHue Cool Gray 7", "#97999B"),
        ("PrintHue Cool Gray 9", "#75787B"),
        ("PrintHue Cool Gray 11", "#53565A"),
        ("PrintHue Warm Gray 1", "#F7F4F0"),
        ("PrintHue Warm Gray 3", "#D7D2C4"),
        ("PrintHue Warm Gray 5", "#B7B09C"),
        ("PrintHue Warm Gray 7", "#998B78"),
        ("PrintHue Warm Gray 9", "#7C6C5D"),
        ("PrintHue Warm Gray 11", "#5C504A"),
        # Additional popular PrintHue colors
        ("PrintHue Emerald", "#009B77"),
        ("PrintHue Tangerine", "#F79100"),
        ("PrintHue Turquoise", "#00B4A6"),
        ("PrintHue Fuchsia", "#C62D42"),
        ("PrintHue Lime", "#9FCB43"),
        ("PrintHue Pink", "#D2386C"),
        ("PrintHue Blue Iris", "#5A4FCF"),
        ("PrintHue Chili Pepper", "#9B1B30"),
        ("PrintHue Sand Dollar", "#DFCFBE"),
        ("PrintHue Blue Turquoise", "#00B5CE"),
        ("PrintHue Tiger", "#F96714"),
        ("PrintHue Purple Haze", "#B565A7"),
        ("PrintHue True Red", "#8F1D21"),
        ("PrintHue Aqua Sky", "#7BC4C4"),
        ("PrintHue Honeysuckle", "#D94F70"),
        ("PrintHue Mimosa", "#F0C05A"),
        ("PrintHue Hot Pink", "#E56DB1"),
        ("PrintHue Burnt Orange", "#CC5500"),
        ("PrintHue Classic Blue", "#0F4C75"),
        ("PrintHue Living Coral", "#FF6F61"),
        ("PrintHue Ultra Violet", "#5F4B8B"),
        ("PrintHue Greenery", "#88B04B"),
        ("PrintHue Rose Quartz", "#F7CAC9"),
        ("PrintHue Serenity", "#92A8D1"),
        ("PrintHue Marsala", "#955251"),
        ("PrintHue Radiant Orchid", "#B565A7"),
    ]
    
    print(f"Loaded {len(printhue_colors)} PrintHue colors")
    return printhue_colors


def load_existing_colors(filename: str) -> Dict[str, str]:
    """Load existing colors from RGB file."""
    colors = {}
    if os.path.exists(filename):
        with open(filename, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and '\t' in line:
                    parts = line.split('\t')
                    if len(parts) >= 2:
                        name, hex_code = parts[0], parts[1].upper()
                        colors[hex_code] = name
    return colors


def merge_colors(existing: Dict[str, str], new_colors: List[Tuple[str, str]], source_name: str) -> Dict[str, str]:
    """Merge new colors with existing, avoiding duplicates."""
    added = 0
    merged = existing.copy()
    
    for name, hex_code in new_colors:
        hex_code = hex_code.upper()
        
        # Validate hex code format
        if not re.match(r'^#[0-9A-F]{6}$', hex_code):
            continue
        
        # Add if not already present
        if hex_code not in merged:
            merged[hex_code] = name
            added += 1
    
    print(f"Added {added} new colors from {source_name}")
    return merged


def save_colors(colors: Dict[str, str], filename: str):
    """Save colors to RGB file, sorted by hex value."""
    sorted_colors = sorted(colors.items(), key=lambda x: x[0])
    
    with open(filename, 'w', encoding='utf-8') as f:
        for hex_code, name in sorted_colors:
            f.write(f"{name}\t{hex_code}\n")
    
    print(f"Saved {len(colors)} colors to {filename}")


def main():
    """Main function to augment RGB colors."""
    input_file = "rgb.txt"
    backup_file = "rgb_pre_augmentation_backup.txt"
    output_file = "rgb_augmented.txt"
    
    # Create backup
    if os.path.exists(input_file):
        print(f"Creating backup: {backup_file}")
        with open(input_file, 'r') as src, open(backup_file, 'w') as dst:
            dst.write(src.read())
    
    # Load existing colors
    print("Loading existing colors...")
    existing_colors = load_existing_colors(input_file)
    print(f"Found {len(existing_colors)} existing colors")
    
    # Add Crayola colors
    print("\nAdding Crayola colors...")
    crayola_colors = get_crayola_colors()
    merged_colors = merge_colors(existing_colors, crayola_colors, "Crayola")
    
    # Add PrintHue colors
    print("\nAdding PrintHue colors...")
    printhue_colors = get_printhue_colors()
    final_colors = merge_colors(merged_colors, printhue_colors, "PrintHue")
    
    # Save augmented colors
    print(f"\nSaving augmented color collection...")
    save_colors(final_colors, output_file)
    
    print(f"\n=== Augmentation Summary ===")
    print(f"Original colors: {len(existing_colors)}")
    print(f"Final colors: {len(final_colors)}")
    print(f"New colors added: {len(final_colors) - len(existing_colors)}")
    print(f"📁 Backup: {backup_file}")
    print(f"🎨 Augmented: {output_file}")
    print(f"\nTo replace original: mv {output_file} {input_file}")


if __name__ == "__main__":
    main()