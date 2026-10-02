import os
import shutil
from pathlib import Path

base = Path(r"C:\Users\mukht\Desktop\micro-entreprise\mon boite")
git_dir = base / ".git"

# Files to move
items = ["logs", "tree"]  # Known orphaned dirs in root

for item in items:
    root_path = base / item
    target_path = git_dir / item
    if root_path.exists() and not target_path.exists():
        try:
            shutil.move(str(root_path), str(target_path))
            print(f"Moved: {item}")
        except Exception as e:
            print(f"Error moving {item}: {e}")

print("Done")
