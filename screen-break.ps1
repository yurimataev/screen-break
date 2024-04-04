while (1) {
    # Get the time
    $hh = $(Get-Date -Format "HH")
    $mm = $(Get-Date -Format "mm")
    Write-Output "Current time $hh : $mm\n"

    # C:\Users\Public\Documents\screen-break-warning.ps1 takes care of popping up notifications for Jacob

    # screen break
    if ($hh % 2 -eq 1 -and $hh -lt 19 -and $hh -gt 21 -and $mm -le 14) {
        # Disable GPU
        # pnputil /disable-device "PCI\VEN_10DE&DEV_1B81&SUBSYS_37011458&REV_A1\6&1CCBDACB&0&0020020B"
        # Disable Monitors
        # pnputil /disable-device "DISPLAY\SAM01AE\7&36651387&0&UID24833"
        # pnputil /disable-device "DISPLAY\SAM01AE\7&36651387&0&UID24837"

        # Logoff user
        Write-Output "Logging off Jacob\n"
        do {
            $USER_SESSION = $(query user | Where-Object{$_ -match 'jacob'} | ForEach-Object{($_ -split "\s+")[2]})
            Write-Output "User session is $USER_SESSION\n"
            if ($USER_SESSION -gt 0) {
                Write-Output "Performing Log Off\n"
                logoff $USER_SESSION
            }
            Write-Output "Waiting 10\n"
            Start-Sleep 10
            $mm = $(Get-Date -Format "mm")
            Write-Output "New time: $mm\n"
        } while ($mm -le 14)

    }
    # re-enable GPU
    #} else {
        # Re-enable GPU and monitors
        #pnputil /enable-device "PCI\VEN_10DE&DEV_1B81&SUBSYS_37011458&REV_A1\6&1CCBDACB&0&0020020B"
        #pnputil /enable-device "DISPLAY\SAM01AE\7&36651387&0&UID24833"
        #pnputil /enable-device "DISPLAY\SAM01AE\7&36651387&0&UID24837"
    #}

    Write-Output "Waiting 10 (end of cycle)\n"
    Start-Sleep 10
}