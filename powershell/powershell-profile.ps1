function prompt {
    $RED = "#bd3c47"

    $name = "$(Text -ForegroundColor $RED $env:username)"
    $separator = "$(Text -ForegroundColor Cyan ":")"
    $computer = "$(Text -ForegroundColor $RED $env:computername) "
    $location = "$(Get-Location)"
    $end = "$(Text -fg Cyan "> ")"
    $vssstatus = "$(Write-GitStatus (Get-GitStatus)) "
    if ($vssstatus -eq " ") {
        $vssstatus = ""
    }
    return $name+$separator+$computer+$location+$end+$vssstatus
}

Import-Module posh-git
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward


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
