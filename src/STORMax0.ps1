============================================================

STORMax

Windows Performance Center

Criado por Heitor Magalhães Serpa

Versão 0.1.0

============================================================

$ErrorActionPreference = "SilentlyContinue"

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
    CPU = $CPU.Name
    RAMTotalGB = $RAMTotal
    RAMFreeGB = $RAMFree
    Architecture = $OS.OSArchitecture
}

}

function Get-STORMaxStorage {

$Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

foreach ($Drive in $Drives) {

    $Total = [math]::Round(
        $Drive.Size / 1GB,
        2
    )

    $Free = [math]::Round(
        $Drive.FreeSpace / 1GB,
        2
    )

    [PSCustomObject]@{
        Drive = $Drive.DeviceID
        TotalGB = $Total
        FreeGB = $Free
        UsedGB = [math]::Round($Total - $Free, 2)
    }
}

}

function Get-STORMaxProcesses {

Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 15 Name, Id, CPU

}

function Get-STORMaxStatus {

$System = Get-STORMaxSystemInfo
$Storage = Get-STORMaxStorage

Write-Host ""
Write-Host "========================================="
Write-Host " STORMax"
Write-Host " WINDOWS PERFORMANCE CENTER"
Write-Host "========================================="
Write-Host ""

Write-Host "CRIADOR: Heitor Magalhães Serpa"
Write-Host "VERSAO: 0.1.0"
Write-Host ""

Write-Host "COMPUTADOR"
Write-Host "-----------------------------------------"
Write-Host "Nome: $($System.ComputerName)"
Write-Host "Fabricante: $($System.Manufacturer)"
Write-Host "Modelo: $($System.Model)"
Write-Host ""

Write-Host "SISTEMA"
Write-Host "-----------------------------------------"
Write-Host "$($System.OperatingSystem)"
Write-Host "Versao: $($System.WindowsVersion)"
Write-Host "Arquitetura: $($System.Architecture)"
Write-Host ""

Write-Host "PROCESSADOR"
Write-Host "-----------------------------------------"
Write-Host $System.CPU
Write-Host ""

Write-Host "MEMORIA"
Write-Host "-----------------------------------------"
Write-Host "Total: $($System.RAMTotalGB) GB"
Write-Host "Livre: $($System.RAMFreeGB) GB"
Write-Host ""

Write-Host "ARMAZENAMENTO"
Write-Host "-----------------------------------------"

foreach ($Drive in $Storage) {

    Write-Host "$($Drive.Drive)"
    Write-Host "Total: $($Drive.TotalGB) GB"
    Write-Host "Livre: $($Drive.FreeGB) GB"
    Write-Host "Usado: $($Drive.UsedGB) GB"
    Write-Host ""
}

Write-Host "========================================="
Write-Host "STORMax pronto."
Write-Host "========================================="

}

Get-STORMaxStatus
