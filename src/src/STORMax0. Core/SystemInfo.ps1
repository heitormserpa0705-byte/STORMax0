# ============================================================
# STORMax CORE
# SystemInfo
# ============================================================

function Get-STORMaxSystemInfo {

    $OS = Get-CimInstance Win32_OperatingSystem
    $CPU = Get-CimInstance Win32_Processor | Select-Object -First 1
    $Computer = Get-CimInstance Win32_ComputerSystem

    $RAMTotal = [math]::Round(
        $Computer.TotalPhysicalMemory / 1GB,
        2
    )

    $RAMFree = [math]::Round(
        $OS.FreePhysicalMemory / 1MB,
        2
    )

    [PSCustomObject]@{
        ComputerName = $env:COMPUTERNAME
        Manufacturer = $Computer.Manufacturer
        Model = $Computer.Model
        OperatingSystem = $OS.Caption
        WindowsVersion = $OS.Version
        Architecture = $OS.OSArchitecture
        CPU = $CPU.Name
        CPUCores = $CPU.NumberOfCores
        CPUThreads = $CPU.NumberOfLogicalProcessors
        RAMTotalGB = $RAMTotal
        RAMFreeGB = $RAMFree
    }
}
