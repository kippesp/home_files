#!/usr/bin/env python3
"""
RGB Color Deduplicator - Removes duplicate colors and keeps real-world names

Cleans up rgb.txt by:
1. Removing duplicate hex values
2. Keeping names that reference real-world objects/colors
3. Prioritizing practical over cute/marketing names
"""

import re
from typing import Dict, List, Tuple
from collections import defaultdict


class ColorDeduplicator:
    """Deduplicates colors and selects best real-world names."""
    
    def __init__(self):
        # Priority scoring for color names (higher = better)
        self.name_priority_patterns = [
            # Basic color names (highest priority)
            (r'^(black|white|red|green|blue|yellow|orange|purple|pink|brown|grey|gray|cyan|magenta)$', 100),
            
            # Real world objects - metals, materials
            (r'(copper|bronze|silver|gold|steel|iron|brass|tin|lead|zinc|aluminum|platinum)', 90),
            
            # Real world objects - natural materials  
            (r'(ivory|bone|coral|amber|jade|turquoise|ruby|emerald|sapphire|pearl)', 85),
            
            # Real world objects - common items
            (r'(leather|denim|khaki|navy|maroon|burgundy|crimson|scarlet|olive)', 80),
            
            # Real world - nature
            (r'(sky|ocean|forest|grass|sand|stone|earth|mud|clay|ash|charcoal)', 75),
            
            # Basic descriptive modifiers
            (r'^(dark|light|pale|bright|deep|medium|light)\s+(black|white|red|green|blue|yellow|orange|purple|pink|brown|grey|gray|cyan|magenta)', 70),
            
            # Brand names with real-world meaning
            (r'barbie|coca.?cola', 60),
            
            # Technical but understandable
            (r'(matte|satin|metallic)', 50),
            
            # Fantasy/cute names (low priority)
            (r'(goblin|warboss|vampyre|cursed|existential|angst|dreamless|sleep)', 10),
            (r'(hottest|ultimate|supreme|maximum|divine|transcendent|quantum|meta)', 5),
            (r'(waaaagh|omni)', 1),
        ]
    
    def score_name(self, name: str) -> int:
        """Score a color name based on real-world practicality."""
        name_lower = name.lower().strip()
        
        # Shorter names are generally better (within reason)
        length_bonus = max(0, 20 - len(name_lower))
        
        # Check priority patterns
        for pattern, score in self.name_priority_patterns:
            if re.search(pattern, name_lower):
                return score + length_bonus
        
        # Default score for unmatched names
        return 20 + length_bonus
    
    def select_best_name(self, names: List[str]) -> str:
        """Select the best name from a list of candidates."""
        if len(names) == 1:
            return names[0]
        
        # Score all names and return the best
        scored_names = [(name, self.score_name(name)) for name in names]
        scored_names.sort(key=lambda x: x[1], reverse=True)
        
        return scored_names[0][0]
    
    def deduplicate_colors(self, input_file: str, output_file: str) -> None:
        """Deduplicate colors in RGB file."""
        print(f"Reading colors from: {input_file}")
        
        # Group colors by hex value
        color_groups: Dict[str, List[str]] = defaultdict(list)
        
        with open(input_file, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                
                parts = line.split('\t')
                if len(parts) >= 2:
                    name = parts[0].strip()
                    hex_code = parts[1].strip().upper()
                    
                    if re.match(r'^#[0-9A-F]{6}$', hex_code):
                        color_groups[hex_code].append(name)
                    else:
                        print(f"Warning: Invalid hex code '{hex_code}' at line {line_num}")
        
        print(f"Found {len(color_groups)} unique hex colors")
        print(f"Total color names: {sum(len(names) for names in color_groups.values())}")
        
        # Select best name for each hex color
        deduplicated_colors: List[Tuple[str, str]] = []
        duplicate_count = 0
        
        for hex_code, names in color_groups.items():
            if len(names) > 1:
                duplicate_count += len(names) - 1
                print(f"{hex_code}: {len(names)} names -> keeping '{self.select_best_name(names)}'")
                if len(names) <= 5:  # Only show examples for small groups
                    print(f"    Options were: {', '.join(names)}")
            
            best_name = self.select_best_name(names)
            deduplicated_colors.append((best_name, hex_code))
        
        # Sort by hex value for consistent output
        deduplicated_colors.sort(key=lambda x: x[1])
        
        # Write deduplicated file
        print(f"\nWriting deduplicated colors to: {output_file}")
        with open(output_file, 'w', encoding='utf-8') as f:
            for name, hex_code in deduplicated_colors:
                f.write(f"{name}\t{hex_code}\n")
        
        print(f"\n=== Deduplication Summary ===")
        print(f"Original colors: {sum(len(names) for names in color_groups.values())}")
        print(f"Unique colors: {len(deduplicated_colors)}")
        print(f"Duplicates removed: {duplicate_count}")
        print(f"Reduction: {duplicate_count / sum(len(names) for names in color_groups.values()) * 100:.1f}%")


def main():
    """Main function."""
    import os
    
    # File paths
    input_file = "rgb.txt"
    backup_file = "rgb_original_backup.txt"
    output_file = "rgb_deduplicated.txt"
    
    if not os.path.exists(input_file):
        print(f"Error: {input_file} not found!")
        return
    
    try:
        # Create backup
        print(f"Creating backup: {backup_file}")
        with open(input_file, 'r') as src, open(backup_file, 'w') as dst:
            dst.write(src.read())
        
        # Deduplicate
        deduplicator = ColorDeduplicator()
        deduplicator.deduplicate_colors(input_file, output_file)
        
        print(f"\n✅ Deduplication complete!")
        print(f"📁 Original backed up as: {backup_file}")
        print(f"🎨 Clean colors saved as: {output_file}")
        print(f"\nTo replace original: mv {output_file} {input_file}")
        
    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    main()