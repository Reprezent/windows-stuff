function prompt {
    $RED = "#bd3c47"

    $name = "$(Text -ForegroundColor $RED $env:username)"
    $separator = "$(Text -ForegroundColor Cyan ":")"
    $computer = "$(Text -ForegroundColor $RED $env:computername) "
    $location = "$(Get-Location)"
    $end = "$(Text -fg Cyan "> ")"
    $vssstatus = "$(Write-GitStatus $(Get-GitStatus)) "
    if ($vssstatus -eq " ") {
        $vssstatus = ""
    }
    return $name+$separator+$computer+$location+$end+$vssstatus
}

if (Test-Path -Path "$(Split-Path -Path $PROFILE)\powershellprofile-local.ps1")
{
    . "$(Split-Path -Path $PROFILE)\powershellprofile-local.ps1"
}

Import-Module posh-git
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward


# Git shortcuts
$git1_decorate="%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"
$git2_decorate='%C(bold blue)%h%C(reset) - %C(bold cyan)%a%D%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''         %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
$git3_decorate='%C(bold blue)%h%C(reset) - %C(bold cyan)%a%D%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(comitted: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(comitter: %cn <%ce>)%C(reset)'
Function GitlFunc {git log --graph --abbrev-commit --decorate --format=format:$git1_decorate --all $args}
Function Gitl2Func {git log --graph --abbrev-commit --decorate --format=format:$git2_decorate --all $args}
Function Gitl3Func {git log --graph --abbrev-commit --decorate --format=format:$git3_decorate --all $args}
Function GistFunc {git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit}


Set-Alias -Name "gist" -Value GistFunc
Set-Alias -Name "gitl" -Value GitlFunc
Set-Alias -Name "gitl2" -Value Gitl2Func
Set-Alias -Name "gitl3" -Value Gitl3Func

# .. Shortcuts
Function GoBack1 {Set-Location -Path ..}
Function GoBack2 {Set-Location -Path ../..}
Function GoBack3 {Set-Location -Path ../../..}
Function GoBack4 {Set-Location -Path ../../../..}
Function GoBack5 {Set-Location -Path ../../../../..}
Function GoBack6 {Set-Location -Path ../../../../../..}
Function GoBack7 {Set-Location -Path ../../../../../../..}
Function GoBack8 {Set-Location -Path ../../../../../../../..}
Function GoBack9 {Set-Location -Path ../../../../../../../../..}

Set-Alias -Name ".." -Value GoBack1
Set-Alias -Name "..." -Value GoBack2
Set-Alias -Name "...." -Value GoBack3
Set-Alias -Name "....." -Value GoBack4
Set-Alias -Name "......" -Value GoBack5
Set-Alias -Name "......." -Value GoBack6
Set-Alias -Name "........" -Value GoBack7
Set-Alias -Name "........." -Value GoBack8
Set-Alias -Name ".........." -Value GoBack9
