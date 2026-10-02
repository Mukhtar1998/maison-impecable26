#!/usr/bin/env python3
"""
Git tree repair script: consolidates orphaned git files into .git/
"""
import os
import shutil
from pathlib import Path

base_path = Path(r"C:\Users\mukht\Desktop\micro-entreprise\mon boite")
git_dir = base_path / ".git"

# Ensure .git exists
if not git_dir.exists():
    git_dir.mkdir(parents=True, exist_ok=True)
    print(f"✓ Created .git directory")

# List of git metadata that should be in .git/
git_metadata = ["HEAD", "config", "description", "FETCH_HEAD", "COMMIT_EDITMSG", 
                "hooks", "index", "logs", "objects", "refs", "info", "tree"]

print("Scanning for orphaned git files in root...")
moved = 0
skipped = 0

for item in git_metadata:
    root_item = base_path / item
    git_item = git_dir / item
    
    if root_item.exists():
        # If it's already in .git, skip
        if git_item.exists():
            print(f"  ⊘ {item}: already in .git (skipped)")
            skipped += 1
            continue
        
        # Move to .git/
        try:
            if root_item.is_dir():
                shutil.move(str(root_item), str(git_item))
            else:
                shutil.move(str(root_item), str(git_item))
            print(f"  ✓ Moved {item} → .git/{item}")
            moved += 1
        except Exception as e:
            print(f"  ✗ Failed to move {item}: {e}")

print(f"\nSummary: {moved} files moved, {skipped} skipped")
print("\nFinal .git structure:")
for item in sorted(os.listdir(git_dir)):
    print(f"  .git/{item}")

print("\n✓ Git tree cleanup complete!")
