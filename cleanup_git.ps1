$basePath = "C:\Users\mukht\Desktop\micro-entreprise\mon boite"
Set-Location $basePath

# List current repo state
Write-Host "Current directory: $(Get-Location)" -ForegroundColor Cyan
Write-Host "Files in root:" -ForegroundColor Cyan
Get-ChildItem -Force | Select-Object -ExpandProperty Name | Sort-Object

# Check if .git folder exists and is valid
Write-Host "`n.git folder status:" -ForegroundColor Cyan
if (Test-Path ".\.git" -PathType Container) {
    Write-Host ".git folder exists" -ForegroundColor Green
    Write-Host ".git contents:" -ForegroundColor Cyan
    Get-ChildItem -Path ".\.git" -Force | Select-Object -ExpandProperty Name | Sort-Object
} else {
    Write-Host ".git folder missing or invalid" -ForegroundColor Red
}

# Check for orphaned git files in root
Write-Host "`nOrphaned git files in root:" -ForegroundColor Cyan
@('HEAD', 'config', 'description', 'FETCH_HEAD', 'COMMIT_EDITMSG', 'hooks', 'index', 'logs', 'objects', 'refs', 'info', 'tree') | ForEach-Object {
    if (Test-Path $_ -PathType Any) {
        Write-Host "  Found: $_" -ForegroundColor Yellow
    }
}

# Try to repair: move orphaned files into .git if they exist
Write-Host "`nAttempting to consolidate git files..." -ForegroundColor Cyan

if (!(Test-Path ".\.git" -PathType Container)) {
    Write-Host "Creating .git directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path ".\.git" -Force | Out-Null
}

$orphanedFiles = @('HEAD', 'config', 'description', 'FETCH_HEAD', 'COMMIT_EDITMSG', 'hooks', 'index', 'logs', 'objects', 'refs', 'info', 'tree')
foreach ($file in $orphanedFiles) {
    if ((Test-Path $file -PathType Any) -and (!(Test-Path ".\.git\$file" -PathType Any))) {
        try {
            Move-Item -Path $file -Destination ".\.git\$file" -Force -ErrorAction SilentlyContinue
            Write-Host "  Moved: $file -> .git\$file" -ForegroundColor Green
        } catch {
            Write-Host "  Failed to move $file : $_" -ForegroundColor Red
        }
    }
}

# Verify git status
Write-Host "`nVerifying git status..." -ForegroundColor Cyan
try {
    $status = & git status 2>&1
    Write-Host $status -ForegroundColor Green
} catch {
    Write-Host "Git status check failed: $_" -ForegroundColor Red
}

Write-Host "`nCleanup complete!" -ForegroundColor Green
