# ============================================================
# STORMax
# WINDOWS PERFORMANCE CENTER
# Criado por Heitor Magalhães Serpa
# Versão 0.4
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

# ============================================================
# CARREGAR MÓDULOS
# ============================================================

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$Root\STORMax.Core\SystemInfo.ps1"
. "$Root\STORMax.Core\SystemDoctor.ps1"
. "$Root\STORMax.Modules\Storage.ps1"
. "$Root\STORMax.Modules\Processes.ps1"

# ============================================================
# CORES
# ============================================================

$Background = [System.Drawing.Color]::FromArgb(12,13,18)
$Sidebar    = [System.Drawing.Color]::FromArgb(18,20,27)
$Card       = [System.Drawing.Color]::FromArgb(24,26,34)

$White = [System.Drawing.Color]::White
$Gray  = [System.Drawing.Color]::FromArgb(145,150,160)

$Blue   = [System.Drawing.Color]::DeepSkyBlue
$Green  = [System.Drawing.Color]::LightGreen
$Orange = [System.Drawing.Color]::Orange
$Red    = [System.Drawing.Color]::OrangeRed

# ============================================================
# JANELA PRINCIPAL
# ============================================================

$Form = New-Object System.Windows.Forms.Form

$Form.Text = "STORMax — Windows Performance Center"

$Form.Size =
    New-Object System.Drawing.Size(1200,760)

$Form.MinimumSize =
    New-Object System.Drawing.Size(1000,650)

$Form.StartPosition = "CenterScreen"

$Form.BackColor = $Background

# ============================================================
# FUNÇÃO: LABEL
# ============================================================

function New-STORLabel {

    param(
        [string]$Text,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Size = 10,
        [System.Drawing.Color]$Color = $White
    )

    $Label =
        New-Object System.Windows.Forms.Label

    $Label.Text = $Text

    $Label.Location =
        New-Object System.Drawing.Point($X,$Y)

    $Label.Size =
        New-Object System.Drawing.Size(
            $Width,
            $Height
        )

    $Label.ForeColor = $Color

    $Label.Font =
        New-Object System.Drawing.Font(
            "Segoe UI",
            $Size
        )

    $Form.Controls.Add($Label)

    return $Label
}

# ============================================================
# MENU LATERAL
# ============================================================

$Menu =
    New-Object System.Windows.Forms.Panel

$Menu.Location =
    New-Object System.Drawing.Point(0,0)

$Menu.Size =
    New-Object System.Drawing.Size(220,760)

$Menu.BackColor = $Sidebar

$Form.Controls.Add($Menu)

# ============================================================
# LOGO
# ============================================================

$Logo =
    New-Object System.Windows.Forms.Label

$Logo.Text = "STORMax"

$Logo.Location =
    New-Object System.Drawing.Point(25,25)

$Logo.Size =
    New-Object System.Drawing.Size(180,45)

$Logo.ForeColor = $Blue

$Logo.Font =
    New-Object System.Drawing.Font(
        "Segoe UI",
        25,
        [System.Drawing.FontStyle]::Bold
    )

$Menu.Controls.Add($Logo)

# ============================================================
# SUBTÍTULO
# ============================================================

$MenuSub =
    New-Object System.Windows.Forms.Label

$MenuSub.Text =
    "WINDOWS PERFORMANCE"

$MenuSub.Location =
    New-Object System.Drawing.Point(27,68)

$MenuSub.Size =
    New-Object System.Drawing.Size(180,25)

$MenuSub.ForeColor = $Gray

$MenuSub.Font =
    New-Object System.Drawing.Font(
        "Segoe UI",
        8
    )

$Menu.Controls.Add($MenuSub)

# ============================================================
# FUNÇÃO: BOTÃO DO MENU
# ============================================================

