function prompt {
    $RED = "#bd3c47"

    $name = "$(Text -ForegroundColor $RED $env:username)"
    $separator = "$(Text -ForegroundColor Cyan ":")"
    $computer = "$(Text -ForegroundColor $RED $env:computername) "
    $location = "$(Get-Location)"
    $end = "$(Text -fg Cyan "> ")"
    $vssstatus = "$(Write-GitStatus (Get-GitStatus)) "
    return $name+$separator+$computer+$location+$end+$vssstatus
}

Import-Module posh-git
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward
