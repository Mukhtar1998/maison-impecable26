# PowerShell script to consolidate git structure
$basePath = "C:\Users\mukht\Desktop\micro-entreprise\mon boite"
Set-Location $basePath

Write-Host "🔧 Consolidating git repository structure..." -ForegroundColor Cyan

# Items to move into .git/
$gitItems = @('HEAD', 'config', 'description', 'FETCH_HEAD', 'COMMIT_EDITMSG', 'index', 'hooks', 'info', 'logs', 'objects', 'refs', 'tree')

$movedCount = 0

foreach ($item in $gitItems) {
    $sourceItem = Join-Path $basePath $item
    $targetItem = Join-Path $basePath ".git" $item
    
    # Skip if source doesn't exist
    if (!(Test-Path $sourceItem)) {
        continue
    }
    
    # Skip if already in .git
    if (Test-Path $targetItem) {
        Write-Host "  ⊘ $item : already in .git/ (skipped)" -ForegroundColor Yellow
        continue
    }
    
    # Move the item
    try {
        Move-Item -Path $sourceItem -Destination $targetItem -Force -ErrorAction Stop
        Write-Host "  ✓ Moved: $item → .git/$item" -ForegroundColor Green
        $movedCount++
    } catch {
        Write-Host "  ✗ Error moving $item : $_" -ForegroundColor Red
    }
}

Write-Host "`n✓ Consolidation complete! Moved $movedCount items." -ForegroundColor Green

Write-Host "`nFinal .git/ structure:" -ForegroundColor Cyan
Get-ChildItem -Path ".\.git" -Force | ForEach-Object {
    if ($_.PSIsContainer) {
        Write-Host "  📁 .git/$($_.Name)/" -ForegroundColor Cyan
    } else {
        Write-Host "  📄 .git/$($_.Name)" -ForegroundColor White
    }
}

Write-Host "`n✓ All git metadata is now properly organized in .git/" -ForegroundColor Green

Write-Host "`nVerifying with git status..." -ForegroundColor Cyan
& git status
