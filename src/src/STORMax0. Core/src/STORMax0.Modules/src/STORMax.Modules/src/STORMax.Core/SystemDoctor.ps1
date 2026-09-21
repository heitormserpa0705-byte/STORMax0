# ============================================================
# STORMax SYSTEM DOCTOR
# ============================================================

function Invoke-STORMaxSystemDoctor {

    $Results = @()

    # -----------------------------------------
    # ARMAZENAMENTO
    # -----------------------------------------

    $Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

    foreach ($Drive in $Drives) {

        if ($Drive.Size -le 0) {
            continue
        }

        $FreePercent =
            ($Drive.FreeSpace / $Drive.Size) * 100

        if ($FreePercent -lt 10) {

            $Results += [PSCustomObject]@{
                Category = "Storage"
                Level = "Critical"
                Message = "$($Drive.DeviceID) possui menos de 10% de espaço livre."
            }

        }
        elseif ($FreePercent -lt 20) {

            $Results += [PSCustomObject]@{
                Category = "Storage"
                Level = "Warning"
                Message = "$($Drive.DeviceID) possui pouco espaço livre."
            }

        }
        else {

            $Results += [PSCustomObject]@{
                Category = "Storage"
                Level = "OK"
                Message = "$($Drive.DeviceID) possui espaço disponível adequado."
            }
        }
    }

    # -----------------------------------------
    # MEMÓRIA
    # -----------------------------------------

    $OS = Get-CimInstance Win32_OperatingSystem

    $RAMUsage =
        (($OS.TotalVisibleMemorySize -
        $OS.FreePhysicalMemory) /
        $OS.TotalVisibleMemorySize) * 100

    if ($RAMUsage -gt 90) {

        $Results += [PSCustomObject]@{
            Category = "Memory"
            Level = "Warning"
            Message = "Utilização de memória acima de 90%."
        }

    }
    else {

        $Results += [PSCustomObject]@{
            Category = "Memory"
            Level = "OK"
            Message = "Utilização de memória dentro do limite analisado."
        }
    }

    return $Results
}
