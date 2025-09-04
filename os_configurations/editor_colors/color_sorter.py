#!/usr/bin/env python3
"""
RGB Color Sorter - Converts RGB colors to perceptually uniform sortable indices

Parses RGB color file and creates sortable indices based on LCH color space
for smooth perceptual transitions.
"""

import json
import math
import os
import sys
from typing import List, Dict, Tuple, Optional

try:
    import colorspacious
except ImportError:
    print("Error: colorspacious library not found.")
    print("Install with: pip install colorspacious")
    sys.exit(1)


class Color:
    """Represents a color with multiple representations and sorting capabilities."""
    
    def __init__(self, name: str, hex_code: str, line_number: int = 0):
        self.name = name
        self.hex_code = hex_code
        self.line_number = line_number
        
        # Parse RGB values
        self.rgb = self._hex_to_rgb(hex_code)
        
        # Convert to different color spaces
        self.lch = self._rgb_to_lch(self.rgb)
        self.hsv = self._rgb_to_hsv(self.rgb)
        
        # Calculate sorting indices
        self.lch_index = self._calculate_lch_index()
        self.hsv_index = self._calculate_hsv_index()
        self.lightness_index = self.lch[0]
        
        # Calculate contrast ratio with black background
        self.contrast_ratio = self._calculate_contrast_ratio()
        self.is_readable = self.contrast_ratio >= 4.5  # WCAG AA standard
    
    def _hex_to_rgb(self, hex_code: str) -> Tuple[int, int, int]:
        """Convert hex color to RGB tuple."""
        hex_code = hex_code.lstrip('#')
        return tuple(int(hex_code[i:i+2], 16) for i in (0, 2, 4))
    
    def _rgb_to_lch(self, rgb: Tuple[int, int, int]) -> Tuple[float, float, float]:
        """Convert RGB to LCH color space using colorspacious."""
        # Normalize RGB to 0-1 range
        rgb_norm = [c / 255.0 for c in rgb]
        
        # Convert RGB -> XYZ -> LAB -> LCH
        try:
            lab = colorspacious.cspace_convert(rgb_norm, "sRGB1", "CIELab")
            # Convert LAB to LCH manually
            l, a, b = lab
            c = math.sqrt(a**2 + b**2)
            h = math.degrees(math.atan2(b, a))
            if h < 0:
                h += 360
            return (l, c, h)
        except:
            # Fallback for edge cases
            return (0, 0, 0)
    
    def _rgb_to_hsv(self, rgb: Tuple[int, int, int]) -> Tuple[float, float, float]:
        """Convert RGB to HSV color space."""
        r, g, b = [c / 255.0 for c in rgb]
        
        max_val = max(r, g, b)
        min_val = min(r, g, b)
        diff = max_val - min_val
        
        # Value
        v = max_val
        
        # Saturation
        s = 0 if max_val == 0 else diff / max_val
        
        # Hue
        if diff == 0:
            h = 0
        elif max_val == r:
            h = (60 * ((g - b) / diff) + 360) % 360
        elif max_val == g:
            h = (60 * ((b - r) / diff) + 120) % 360
        else:  # max_val == b
            h = (60 * ((r - g) / diff) + 240) % 360
        
        return (h, s * 100, v * 100)
    
    def _calculate_lch_index(self) -> float:
        """Calculate sortable index based on LCH values for smooth transitions."""
        l, c, h = self.lch
        
        # Primary sort by hue (0-360), secondary by lightness, tertiary by chroma
        # Scale hue to be most significant, lightness secondary, chroma least
        return h * 10000 + l * 100 + c
    
    def _calculate_hsv_index(self) -> float:
        """Calculate sortable index based on HSV values for rainbow sorting."""
        h, s, v = self.hsv
        
        # Primary sort by hue, secondary by saturation, tertiary by value
        return h * 10000 + s * 100 + v
    
    def _calculate_contrast_ratio(self) -> float:
        """Calculate WCAG contrast ratio against black background (#000000)."""
        def relative_luminance(rgb):
            """Calculate relative luminance of RGB color."""
            def linearize(c):
                c = c / 255.0
                return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4
            
            r, g, b = rgb
            return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)
        
        color_lum = relative_luminance(self.rgb)
        black_lum = 0.0  # Black has luminance 0
        
        # Contrast ratio formula: (L1 + 0.05) / (L2 + 0.05) where L1 > L2
        return (color_lum + 0.05) / (black_lum + 0.05)
    
    def to_dict(self) -> Dict:
        """Convert color to dictionary for JSON serialization."""
        return {
            'name': self.name,
            'hex': self.hex_code,
            'rgb': self.rgb,
            'lch': {
                'l': round(self.lch[0], 2),
                'c': round(self.lch[1], 2),
                'h': round(self.lch[2], 2)
            },
            'hsv': {
                'h': round(self.hsv[0], 2),
                's': round(self.hsv[1], 2),
                'v': round(self.hsv[2], 2)
            },
            'indices': {
                'lch': round(self.lch_index, 2),
                'hsv': round(self.hsv_index, 2),
                'lightness': round(self.lightness_index, 2)
            },
            'contrast_ratio': round(self.contrast_ratio, 2),
            'readable_on_black': self.is_readable,
            'line_number': self.line_number
        }


