Function go-up-once { Set-Location .. }
Function go-up-twice { Set-Location ..\.. }

Set-Alias -Name '..' -Value go-up-once
Set-Alias -Name '...' -Value go-up-twice


Function remove-bin-obj { Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse } }

Set-Alias -Name 'rbo' -Value remove-bin-obj

Set-Alias -Name 'c' -Value clear
Set-Alias -Name 'v' -Value vim
Set-Alias -Name 'lg' -Value lazygit
Set-Alias -Name 'docker' -Value podman