function New-MenuButton {

    param(
        [string]$Text,
        [int]$Y
    )

    $Button =
        New-Object System.Windows.Forms.Button

    $Button.Text = $Text

    $Button.Location =
        New-Object System.Drawing.Point(15,$Y)

    $Button.Size =
        New-Object System.Drawing.Size(190,48)

    $Button.BackColor = $Sidebar

    $Button.ForeColor = $White

    $Button.FlatStyle = "Flat"

    $Button.FlatAppearance.BorderSize = 0

    $Button.Font =
        New-Object System.Drawing.Font(
            "Segoe UI",
            10
        )

    $Button.TextAlign =
        [System.Drawing.ContentAlignment]::MiddleLeft

    $Menu.Controls.Add($Button)

    return $Button
}

# ============================================================
# MENU
# ============================================================

$DashboardButton =
    New-MenuButton "  Dashboard" 120

$DoctorButton =
    New-MenuButton "  System Doctor" 175

$StorageButton =
    New-MenuButton "  Storage Lab" 230

$ProcessesButton =
    New-MenuButton "  Process Manager" 285

$GamingButton =
    New-MenuButton "  Gaming Center" 340

$SettingsButton =
    New-MenuButton "  Configurações" 395

# ============================================================
# VERSÃO
# ============================================================

$Version =
    New-Object System.Windows.Forms.Label

$Version.Text =
    "STORMax v0.4`r`nHeitor Magalhães Serpa"

$Version.Location =
    New-Object System.Drawing.Point(25,680)

$Version.Size =
    New-Object System.Drawing.Size(180,50)

$Version.ForeColor = $Gray

$Version.Font =
    New-Object System.Drawing.Font(
        "Segoe UI",
        8
    )

$Menu.Controls.Add($Version)

# ============================================================
# ÁREA PRINCIPAL
# ============================================================

$Main =
    New-Object System.Windows.Forms.Panel

$Main.Location =
    New-Object System.Drawing.Point(220,0)

$Main.Size =
    New-Object System.Drawing.Size(980,760)

$Main.BackColor = $Background

$Form.Controls.Add($Main)

# ============================================================
# TÍTULO
# ============================================================

$DashboardTitle =
    New-Object System.Windows.Forms.Label

$DashboardTitle.Text = "Dashboard"

$DashboardTitle.Location =
    New-Object System.Drawing.Point(35,25)

$DashboardTitle.Size =
    New-Object System.Drawing.Size(500,45)

$DashboardTitle.ForeColor = $White

$DashboardTitle.Font =
    New-Object System.Drawing.Font(
        "Segoe UI",
        24,
        [System.Drawing.FontStyle]::Bold
    )

$Main.Controls.Add($DashboardTitle)

# ============================================================
# SUBTÍTULO
# ============================================================

$DashboardSub =
    New-Object System.Windows.Forms.Label

$DashboardSub.Text =
    "Visão geral do estado do computador"

$DashboardSub.Location =
    New-Object System.Drawing.Point(38,68)

$DashboardSub.Size =
    New-Object System.Drawing.Size(500,30)

$DashboardSub.ForeColor = $Gray

$DashboardSub.Font =
    New-Object System.Drawing.Font(
        "Segoe UI",
        10
    )

$Main.Controls.Add($DashboardSub)

# ============================================================
# FUNÇÃO: CARD
# ============================================================