class ColorSorter:
    """Main class for parsing and sorting RGB colors."""
    
    def __init__(self, rgb_file_path: str):
        self.rgb_file_path = rgb_file_path
        self.colors: List[Color] = []
        
    def parse_rgb_file(self) -> None:
        """Parse RGB file and create Color objects."""
        if not os.path.exists(self.rgb_file_path):
            raise FileNotFoundError(f"RGB file not found: {self.rgb_file_path}")
        
        print(f"Parsing RGB file: {self.rgb_file_path}")
        
        with open(self.rgb_file_path, 'r', encoding='utf-8') as f:
            for line_number, line in enumerate(f, 1):
                line = line.strip()
                if not line or line.startswith('#'):  # Skip empty lines and comments
                    continue
                
                # Parse tab-separated format: name\t#hexcode
                parts = line.split('\t')
                if len(parts) >= 2:
                    name = parts[0].strip()
                    hex_code = parts[1].strip()
                    
                    # Validate hex code format
                    if hex_code.startswith('#') and len(hex_code) == 7:
                        try:
                            color = Color(name, hex_code, line_number)
                            self.colors.append(color)
                        except Exception as e:
                            print(f"Warning: Failed to parse color '{name}' at line {line_number}: {e}")
                    else:
                        print(f"Warning: Invalid hex code '{hex_code}' at line {line_number}")
                else:
                    print(f"Warning: Invalid format at line {line_number}: {line}")
        
        print(f"Successfully parsed {len(self.colors)} colors")
    
    def sort_colors(self, method: str = 'lch') -> List[Color]:
        """Sort colors by specified method."""
        if method == 'lch':
            return sorted(self.colors, key=lambda c: c.lch_index)
        elif method == 'hsv':
            return sorted(self.colors, key=lambda c: c.hsv_index)
        elif method == 'lightness':
            return sorted(self.colors, key=lambda c: c.lightness_index)
        elif method == 'contrast':
            return sorted(self.colors, key=lambda c: c.contrast_ratio, reverse=True)
        else:
            raise ValueError(f"Unknown sorting method: {method}")
    
    def filter_readable_colors(self, min_contrast: float = 4.5) -> List[Color]:
        """Filter colors that are readable on black background."""
        return [c for c in self.colors if c.contrast_ratio >= min_contrast]
    
    def export_json(self, output_path: str, sort_method: str = 'lch') -> None:
        """Export sorted colors to JSON file."""
        sorted_colors = self.sort_colors(sort_method)
        
        export_data = {
            'metadata': {
                'source_file': self.rgb_file_path,
                'total_colors': len(sorted_colors),
                'readable_colors': len([c for c in sorted_colors if c.is_readable]),
                'sort_method': sort_method,
                'generated_by': 'RGB Color Sorter'
            },
            'colors': [color.to_dict() for color in sorted_colors]
        }
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2, ensure_ascii=False)
        
        print(f"Exported {len(sorted_colors)} colors to {output_path}")
    
    def print_summary(self) -> None:
        """Print summary statistics about the colors."""
        if not self.colors:
            print("No colors to analyze.")
            return
        
        readable_colors = self.filter_readable_colors()
        high_contrast = self.filter_readable_colors(7.0)  # AAA standard
        
        print("\n=== Color Analysis Summary ===")
        print(f"Total colors: {len(self.colors)}")
        print(f"Readable on black (4.5:1+): {len(readable_colors)}")
        print(f"High contrast on black (7:1+): {len(high_contrast)}")
        
        # Color space ranges
        lightness_range = (min(c.lch[0] for c in self.colors), max(c.lch[0] for c in self.colors))
        print(f"Lightness range: {lightness_range[0]:.1f} - {lightness_range[1]:.1f}")
        
        # Most/least readable colors
        sorted_by_contrast = sorted(self.colors, key=lambda c: c.contrast_ratio, reverse=True)
        print(f"Most readable: {sorted_by_contrast[0].name} ({sorted_by_contrast[0].contrast_ratio:.2f}:1)")
        print(f"Least readable: {sorted_by_contrast[-1].name} ({sorted_by_contrast[-1].contrast_ratio:.2f}:1)")


def main():
    """Main function to run the color sorter."""
    # Default path to RGB file
    default_path = os.path.expanduser("~/projects/home_files.git/os_configurations/editor_colors/rgb.txt")
    
    # Parse command line arguments
    rgb_file_path = sys.argv[1] if len(sys.argv) > 1 else default_path
    
    try:
        # Create color sorter and parse file
        sorter = ColorSorter(rgb_file_path)
        sorter.parse_rgb_file()
        
        # Print summary
        sorter.print_summary()
        
        # Export sorted colors in different formats
        output_dir = os.path.dirname(os.path.abspath(__file__))
        
        # LCH sorted (perceptually smooth)
        lch_output = os.path.join(output_dir, "sorted_colors_lch.json")
        sorter.export_json(lch_output, 'lch')
        
        # HSV sorted (rainbow order)
        hsv_output = os.path.join(output_dir, "sorted_colors_hsv.json")
        sorter.export_json(hsv_output, 'hsv')
        
        # Contrast sorted (most readable first)
        contrast_output = os.path.join(output_dir, "sorted_colors_contrast.json")
        sorter.export_json(contrast_output, 'contrast')
        
        # Main output for vim integration (LCH sorted)
        main_output = os.path.join(output_dir, "sorted_colors.json")
        sorter.export_json(main_output, 'lch')
        
        print(f"\nFiles created:")
        print(f"  {lch_output}")
        print(f"  {hsv_output}")
        print(f"  {contrast_output}")
        print(f"  {main_output}")
        
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()