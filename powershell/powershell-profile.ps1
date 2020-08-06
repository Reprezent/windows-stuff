function prompt {
    $RED = "#bd3c47"

    $name = "$(Text -ForegroundColor $RED $env:username)"
    $separator = "$(Text -ForegroundColor Cyan ":")"
    $computer = "$(Text -ForegroundColor $RED $env:computername) "
    $location = "$(Get-Location)"
    $end = "$(Text -fg Cyan "> ")"
    return $name+$separator+$computer+$location+$end
}
