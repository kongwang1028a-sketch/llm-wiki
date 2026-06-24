Set-Location "D:\Kiro\llm-wiki"
git add -A
$status = git status --porcelain
if ($status) {
    git commit -m "auto-backup: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git push origin main
}
