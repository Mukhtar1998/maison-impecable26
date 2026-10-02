# PowerShell script to push changes to main
$projectPath = "C:\Users\mukht\Desktop\micro-entreprise\mon boite"
Set-Location $projectPath

Write-Host "📦 Pushing changes to main branch..." -ForegroundColor Cyan

# Show current status
Write-Host "`n=== Git Status ===" -ForegroundColor Yellow
& git status

# Stage all changes
Write-Host "`n=== Staging changes ===" -ForegroundColor Yellow
& git add .

# Commit
Write-Host "`n=== Committing changes ===" -ForegroundColor Yellow
$commitMsg = "Update: smooth scrolling, email validation for reviews, testimonials toggle, and git structure fix"
& git commit -m $commitMsg

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Commit successful" -ForegroundColor Green
} else {
    Write-Host "⊘ No changes to commit or commit failed" -ForegroundColor Yellow
}

# Check remotes
Write-Host "`n=== Git Remotes ===" -ForegroundColor Yellow
& git remote -v

# Push to main
Write-Host "`n=== Pushing to main ===" -ForegroundColor Yellow
& git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ Push successful!" -ForegroundColor Green
} else {
    Write-Host "`n✗ Push failed. Check your remote URL and credentials." -ForegroundColor Red
}

# Show recent commits
Write-Host "`n=== Recent Commits ===" -ForegroundColor Yellow
& git log --oneline -5
