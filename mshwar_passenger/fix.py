import os

lib_dir = 'lib'

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    changed = False

    if 'MaterialPageRoute(' in content:
        content = content.replace('MaterialPageRoute(', 'MshwarPageRoute(')
        
        # Calculate relative path to core/routes/mshwar_page_route.dart
        parts = filepath.split(os.sep)
        # remove 'lib' and filename
        depth = len(parts) - 2 
        prefix = '../' * depth
        if depth == 0:
            import_str = "import 'core/routes/mshwar_page_route.dart';"
        else:
            import_str = f"import '{prefix}core/routes/mshwar_page_route.dart';"
            
        if 'mshwar_page_route.dart' not in content:
            content = content.replace("import 'package:flutter/material.dart';", f"import 'package:flutter/material.dart';\n{import_str}")
        changed = True

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

for root, _, files in os.walk(lib_dir):
    for f in files:
        if f.endswith('.dart'):
            process_file(os.path.join(root, f))
