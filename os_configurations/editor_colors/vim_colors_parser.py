#!/usr/bin/env python3
"""
Vim Colors Parser - Extracts colors from onedark.vim autoload file

Parses the vim autoload file to extract color names and hex values,
then generates a terminal preview HTML page for those specific colors.
"""

import json
import math
import os
import re
import sys
from typing import List, Dict, Tuple, Optional


class VimColor:
    """Represents a color from vim colorscheme with terminal preview capabilities."""
    
    def __init__(self, name: str, hex_code: str, cterm: str = "", cterm16: str = ""):
        self.name = name
        self.hex_code = hex_code
        self.cterm = cterm
        self.cterm16 = cterm16
        
        # Parse RGB values
        self.rgb = self._hex_to_rgb(hex_code)
        
        # Calculate properties for terminal display
        self.contrast_ratio = self._calculate_contrast_ratio()
        self.is_readable = self.contrast_ratio >= 4.5
        self.lightness = self._calculate_lightness()
        
    def _hex_to_rgb(self, hex_code: str) -> Tuple[int, int, int]:
        """Convert hex color to RGB tuple."""
        hex_code = hex_code.lstrip('#')
        if len(hex_code) != 6:
            raise ValueError(f"Invalid hex code: {hex_code}")
        return tuple(int(hex_code[i:i+2], 16) for i in (0, 2, 4))
    
    def _calculate_lightness(self) -> float:
        """Calculate perceived lightness (0-100)."""
        r, g, b = [c / 255.0 for c in self.rgb]
        # Simple luminance calculation
        return (0.299 * r + 0.587 * g + 0.114 * b) * 100
    
    def _calculate_contrast_ratio(self) -> float:
        """Calculate WCAG contrast ratio against black background."""
        def relative_luminance(rgb):
            def linearize(c):
                c = c / 255.0
                return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4
            
            r, g, b = rgb
            return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)
        
        color_lum = relative_luminance(self.rgb)
        black_lum = 0.0
        return (color_lum + 0.05) / (black_lum + 0.05)
    
    def to_dict(self) -> Dict:
        """Convert to dictionary for JSON serialization."""
        return {
            'name': self.name,
            'hex': self.hex_code,
            'rgb': self.rgb,
            'cterm': self.cterm,
            'cterm16': self.cterm16,
            'contrast_ratio': round(self.contrast_ratio, 2),
            'readable_on_black': self.is_readable,
            'lightness': round(self.lightness, 2)
        }


