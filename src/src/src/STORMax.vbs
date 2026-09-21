' ============================================================
' STORMax
' WINDOWS PERFORMANCE CENTER
' Criado por Heitor Magalhães Serpa
' Versão 1.0 VBS
' ============================================================

Option Explicit

' ============================================================
' OBJETOS PRINCIPAIS
' ============================================================

Dim Shell
Dim FSO
Dim WMI
Dim Computer
Dim OS
Dim CPU

Set Shell = CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

Set WMI = GetObject( _
    "winmgmts:\\.\root\cimv2" _
)

' ============================================================
' CONFIGURAÇÕES
' ============================================================

Dim AppTitle
AppTitle = "STORMax — Windows Performance Center"

Dim Version
Version = "1.0"

' ============================================================
' INFORMAÇÕES DO COMPUTADOR
' ============================================================

Set Computer = WMI.Get("Win32_ComputerSystem")
Set OS = WMI.Get("Win32_OperatingSystem")

Dim CPUName
CPUName = "Desconhecido"

For Each CPU In WMI.ExecQuery( _
    "SELECT Name FROM Win32_Processor" _
)

    CPUName = CPU.Name
    Exit For

Next

' ============================================================
' FUNÇÃO: FORMATAR BYTES
' ============================================================

Function FormatGB(Bytes)

    If IsNull(Bytes) Or Bytes = "" Then

        FormatGB = "0 GB"

    Else

        FormatGB = Round(Bytes / 1073741824, 1) & " GB"

    End If

End Function

' ============================================================
' FUNÇÃO: PERCENTUAL DE DISCO
' ============================================================

Function GetDiskFreePercent()

    Dim Disk
    Dim Total
    Dim Free

    GetDiskFreePercent = 0

    For Each Disk In WMI.ExecQuery( _
        "SELECT Size, FreeSpace FROM Win32_LogicalDisk WHERE DeviceID='C:'" _
    )

        Total = CDbl(Disk.Size)
        Free = CDbl(Disk.FreeSpace)

        If Total > 0 Then

            GetDiskFreePercent = Round((Free / Total) * 100, 0)

        End If

        Exit For

    Next

End Function

' ============================================================
' FUNÇÃO: RAM
' ============================================================

Function GetRAMUsage()

    Dim Total
    Dim Free

    Total = CDbl(OS.TotalVisibleMemorySize)
    Free = CDbl(OS.FreePhysicalMemory)

    If Total > 0 Then

        GetRAMUsage = Round( _
            ((Total - Free) / Total) * 100, _
            0 _
        )

    Else

        GetRAMUsage = 0

    End If

End Function

' ============================================================
' FUNÇÃO: CPU
' ============================================================

Function GetCPUUsage()

    Dim Item

    GetCPUUsage = 0

    For Each Item In WMI.ExecQuery( _
        "SELECT LoadPercentage FROM Win32_Processor" _
    )

        If Not IsNull(Item.LoadPercentage) Then

            GetCPUUsage = Item.LoadPercentage

        End If

        Exit For

    Next

End Function

' ============================================================
' FUNÇÃO: STOR SCORE
' ============================================================

Function GetSTORScore()

    Dim Score
    Dim CPUUsage
    Dim RAMUsage
    Dim DiskFree

    Score = 100

    CPUUsage = GetCPUUsage()
    RAMUsage = GetRAMUsage()
    DiskFree = GetDiskFreePercent()

    ' CPU

    If CPUUsage >= 95 Then

        Score = Score - 25

    ElseIf CPUUsage >= 85 Then

        Score = Score - 15

    ElseIf CPUUsage >= 70 Then

        Score = Score - 5

    End If

    ' RAM

    If RAMUsage >= 95 Then

        Score = Score - 25

    ElseIf RAMUsage >= 85 Then

        Score = Score - 15

    ElseIf RAMUsage >= 75 Then

        Score = Score - 5

    End If

    ' DISCO

    If DiskFree < 10 Then

        Score = Score - 30

    ElseIf DiskFree < 20 Then

        Score = Score - 15

    ElseIf DiskFree < 30 Then

        Score = Score - 5

    End If

    If Score < 0 Then

        Score = 0

    End If

    GetSTORScore = Score