function New-STORCard {

    param(
        [string]$Title,
        [string]$Value,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height
    )

    $Panel =
        New-Object System.Windows.Forms.Panel

    $Panel.Location =
        New-Object System.Drawing.Point($X,$Y)

    $Panel.Size =
        New-Object System.Drawing.Size(
            $Width,
            $Height
        )

    $Panel.BackColor = $Card

    $Main.Controls.Add($Panel)

    $TitleLabel =
        New-Object System.Windows.Forms.Label

    $TitleLabel.Text = $Title

    $TitleLabel.Location =
        New-Object System.Drawing.Point(18,15)

    $TitleLabel.Size =
        New-Object System.Drawing.Size(
            ($Width - 35),
            25
        )

    $TitleLabel.ForeColor = $Gray

    $TitleLabel.Font =
        New-Object System.Drawing.Font(
            "Segoe UI",
            9
        )

    $Panel.Controls.Add($TitleLabel)

    $ValueLabel =
        New-Object System.Windows.Forms.Label

    $ValueLabel.Text = $Value

    $ValueLabel.Location =
        New-Object System.Drawing.Point(18,48)

    $ValueLabel.Size =
        New-Object System.Drawing.Size(
            ($Width - 35),
            55
        )

    $ValueLabel.ForeColor = $White

    $ValueLabel.Font =
        New-Object System.Drawing.Font(
            "Segoe UI",
            20,
            [System.Drawing.FontStyle]::Bold
        )

    $Panel.Controls.Add($ValueLabel)

    return @{
        Panel = $Panel
        Value = $ValueLabel
    }
}

# ============================================================
# INFORMAÇÕES DO SISTEMA
# ============================================================

$SystemInfo =
    Get-STORMaxSystemInfo

# ============================================================
# CARDS PRINCIPAIS
# ============================================================

$CPUCard =
    New-STORCard `
        "PROCESSADOR" `
        "0%" `
        35 `
        115 `
        215 `
        125

$RAMCard =
    New-STORCard `
        "MEMÓRIA RAM" `
        "0%" `
        265 `
        115 `
        215 `
        125

$StorageCard =
    New-STORCard `
        "ARMAZENAMENTO" `
        "0%" `
        495 `
        115 `
        215 `
        125

$ScoreCard =
    New-STORCard `
        "STOR SCORE" `
        "—" `
        725 `
        115 `
        185 `
        125

$ScoreCard.Value.ForeColor = $Blue

# ============================================================
# CARDS SECUNDÁRIOS
# ============================================================

$ComputerCard =
    New-STORCard `
        "COMPUTADOR" `
        $SystemInfo.ComputerName `
        35 `
        260 `
        330 `
        100

$WindowsCard =
    New-STORCard `
        "WINDOWS" `
        $SystemInfo.OperatingSystem `
        385 `
        260 `
        330 `
        100

$StatusCard =
    New-STORCard `
        "STATUS" `
        "Pronto" `
        735 `
        260 `
        175 `
        100

$StatusCard.Value.ForeColor = $Green

# ============================================================
# LOG
# ============================================================

$LogTitle =
    New-Object System.Windows.Forms.Label

$LogTitle.Text = "SYSTEM LOG"

$LogTitle.Location =
    New-Object System.Drawing.Point(35,390)

$LogTitle.Size =
    New-Object System.Drawing.Size(300,30)

$LogTitle.ForeColor = $Gray

$LogTitle.Font =
    New-Object System.Drawing.Font(
        "Segoe UI",
        11
    )

$Main.Controls.Add($LogTitle)

$Log =
    New-Object System.Windows.Forms.TextBox

$Log.Location =
    New-Object System.Drawing.Point(35,425)

$Log.Size =
    New-Object System.Drawing.Size(875,190)

$Log.Multiline = $true

$Log.ReadOnly = $true

$Log.ScrollBars = "Vertical"

$Log.BackColor =
    [System.Drawing.Color]::FromArgb(8,9,13)

$Log.ForeColor = $Green

$Log.Font =
    New-Object System.Drawing.Font(
        "Consolas",
        9
    )

$Main.Controls.Add($Log)

# ============================================================
# FUNÇÃO: LOG
# ============================================================

function Write-STORLog {

    param(
        [string]$Message
    )

    $Time =
        Get-Date -Format "HH:mm:ss"

    $Log.AppendText(
        "[$Time] $Message`r`n"
    )
}

# ============================================================
# ATUALIZAR ARMAZENAMENTO
# ============================================================