class VimColorParser:
    """Parser for vim autoload color files."""
    
    def __init__(self, autoload_file_path: str):
        self.autoload_file_path = autoload_file_path
        self.colors: List[VimColor] = []
    
    def parse_autoload_file(self) -> None:
        """Parse vim autoload file and extract color definitions."""
        if not os.path.exists(self.autoload_file_path):
            raise FileNotFoundError(f"Vim autoload file not found: {self.autoload_file_path}")
        
        print(f"Parsing vim autoload file: {self.autoload_file_path}")
        
        with open(self.autoload_file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Find the s:colors dictionary - need to match the whole block with \}
        colors_match = re.search(r'let\s+s:colors\s*=\s*{(.*?)\\\}', content, re.DOTALL)
        if not colors_match:
            raise ValueError("Could not find s:colors dictionary in vim file")
        
        colors_content = colors_match.group(1)
        
        # Parse each color line with vim backslash continuation
        # Pattern matches: \ "name": get(..., { "gui": "#hex", "cterm": "...", "cterm16": "..." }),
        color_pattern = r'\\\s*"([^"]+)":\s*get\([^,]+,\s*"[^"]+",\s*{\s*"gui":\s*"([^"]+)"(?:,\s*"cterm":\s*"([^"]*)")?(?:,\s*"cterm16":\s*"([^"]*)")?[^}]*}\s*\)'
        
        matches = re.findall(color_pattern, colors_content, re.MULTILINE)
        
        for match in matches:
            color_name = match[0]
            gui_color = match[1]
            cterm_color = match[2] if len(match) > 2 else ""
            cterm16_color = match[3] if len(match) > 3 else ""
            
            try:
                # Validate hex color
                if gui_color.startswith('#') and len(gui_color) == 7:
                    color = VimColor(color_name, gui_color, cterm_color, cterm16_color)
                    self.colors.append(color)
                else:
                    print(f"Warning: Invalid hex color '{gui_color}' for '{color_name}'")
            except Exception as e:
                print(f"Warning: Failed to parse color '{color_name}': {e}")
        
        print(f"Successfully parsed {len(self.colors)} colors from vim file")
    
    def sort_colors(self, method: str = 'rainbow') -> List[VimColor]:
        """Sort colors by specified method."""
        if method == 'rainbow':
            # Sort by hue for rainbow ordering
            def get_hue(color):
                r, g, b = [c / 255.0 for c in color.rgb]
                max_val = max(r, g, b)
                min_val = min(r, g, b)
                diff = max_val - min_val
                
                if diff == 0:
                    return 0
                elif max_val == r:
                    hue = (60 * ((g - b) / diff) + 360) % 360
                elif max_val == g:
                    hue = (60 * ((b - r) / diff) + 120) % 360
                else:
                    hue = (60 * ((r - g) / diff) + 240) % 360
                
                return hue
            
            return sorted(self.colors, key=get_hue)
        elif method == 'lightness':
            return sorted(self.colors, key=lambda c: c.lightness, reverse=True)
        elif method == 'contrast':
            return sorted(self.colors, key=lambda c: c.contrast_ratio, reverse=True)
        elif method == 'name':
            return sorted(self.colors, key=lambda c: c.name.lower())
        else:
            return self.colors  # original order
    
    def generate_html_preview(self, output_path: str, title: str = "Vim Colors Preview") -> None:
        """Generate HTML preview of vim colors."""
        sorted_colors = self.sort_colors('rainbow')
        
        html_content = f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        body {{
            font-family: 'Fira Code', 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            background: #000000;
            color: #ffffff;
            padding: 20px;
            line-height: 1.4;
        }}
        
        .header {{
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: #111111;
            border-radius: 8px;
        }}
        
        .header h1 {{
            color: #00ff00;
            margin-bottom: 10px;
        }}
        
        .controls {{
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }}
        
        .control-group {{
            display: flex;
            align-items: center;
            gap: 5px;
            color: #cccccc;
        }}
        
        .control-group label {{
            font-size: 14px;
        }}
        
        .control-group input, .control-group select {{
            background: #333333;
            color: #ffffff;
            border: 1px solid #555555;
            padding: 5px 10px;
            border-radius: 4px;
            font-family: inherit;
        }}
        
        .stats {{
            background: #111111;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            color: #cccccc;
        }}
        
        .color-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 15px;
        }}
        
        .color-sample {{
            background: #111111;
            border: 1px solid #333333;
            border-radius: 8px;
            padding: 15px;
            position: relative;
        }}
        
        .color-sample.low-contrast {{
            opacity: 0.6;
            border-color: #ff4444;
        }}
        
        .color-info {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            font-size: 12px;
            color: #888888;
        }}
        
        .color-name {{
            font-weight: bold;
            max-width: 60%;
            overflow: hidden;
            text-overflow: ellipsis;
        }}
        
        .color-meta {{
            text-align: right;
            font-size: 11px;
        }}
        
        .vim-info {{
            font-size: 10px;
            color: #666666;
            margin-bottom: 8px;
        }}
        
        .contrast-warning {{
            color: #ff4444;
            font-size: 10px;
        }}
        
        .code-sample {{
            background: #000000;
            padding: 15px;
            border-radius: 6px;
            border: 1px solid #333333;
            font-size: 14px;
            white-space: pre-wrap;
            font-family: 'Fira Code', 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
        }}
        
        .contrast-indicator {{
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
            margin-left: 5px;
        }}
        
        .contrast-good {{ background: #00ff00; }}
        .contrast-fair {{ background: #ffff00; }}
        .contrast-poor {{ background: #ff0000; }}
        
        .filter-info {{
            color: #888888;
            font-size: 12px;
            text-align: center;
            margin: 20px 0;
        }}
        
        .hidden {{ display: none; }}
    </style>
</head>
<body>
    <div class="header">
        <h1>{title}</h1>
        <p>Colors from onedark.vim autoload file on Black Background (#000000)</p>
        <p>Showing your custom vim colorscheme colors</p>
    </div>
    
    <div class="controls">
        <div class="control-group">
            <label for="minContrast">Min Contrast:</label>
            <select id="minContrast">
                <option value="0">All Colors</option>
                <option value="3">3:1 (Minimum)</option>
                <option value="4.5" selected>4.5:1 (AA)</option>
                <option value="7">7:1 (AAA)</option>
            </select>
        </div>
        
        <div class="control-group">
            <label for="sortMethod">Sort by:</label>
            <select id="sortMethod">
                <option value="rainbow" selected>Rainbow (Hue)</option>
                <option value="lightness">Lightness</option>
                <option value="contrast">Contrast Ratio</option>
                <option value="name">Name</option>
                <option value="original">Original Order</option>
            </select>
        </div>
        
        <div class="control-group">
            <label for="codeStyle">Code Sample:</label>
            <select id="codeStyle">
                <option value="vim" selected>Vim Script</option>
                <option value="javascript">JavaScript</option>
                <option value="python">Python</option>
                <option value="c">C/C++</option>
            </select>
        </div>
        
        <div class="control-group">
            <label for="searchFilter">Search:</label>
            <input type="text" id="searchFilter" placeholder="Filter by name...">
        </div>
    </div>
    
    <div class="stats" id="stats"></div>
    <div class="filter-info" id="filterInfo"></div>
    
    <div class="color-grid" id="colorGrid"></div>

    <script>
        const allColors = {json.dumps([color.to_dict() for color in sorted_colors], indent=8)};
        
        let filteredColors = [];
        
        const codeSamples = {{
            vim: (colorName) => `" Vim colorscheme using ${{colorName}}
highlight Normal guifg=${{colorName}} guibg=#000000
let g:colors_name = "${{colorName}}"
" Sample syntax highlighting
if condition == "true" | echo "hello" | endif`,
            
            javascript: (colorName) => `function ${{colorName.replace(/[^a-zA-Z0-9]/g, '_')}}() {{
    let variable = "string literal";
    const number = 42;
    return variable + number; // comment
}}`,
            
            python: (colorName) => `def ${{colorName.replace(/[^a-zA-Z0-9]/g, '_')}}():
    variable = "string literal"
    number = 42
    return variable + str(number)  # comment`,
            
            c: (colorName) => `int ${{colorName.replace(/[^a-zA-Z0-9]/g, '_')}}() {{
    char* variable = "string literal";
    int number = 42;
    return strlen(variable) + number; // comment
}}`
        }};
        
        function createColorSample(color, codeStyle) {{
            const contrast = color.contrast_ratio;
            
            const colorSample = document.createElement('div');
            colorSample.className = 'color-sample';
            colorSample.dataset.contrast = contrast.toFixed(2);
            colorSample.dataset.name = color.name.toLowerCase();
            
            if (contrast < 4.5) {{
                colorSample.classList.add('low-contrast');
            }}
            
            // Contrast indicator
            let contrastClass = 'contrast-poor';
            if (contrast >= 7) contrastClass = 'contrast-good';
            else if (contrast >= 4.5) contrastClass = 'contrast-fair';
            
            const codeTemplate = codeSamples[codeStyle];
            const codeSample = codeTemplate(color.name);
            
            const vimInfo = `cterm: ${{color.cterm || 'none'}} | cterm16: ${{color.cterm16 || 'none'}}`;
            
            colorSample.innerHTML = `
                <div class="color-info">
                    <div class="color-name" style="color: ${{color.hex}}">${{color.name}}</div>
                    <div class="color-meta">
                        ${{color.hex}}
                        <span class="contrast-indicator ${{contrastClass}}"></span>
                        ${{contrast.toFixed(1)}}:1
                        ${{contrast < 3 ? '<div class="contrast-warning">Low Contrast!</div>' : ''}}
                    </div>
                </div>
                <div class="vim-info">${{vimInfo}}</div>
                <div class="code-sample" style="color: ${{color.hex}}">
                    ${{codeSample}}
                </div>
            `;
            
            return colorSample;
        }}
        
        function updateStats() {{
            const readableColors = allColors.filter(color => color.readable_on_black);
            const highContrastColors = allColors.filter(color => color.contrast_ratio >= 7);
            
            const statsEl = document.getElementById('stats');
            statsEl.innerHTML = `
                <strong>Total Colors:</strong> ${{allColors.length}} |
                <strong>AA Readable (4.5:1+):</strong> ${{readableColors.length}} |
                <strong>AAA Readable (7:1+):</strong> ${{highContrastColors.length}}
            `;
        }}
        
        function filterAndRender() {{
            const minContrast = parseFloat(document.getElementById('minContrast').value);
            const sortMethod = document.getElementById('sortMethod').value;
            const searchTerm = document.getElementById('searchFilter').value.toLowerCase();
            
            // Filter colors
            filteredColors = allColors.filter(color => {{
                const matchesContrast = color.contrast_ratio >= minContrast;
                const matchesSearch = color.name.toLowerCase().includes(searchTerm);
                return matchesContrast && matchesSearch;
            }});
            
            // Sort colors (data is already sorted by rainbow, so only re-sort if different method)
            if (sortMethod !== 'rainbow' && sortMethod !== 'original') {{
                filteredColors.sort((a, b) => {{
                    switch (sortMethod) {{
                        case 'contrast':
                            return b.contrast_ratio - a.contrast_ratio;
                        case 'lightness':
                            return b.lightness - a.lightness;
                        case 'name':
                            return a.name.localeCompare(b.name);
                        default:
                            return 0;
                    }}
                }});
            }}
            
            renderColors();
            updateFilterInfo();
        }}
        
        function renderColors() {{
            const colorGrid = document.getElementById('colorGrid');
            const codeStyle = document.getElementById('codeStyle').value;
            
            colorGrid.innerHTML = '';
            
            filteredColors.forEach(color => {{
                const colorSample = createColorSample(color, codeStyle);
                colorGrid.appendChild(colorSample);
            }});
        }}
        
        function updateFilterInfo() {{
            const filterInfo = document.getElementById('filterInfo');
            const total = allColors.length;
            const showing = filteredColors.length;
            
            if (showing < total) {{
                filterInfo.textContent = `Showing ${{showing}} of ${{total}} colors`;
                filterInfo.style.display = 'block';
            }} else {{
                filterInfo.style.display = 'none';
            }}
        }}
        
        // Event listeners
        document.getElementById('minContrast').addEventListener('change', filterAndRender);
        document.getElementById('sortMethod').addEventListener('change', filterAndRender);
        document.getElementById('codeStyle').addEventListener('change', filterAndRender);
        document.getElementById('searchFilter').addEventListener('input', filterAndRender);
        
        // Initialize
        updateStats();
        filterAndRender();
        
        // Add click to copy hex codes
        document.addEventListener('click', function(e) {{
            if (e.target.classList.contains('color-meta') || e.target.closest('.color-meta')) {{
                const hex = e.target.textContent.match(/#[0-9A-Fa-f]{{6}}/);
                if (hex && navigator.clipboard) {{
                    navigator.clipboard.writeText(hex[0]);
                    const originalText = e.target.textContent;
                    e.target.textContent = 'Copied!';
                    setTimeout(() => {{
                        e.target.textContent = originalText;
                    }}, 1000);
                }}
            }}
        }});
    </script>
</body>
</html>'''
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        print(f"Generated HTML preview: {output_path}")
    
    def export_json(self, output_path: str) -> None:
        """Export vim colors to JSON file."""
        sorted_colors = self.sort_colors('rainbow')
        
        export_data = {
            'metadata': {
                'source_file': self.autoload_file_path,
                'total_colors': len(sorted_colors),
                'readable_colors': len([c for c in sorted_colors if c.is_readable]),
                'generated_by': 'Vim Colors Parser'
            },
            'colors': [color.to_dict() for color in sorted_colors]
        }
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2, ensure_ascii=False)
        
        print(f"Exported vim colors to JSON: {output_path}")


def main():
    """Main function to parse vim colors and generate preview."""
    # Default path to vim autoload file
    default_path = os.path.expanduser("~/projects/home_files.git/.config/vim/autoload/onedark.vim")
    
    # Parse command line arguments
    autoload_file_path = sys.argv[1] if len(sys.argv) > 1 else default_path
    
    try:
        # Create parser and parse file
        parser = VimColorParser(autoload_file_path)
        parser.parse_autoload_file()
        
        if not parser.colors:
            print("No colors found in vim file!")
            sys.exit(1)
        
        # Generate outputs in the same directory as this script
        output_dir = os.path.dirname(os.path.abspath(__file__))
        
        # Generate HTML preview
        html_output = os.path.join(output_dir, "vim_colors_preview.html")
        parser.generate_html_preview(html_output, "OneDark Vim Colors Preview")
        
        # Export JSON
        json_output = os.path.join(output_dir, "vim_colors.json")
        parser.export_json(json_output)
        
        # Print summary
        readable_colors = [c for c in parser.colors if c.is_readable]
        high_contrast = [c for c in parser.colors if c.contrast_ratio >= 7]
        
        print(f"\\n=== Vim Colors Summary ===")
        print(f"Total colors: {len(parser.colors)}")
        print(f"Readable on black (4.5:1+): {len(readable_colors)}")
        print(f"High contrast on black (7:1+): {len(high_contrast)}")
        
        print(f"\\nFiles created:")
        print(f"  {html_output}")
        print(f"  {json_output}")
        
        print(f"\\nTo view: python3 -m http.server 8000")
        print(f"Then open: http://localhost:8000/vim_colors_preview.html")
        
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()