End Function

' ============================================================
' FUNÇÃO: STATUS DO SCORE
' ============================================================

Function GetScoreStatus(Score)

    If Score >= 90 Then

        GetScoreStatus = "EXCELENTE"

    ElseIf Score >= 75 Then

        GetScoreStatus = "BOM"

    ElseIf Score >= 50 Then

        GetScoreStatus = "ATENÇÃO"

    Else

        GetScoreStatus = "CRÍTICO"

    End If

End Function

' ============================================================
' DASHBOARD
' ============================================================

Sub Dashboard()

    Dim CPUUsage
    Dim RAMUsage
    Dim DiskFree
    Dim Score
    Dim Message

    CPUUsage = GetCPUUsage()
    RAMUsage = GetRAMUsage()
    DiskFree = GetDiskFreePercent()

    Score = GetSTORScore()

    Message = ""

    Message = Message & _
        "========================================" & vbCrLf

    Message = Message & _
        "              STORMax" & vbCrLf

    Message = Message & _
        "       WINDOWS PERFORMANCE CENTER" & vbCrLf

    Message = Message & _
        "========================================" & vbCrLf & vbCrLf

    Message = Message & _
        "COMPUTADOR" & vbCrLf

    Message = Message & _
        Computer.Name & vbCrLf & vbCrLf

    Message = Message & _
        "PROCESSADOR" & vbCrLf

    Message = Message & _
        CPUName & vbCrLf & vbCrLf

    Message = Message & _
        "CPU: " & CPUUsage & "%" & vbCrLf

    Message = Message & _
        "RAM: " & RAMUsage & "%" & vbCrLf

    Message = Message & _
        "DISCO C: " & DiskFree & "% LIVRE" & vbCrLf & vbCrLf

    Message = Message & _
        "----------------------------------------" & vbCrLf

    Message = Message & _
        "STOR SCORE: " & Score & "/100" & vbCrLf

    Message = Message & _
        "STATUS: " & GetScoreStatus(Score) & vbCrLf

    Message = Message & _
        "----------------------------------------"

    MsgBox Message, _
        vbInformation, _
        AppTitle

End Sub

' ============================================================
' SYSTEM DOCTOR
' ============================================================

Sub SystemDoctor()

    Dim CPUUsage
    Dim RAMUsage
    Dim DiskFree

    Dim Message

    CPUUsage = GetCPUUsage()
    RAMUsage = GetRAMUsage()
    DiskFree = GetDiskFreePercent()

    Message = ""

    Message = Message & _
        "STORMax SYSTEM DOCTOR" & vbCrLf

    Message = Message & _
        "================================" & vbCrLf & vbCrLf

    Message = Message & _
        "CPU: " & CPUUsage & "%"

    If CPUUsage >= 90 Then

        Message = Message & _
            "  [ATENÇÃO]"

    Else

        Message = Message & _
            "  [OK]"

    End If

    Message = Message & vbCrLf & vbCrLf

    Message = Message & _
        "RAM: " & RAMUsage & "%"

    If RAMUsage >= 90 Then

        Message = Message & _
            "  [ATENÇÃO]"

    Else

        Message = Message & _
            "  [OK]"

    End If

    Message = Message & vbCrLf & vbCrLf

    Message = Message & _
        "DISCO C: " & DiskFree & "% livre"

    If DiskFree < 10 Then

        Message = Message & _
            "  [CRÍTICO]"

    ElseIf DiskFree < 20 Then

        Message = Message & _
            "  [ATENÇÃO]"

    Else

        Message = Message & _
            "  [OK]"

    End If

    MsgBox Message, _
        vbInformation, _
        "STORMax System Doctor"

End Sub

' ============================================================
' STORAGE LAB
' ============================================================

