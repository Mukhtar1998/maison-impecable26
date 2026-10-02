import os
import shutil
from pathlib import Path

base = Path(r"C:\Users\mukht\Desktop\micro-entreprise\mon boite")
git_dir = base / ".git"

# Ensure .git exists
git_dir.mkdir(exist_ok=True)

# List of git-related files/folders that should be in .git/
git_items = [
    'HEAD', 'config', 'description', 'FETCH_HEAD', 'COMMIT_EDITMSG', 'index',
    'hooks', 'info', 'logs', 'objects', 'refs', 'tree'
]

print("Moving orphaned git files/folders into .git/...\n")

moved_count = 0
for item in git_items:
    root_path = base / item
    target_path = git_dir / item
    
    # Skip if source doesn't exist in root
    if not root_path.exists():
        continue
    
    # Skip if already in .git
    if target_path.exists():
        print(f"⊘ {item}: already in .git/ (skipped)")
        continue
    
    try:
        shutil.move(str(root_path), str(target_path))
        print(f"✓ Moved: {item} → .git/{item}")
        moved_count += 1
    except Exception as e:
        print(f"✗ Error moving {item}: {e}")

print(f"\n✓ Consolidation complete! Moved {moved_count} items.")
print("\nFinal .git/ structure:")
for item in sorted(os.listdir(git_dir)):
    path = git_dir / item
    if path.is_dir():
        print(f"  📁 .git/{item}/")
    else:
        print(f"  📄 .git/{item}")

print("\n✓ All git metadata is now properly organized in .git/")
