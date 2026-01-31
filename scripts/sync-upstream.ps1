# OWF Sync Script - Sync updates from AWF upstream
# Usage: .\scripts\sync-upstream.ps1

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "     OWF Sync Script - Sync from AWF Upstream" -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""

# Check if upstream exists
$remotes = git remote
if ($remotes -notcontains "upstream") {
    Write-Host "Adding upstream remote..." -ForegroundColor Yellow
    git remote add upstream https://github.com/TUAN130294/awf.git
}

# Fetch upstream
Write-Host "Fetching upstream..." -ForegroundColor Cyan
git fetch upstream

# Get versions
try {
    $AWF_VERSION = (git show upstream/main:VERSION 2>$null).Trim()
} catch {
    $AWF_VERSION = "unknown"
}
$OWF_VERSION = (Get-Content VERSION -ErrorAction SilentlyContinue).Trim()

Write-Host ""
Write-Host "AWF upstream version: $AWF_VERSION" -ForegroundColor Green
Write-Host "OWF current version:  $OWF_VERSION" -ForegroundColor Yellow
Write-Host ""

# Show changes
Write-Host "Changes in upstream:" -ForegroundColor Cyan
git log main..upstream/main --oneline 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "No new commits or branches diverged" -ForegroundColor Gray
}

Write-Host ""
Write-Host "Files changed:" -ForegroundColor Cyan
git diff main upstream/main --stat 2>$null | Select-Object -Last 20

Write-Host ""
Write-Host "===============================================================" -ForegroundColor Yellow
Write-Host "MANUAL STEPS REQUIRED:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Create sync branch:" -ForegroundColor White
Write-Host "   git checkout -b sync-awf-$AWF_VERSION" -ForegroundColor Green
Write-Host ""
Write-Host "2. For each updated workflow, run:" -ForegroundColor White
Write-Host "   git show upstream/main:workflows/FILENAME.md > commands/FILENAME.md" -ForegroundColor Green
Write-Host ""
Write-Host "3. For each updated skill, run:" -ForegroundColor White
Write-Host "   git show upstream/main:awf_skills/SKILL_NAME/SKILL.md > skills/SKILL_NAME/SKILL.md" -ForegroundColor Green
Write-Host ""
Write-Host "4. Copy schemas and templates:" -ForegroundColor White
Write-Host "   git checkout upstream/main -- schemas/ templates/" -ForegroundColor Green
Write-Host ""
Write-Host "5. Update paths in copied files:" -ForegroundColor White
Write-Host "   - Replace ~/.gemini/antigravity/ with ~/.config/opencode/" -ForegroundColor Gray
Write-Host "   - Replace GEMINI.md with OWF_INSTRUCTIONS.md" -ForegroundColor Gray
Write-Host ""
Write-Host "6. Update VERSION and commit:" -ForegroundColor White
Write-Host "   Set-Content VERSION '1.x.x'" -ForegroundColor Green
Write-Host "   git add . ; git commit -m 'Sync with AWF v$AWF_VERSION'" -ForegroundColor Green
Write-Host ""
Write-Host "7. Merge and push:" -ForegroundColor White
Write-Host "   git checkout main ; git merge sync-awf-$AWF_VERSION ; git push" -ForegroundColor Green
Write-Host ""
Write-Host "===============================================================" -ForegroundColor Yellow