Sub StorageLab()

    Dim Disk
    Dim Message

    Message = ""

    Message = Message & _
        "STORMax STORAGE LAB" & vbCrLf

    Message = Message & _
        "================================" & vbCrLf & vbCrLf

    For Each Disk In WMI.ExecQuery( _
        "SELECT DeviceID,Size,FreeSpace,VolumeName " & _
        "FROM Win32_LogicalDisk WHERE DriveType=3" _
    )

        Message = Message & _
            Disk.DeviceID & vbCrLf

        Message = Message & _
            "Nome: " & Disk.VolumeName & vbCrLf

        Message = Message & _
            "Total: " & FormatGB(Disk.Size) & vbCrLf

        Message = Message & _
            "Livre: " & FormatGB(Disk.FreeSpace) & vbCrLf & vbCrLf

    Next

    MsgBox Message, _
        vbInformation, _
        "STORMax Storage Lab"

End Sub

' ============================================================
' PROCESS MANAGER
' ============================================================

Sub ProcessManager()

    Dim Processes
    Dim Process
    Dim Count
    Dim Message

    Set Processes =
        WMI.ExecQuery( _
            "SELECT Name,ProcessId,WorkingSetSize " & _
            "FROM Win32_Process" _
        )

    Message = ""

    Message = Message & _
        "STORMax PROCESS MANAGER" & vbCrLf

    Message = Message & _
        "================================" & vbCrLf & vbCrLf

    Count = 0

    For Each Process In Processes

        Message = Message & _
            Process.Name & _
            " | PID " & _
            Process.ProcessId & _
            " | RAM " & _
            FormatGB(Process.WorkingSetSize) & vbCrLf

        Count = Count + 1

        If Count >= 20 Then

            Exit For

        End If

    Next

    MsgBox Message, _
        vbInformation, _
        "STORMax Process Manager"

End Sub

' ============================================================
' GAMING CENTER
' ============================================================

Sub GamingCenter()

    Dim Message

    Message = ""

    Message = Message & _
        "STORMax GAMING CENTER" & vbCrLf

    Message = Message & _
        "================================" & vbCrLf & vbCrLf

    Message = Message & _
        "Módulo preparado." & vbCrLf & vbCrLf

    Message = Message & _
        "Nesta versão o STORMax NÃO encerra" & vbCrLf

    Message = Message & _
        "processos nem altera configurações" & vbCrLf

    Message = Message & _
        "do Windows automaticamente."

    MsgBox Message, _
        vbInformation, _
        "STORMax Gaming Center"

End Sub

' ============================================================
' MENU PRINCIPAL
' ============================================================

Sub MainMenu()

    Dim Choice

    Do

        Choice = InputBox( _
            "STORMax — Windows Performance Center" & _
            vbCrLf & vbCrLf & _
            "1 - Dashboard" & vbCrLf & _
            "2 - System Doctor" & vbCrLf & _
            "3 - Storage Lab" & vbCrLf & _
            "4 - Process Manager" & vbCrLf & _
            "5 - Gaming Center" & vbCrLf & _
            "6 - Sair" & vbCrLf & vbCrLf & _
            "Digite uma opção:", _
            AppTitle _
        )

        If Choice = "" Then

            Exit Do

        End If

        Select Case Choice

            Case "1"

                Dashboard

            Case "2"

                SystemDoctor

            Case "3"

                StorageLab

            Case "4"

                ProcessManager

            Case "5"

                GamingCenter

            Case "6"

                Exit Do

            Case Else

                MsgBox _
                    "Opção inválida.", _
                    vbExclamation, _
                    AppTitle

        End Select

    Loop

End Sub

' ============================================================
' INICIALIZAÇÃO
' ============================================================

MainMenu

' ============================================================
' FINALIZAÇÃO
' ============================================================

Set CPU = Nothing
Set OS = Nothing
Set Computer = Nothing
Set WMI = Nothing
Set FSO = Nothing
Set Shell = Nothing
