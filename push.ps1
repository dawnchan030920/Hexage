# push.ps1
# Supposed to be put in the root path of hexo.
# Run when needing to deploy an existing local hexo project on GitHub Pages.

# User prompt
Write-Output "Thank you for using Hexage pushing script!"
Write-Output "Prerequirements: 1. You have config your git. 2. You have created your project on github."
Write-Output "Please ensure that your usage is within the following ones:"
Write-Output "1. You don't have the transfer folder named '.tempor_repo', indicating you havn't used it before."
Write-Output "2. You have the transfer folder, and it's generated and processed automatically by the script."
Write-Output "If you have '.tempor_repo' folder but unsure whether it can be executed by the script successfully, please delete it entirely and let the script generate a brand new one."
Write-Warning "If you delete the folder entirely, you may lose some information."
Read-Host "Ensure that you want to continue, in which case press Enter"

hexo clean
hexo generate

if (! (Test-Path "./.tempor_repo")) {
    mkdir "./.tempor_repo"
    Set-Location "./.tempor_repo"
    git init
    Copy-Item ../public/* . -Recurse
    git add .
    git commit -m "Init main"
    git branch -m master main
    $username = Read-Host "Please enter you github username"
    $command = "git remote add origin https://github.com/$username/$username.github.io.git"
    Invoke-Expression $command
    git branch source
    Remove-Item ./* -Recurse
    git checkout source
    Copy-Item ../scaffolds,../themes,../source,../_config.landscape.yml,../_config.yml,../package.json,../package-lock.json . -Recurse
    git add .
    git commit -m "Init source"
    git checkout main
    git push origin main --force
    git checkout source
    git push origin source --force
}
else {
    Set-Location "./.tempor_repo"
    git checkout main
    Copy-Item ../public/* . -Recurse
    git add .
    git commit -m "Update main"
    git checkout source
    Copy-Item ../scaffolds,../themes,../source,../_config.landscape.yml,../_config.yml,../package.json,../package-lock.json . -Recurse
    git add .
    git commit -m "Update source"
    git checkout main
    git push origin main --force
    git checkout source
    git push origin source --force
}
Write-Output "DONE!"
Pause