# setup.ps1
# Supposed to be put in the root path of hexo.
# Run when needing to download and set the hexo blog from GitHub.

# User prompt
Write-Output "Thank you for using Hexage setup script!"
Write-Output "Prerequirement: 1. You have config your git & github. 2. This script is run in the root path of your hexo project which should be empty. 3. Your npm is ok."
Write-Output "Please ensure that the hexo preject is yours."

$username = Read-Host "Please enter your github username"
$command = "git clone https://github.com/$username/$username.github.io.git"
Invoke-Expression $command
Rename-Item "./$username.github.io" ".tempor_repo"
Set-Location "./.tempor_repo"
git checkout source
Copy-Item ./* ../ -Recurse
Set-Location ..
npm i
npm install hexo-cli -g
hexo clean
Write-Output "DONE!"
Pause