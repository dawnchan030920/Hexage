Write-Warning "Please ensure:"
Write-Warning "1. Use Github Pages."
Write-Warning "2. Use One-Click Deployment."
Write-Warning "3. Have a specific repo to store source, default branch is main, and you have config it with the local one."
Read-Host "Press to continue..."

hexo clean && hexo generate && hexo deploy
git push -u origin main

Read-Host "Deploy and backup DONE."