import os
import re

lib_dir = 'lib'

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    changed = False

    # Find the specific back button pattern
    # It looks something like:
    # GestureDetector(
    #   onTap: () => Navigator.pop(context),
    #   child: Container(
    #     padding: const EdgeInsets.all(8),
    #     decoration: BoxDecoration(
    #       color: surface,
    #       border: Border.all(color: border, width: AppDimens.borderThick),
    #       boxShadow: [BoxShadow(color: border, offset: const Offset(2, 2))],
    #     ),
    #     child: Icon(Icons.arrow_back_rounded, size: 24, color: tp),
    #   ),
    # )
    
    # Let's just use regex to find and replace
    pattern = re.compile(r'GestureDetector\s*\(\s*onTap:\s*\(\)\s*=>\s*Navigator\.pop\(context\),\s*child:\s*Container\s*\(\s*padding:\s*const EdgeInsets\.all\(8\),\s*decoration:\s*BoxDecoration\s*\(\s*color:\s*surface,\s*border:\s*Border\.all\(color:\s*border,\s*width:\s*AppDimens\.borderThick\),\s*boxShadow:\s*\[BoxShadow\(color:\s*border,\s*offset:\s*const Offset\(2,\s*2\)\)\],\s*\),\s*child:\s*(Icon\([^)]+\)),\s*\),\s*\)')

    def replacer(match):
        icon_code = match.group(1)
        return f"MshwarCardButton(\n  onTap: () => Navigator.pop(context),\n  backgroundColor: surface,\n  padding: const EdgeInsets.all(8),\n  child: {icon_code},\n)"

    new_content, count = pattern.subn(replacer, content)
    if count > 0:
        content = new_content
        changed = True
        
    # Same for close_rounded back button (in profile_screen / tracking_screen)
    pattern2 = re.compile(r'GestureDetector\s*\(\s*onTap:\s*\(\)\s*=>\s*Navigator\.pop\(context\),\s*child:\s*Container\s*\(\s*padding:\s*const EdgeInsets\.all\(8\),\s*decoration:\s*BoxDecoration\s*\(\s*color:\s*surface,\s*border:\s*Border\.all\(color:\s*border,\s*width:\s*AppDimens\.borderThick\),\s*boxShadow:\s*\[BoxShadow\(color:\s*border,\s*offset:\s*const Offset\(2,\s*2\)\)\],\s*\),\s*child:\s*(Icon\(Icons\.close_rounded[^)]+\)),\s*\),\s*\)')
    
    new_content2, count2 = pattern2.subn(replacer, content)
    if count2 > 0:
        content = new_content2
        changed = True

    if changed:
        # Make sure MshwarCardButton is imported
        if 'mshwar_card_button.dart' not in content:
            parts = filepath.split(os.sep)
            depth = len(parts) - 2 
            prefix = '../' * depth
            import_str = f"import '{prefix}shared/widgets/mshwar_card_button.dart';"
            content = content.replace("import 'package:flutter/material.dart';", f"import 'package:flutter/material.dart';\n{import_str}")
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

for root, _, files in os.walk(lib_dir):
    for f in files:
        if f.endswith('.dart'):
            process_file(os.path.join(root, f))
