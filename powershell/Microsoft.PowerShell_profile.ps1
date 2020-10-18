#configure Readline features.
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Work around an RS5/PSReadline-2.0.0+beta2 bug (Spacebar is not marked 'essential')
Set-PSReadlineKeyHandler "Shift+SpaceBar" -ScriptBlock { [Microsoft.Powershell.PSConsoleReadLine]::Insert(' ') }

#allow 'ls -l' simply alias to ls.
Remove-Item alias:\ls -ErrorAction SilentlyContinue; function ls() { Get-ChildItem }

# use curl.exe rather than Invoke-WebRequest
Remove-Item alias:\curl -ErrorAction SilentlyContinue

# get rid of that annoying snap assist
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'SnapAssist' -value 0 -Type DWORD

