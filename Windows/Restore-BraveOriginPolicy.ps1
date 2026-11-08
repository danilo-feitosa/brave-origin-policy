#Requires -RunAsAdministrator
param([string]$ReceiptPath)

$ErrorActionPreference = "Stop"
$BackupDir = "$env:ProgramData\BraveOriginPolicy"

if (-not $ReceiptPath) {
    $Latest = Get-ChildItem $BackupDir -Filter "backup-*.json" |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if (-not $Latest) {
        throw "Backup não encontrado."
    }

    $ReceiptPath = $Latest.FullName
}

$Backup = Get-Content $ReceiptPath -Raw | ConvertFrom-Json
$Key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey(
    $Backup.RegistryPath, $true
)

if (-not $Key) {
    Write-Host "Chave de políticas não encontrada."
    exit 0
}

foreach ($Entry in $Backup.Values) {
    if ($Entry.Exists) {
        $Kind = [Microsoft.Win32.RegistryValueKind]$Entry.Kind
        $Value = $Entry.Value

        if ($Kind -eq [Microsoft.Win32.RegistryValueKind]::DWord) {
            $Value = [int]$Value
        }

        $Key.SetValue($Entry.Name, $Value, $Kind)
    }
    else {
        $Key.DeleteValue($Entry.Name, $false)
    }
}

$Key.Close()

Write-Host "Configurações anteriores restauradas!" -ForegroundColor Green
Write-Host "Reinicie o Brave."
