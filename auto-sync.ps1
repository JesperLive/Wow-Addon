# DummyAnalyzer auto-sync: commit + push changes to GitHub
$repo = "H:\OPEN CODE WOW CHAT\Wow-Addon"
$logFile = "$repo\auto-sync.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Set-Location $repo
git pull --rebase --autostash -q 2>> $logFile

$status = git status --porcelain
if (-not $status) {
    # no changes
    exit 0
}

git add -A 2>> $logFile
git commit -m "auto-sync $timestamp" 2>> $logFile
git push -q 2>> $logFile
Add-Content $logFile "[$timestamp] Pushed $((git rev-parse HEAD).Substring(0,7))"
