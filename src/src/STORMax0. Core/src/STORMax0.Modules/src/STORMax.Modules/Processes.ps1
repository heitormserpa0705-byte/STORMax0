# ============================================================
# STORMax PROCESS MANAGER
# ============================================================

function Get-STORMaxTopProcesses {

    Get-Process |
        Where-Object {
            $_.CPU -ne $null
        } |
        Sort-Object CPU -Descending |
        Select-Object -First 20 `
            Name,
            Id,
            CPU
}