function Update-STORStorage {

    try {

        $Drives =
            @(Get-STORMaxStorage)

        $TotalSize = 0
        $TotalFree = 0

        foreach ($Drive in $Drives) {

            $TotalSize += $Drive.TotalGB
            $TotalFree += $Drive.FreeGB
        }

        if ($TotalSize -gt 0) {

            $Percent =
                [math]::Round(
                    ($TotalFree / $TotalSize) * 100,
                    0
                )

            $StorageCard.Value.Text =
                "$Percent% livre"

            if ($Percent -lt 10) {

                $StorageCard.Value.ForeColor = $Red
            }
            elseif ($Percent -lt 20) {

                $StorageCard.Value.ForeColor = $Orange
            }
            else {

                $StorageCard.Value.ForeColor = $Green
            }
        }
    }
    catch {

        Write-STORLog "Erro ao atualizar armazenamento."
    }
}

# ============================================================
# DIAGNÓSTICO
# ============================================================

function Invoke-STORDiagnostic {

    $Log.Clear()

    Write-STORLog "STORMax Diagnostic Engine"
    Write-STORLog "--------------------------------"
    Write-STORLog "Iniciando diagnóstico..."

    try {

        $Results =
            @(Invoke-STORMaxSystemDoctor)

        foreach ($Result in $Results) {

            Write-STORLog `
                "[$($Result.Level)] $($Result.Category): $($Result.Message)"
        }

        $Critical =
            @(
                $Results |
                Where-Object {
                    $_.Level -eq "Critical"
                }
            ).Count

        $Warning =
            @(
                $Results |
                Where-Object {
                    $_.Level -eq "Warning"
                }
            ).Count

        if ($Critical -gt 0) {

            $ScoreCard.Value.Text =
                "ATENÇÃO"

            $ScoreCard.Value.ForeColor = $Red
        }
        elseif ($Warning -gt 0) {

            $ScoreCard.Value.Text =
                "BOM"

            $ScoreCard.Value.ForeColor = $Orange
        }
        else {

            $ScoreCard.Value.Text =
                "OK"

            $ScoreCard.Value.ForeColor = $Green
        }

        $StatusCard.Value.Text =
            "Analisado"

        Write-STORLog "--------------------------------"
        Write-STORLog "Diagnóstico concluído."

        Update-STORStorage
    }
    catch {

        Write-STORLog `
            "Erro no diagnóstico: $($_.Exception.Message)"

        $StatusCard.Value.Text =
            "Erro"

        $StatusCard.Value.ForeColor = $Red
    }
}

# ============================================================
# SYSTEM DOCTOR
# ============================================================

$DoctorButton.Add_Click({

    Invoke-STORDiagnostic
})

# ============================================================
# STORAGE LAB
# ============================================================

$StorageButton.Add_Click({

    $Log.Clear()

    Write-STORLog "STORAGE LAB"
    Write-STORLog "--------------------------------"

    try {

        $Drives =
            @(Get-STORMaxStorage)

        foreach ($Drive in $Drives) {

            Write-STORLog `
                "$($Drive.Drive) | Total: $($Drive.TotalGB) GB | Usado: $($Drive.UsedGB) GB | Livre: $($Drive.FreeGB) GB | $($Drive.FreePercent)% livre"
        }

        Update-STORStorage
    }
    catch {

        Write-STORLog "Erro ao consultar armazenamento."
    }
})

# ============================================================
# PROCESS MANAGER
# ============================================================

$ProcessesButton.Add_Click({

    $Log.Clear()

    Write-STORLog "PROCESS MANAGER"
    Write-STORLog "--------------------------------"

    try {

        $Processes =
            @(Get-STORMaxTopProcesses)

        foreach ($Process in $Processes) {

            $CPUValue = 0

            if ($null -ne $Process.CPU) {

                $CPUValue =
                    [math]::Round(
                        $Process.CPU,
                        2
                    )
            }

            Write-STORLog `
                "$($Process.Name) | PID $($Process.Id) | CPU $CPUValue"
        }
    }
    catch {

        Write-STORLog "Erro ao consultar processos."
    }
})

# ============================================================
# GAMING CENTER
# ============================================================

$GamingButton.Add_Click({

    $Log.Clear()

    Write-STORLog "GAMING CENTER"
    Write-STORLog "--------------------------------"
    Write-STORLog "Módulo Gaming Center preparado."
    Write-STORLog "Nenhuma alteração de sistema foi realizada."
    Write-STORLog "Sistema seguro."
})

# ============================================================
# CONFIGURAÇÕES
# ============================================================

$SettingsButton.Add_Click({

    $Log.Clear()

    Write-STORLog "CONFIGURAÇÕES"
    Write-STORLog "--------------------------------"
    Write-STORLog "Central de configurações."
    Write-STORLog "Módulo em desenvolvimento."
})

# ============================================================
# DASHBOARD
# ============================================================

$DashboardButton.Add_Click({

    $Log.Clear()

    Write-STORLog "Dashboard"
    Write-STORLog "--------------------------------"
    Write-STORLog "Visão geral do sistema."
    Write-STORLog "Monitoramento ativo."
})

# ============================================================
# MONITOR EM TEMPO REAL
# ============================================================

$MonitorTimer =
    New-Object System.Windows.Forms.Timer

$MonitorTimer.Interval = 2000

$MonitorTimer.Add_Tick({

    try {

        # ----------------------------------------------------
        # CPU
        # ----------------------------------------------------

        $CPU =
            Get-CimInstance Win32_Processor |
            Measure-Object `
                -Property LoadPercentage `
                -Average

        $CPUUsage =
            [math]::Round(
                $CPU.Average,
                0
            )

        $CPUCard.Value.Text =
            "$CPUUsage%"

        if ($CPUUsage -ge 90) {

            $CPUCard.Value.ForeColor = $Red
        }
        elseif ($CPUUsage -ge 70) {

            $CPUCard.Value.ForeColor = $Orange
        }
        else {

            $CPUCard.Value.ForeColor = $Green
        }

        # ----------------------------------------------------
        # RAM
        # ----------------------------------------------------

        $OS =
            Get-CimInstance Win32_OperatingSystem

        $TotalMemory =
            [double]$OS.TotalVisibleMemorySize

        $FreeMemory =
            [double]$OS.FreePhysicalMemory

        if ($TotalMemory -gt 0) {

            $RAMUsage =
                (
                    (
                        $TotalMemory -
                        $FreeMemory
                    ) /
                    $TotalMemory
                ) * 100

            $RAMUsage =
                [math]::Round(
                    $RAMUsage,
                    0
                )

            $RAMCard.Value.Text =
                "$RAMUsage%"

            if ($RAMUsage -ge 90) {

                $RAMCard.Value.ForeColor = $Red
            }
            elseif ($RAMUsage -ge 75) {

                $RAMCard.Value.ForeColor = $Orange
            }
            else {

                $RAMCard.Value.ForeColor = $Green
            }
        }

        # ----------------------------------------------------
        # STORAGE
        # ----------------------------------------------------

        Update-STORStorage
    }
    catch {

        Write-STORLog `
            "Erro no monitor: $($_.Exception.Message)"
    }
})

$MonitorTimer.Start()

# ============================================================
# INICIALIZAÇÃO
# ============================================================

Update-STORStorage

Write-STORLog "STORMax iniciado."
Write-STORLog "Windows Performance Center."
Write-STORLog "SystemInfo carregado."
Write-STORLog "SystemDoctor carregado."
Write-STORLog "Storage carregado."
Write-STORLog "Process Manager carregado."
Write-STORLog "Monitor em tempo real ativo."
Write-STORLog "Sistema pronto."

# ============================================================
# EXECUTAR
# ============================================================

[void]$Form.ShowDialog()
