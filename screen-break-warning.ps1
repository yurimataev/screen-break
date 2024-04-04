Add-Type -AssemblyName PresentationFramework

while (1) {
    # Get the time
    $hh = $(Get-Date -Format "HH")
    $mm = $(Get-Date -Format "mm")
    Write-Output "Current time $hh : $mm\n"

    # warn about impending doom
    if ($showedNotification -ne 1) {
        if ($hh % 2 -eq 0 -and ($mm -eq 45 -or $mm -eq 58)) {
            $minutesLeft = 60 - $mm

            New-BurntToastNotification `
            -Text "Screen Break Warning",
                "Screen breaking coming up in $minutesLeft minutes!"

            $MessageBody = "Screen breaking coming up in $minutesLeft minutes!"
            $MessageTitle = "Screen Break Warning"
            [System.Windows.MessageBox]::Show($THIS, $MessageBody, $MessageTitle, "OK", "None", "None", "DefaultDesktopOnly")
            
            $showedNotification = 1
        }
    }
    if ($hh % 2 -eq 0 -and $mm -ne 45 -and $mm -ne 59) {
        $showedNotification = 0
    }

    Write-Output "Waiting 10 (end of cycle)\n"
    Start-Sleep 10
}