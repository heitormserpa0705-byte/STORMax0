# ============================================================
# STORMax STORAGE MODULE
# ============================================================

function Get-STORMaxStorage {

    $Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

    foreach ($Drive in $Drives) {

        if ($Drive.Size -le 0) {
            continue
        }

        $Total = [math]::Round(
            $Drive.Size / 1GB,
            2
        )

        $Free = [math]::Round(
            $Drive.FreeSpace / 1GB,
            2
        )

        $Used = $Total - $Free

        $FreePercent = [math]::Round(
            ($Free / $Total) * 100,
            1
        )

        [PSCustomObject]@{
            Drive       = $Drive.DeviceID
            TotalGB     = $Total
            UsedGB      = [math]::Round($Used,2)
            FreeGB      = $Free
            FreePercent = $FreePercent
        }
    }
}
