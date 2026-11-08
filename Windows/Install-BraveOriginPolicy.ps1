#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

$Path = "SOFTWARE\Policies\BraveSoftware\Brave"
$BackupDir = "$env:ProgramData\BraveOriginPolicy"

New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null

$Policies = @(
    "TorDisabled",
    "BraveRewardsDisabled",
    "BraveWalletDisabled",
    "BraveVPNDisabled",
    "BraveAIChatEnabled",
    "BraveNewsDisabled",
    "BraveTalkDisabled",
    "BraveP3AEnabled",
    "BraveStatsPingEnabled",
    "BraveWebDiscoveryEnabled",
    "BravePlaylistEnabled",
    "BraveSpeedreaderEnabled",
    "BraveWaybackMachineEnabled",
    "BraveLocalAIEnabled",
    "EmailAliasesEnabled",
    "PsstEnabled",
    "SyncDisabled",
    "MetricsReportingEnabled",
    "UrlKeyedAnonymizedDataCollectionEnabled",
    "SafeBrowsingExtendedReportingEnabled",
    "SafeBrowsingSurveysEnabled",
    "BraveGlobalPrivacyControlEnabled",
    "BraveTrackingQueryParametersFilteringEnabled"
)

$Values = @{
    TorDisabled = 1
    BraveRewardsDisabled = 1
    BraveWalletDisabled = 1
    BraveVPNDisabled = 1
    BraveAIChatEnabled = 0
    BraveNewsDisabled = 1
    BraveTalkDisabled = 1
    BraveP3AEnabled = 0
    BraveStatsPingEnabled = 0
    BraveWebDiscoveryEnabled = 0
    BravePlaylistEnabled = 0
    BraveSpeedreaderEnabled = 0
    BraveWaybackMachineEnabled = 0
    BraveLocalAIEnabled = 0
    EmailAliasesEnabled = 0
    PsstEnabled = 0
    SyncDisabled = 1
    MetricsReportingEnabled = 0
    UrlKeyedAnonymizedDataCollectionEnabled = 0
    SafeBrowsingExtendedReportingEnabled = 0
    SafeBrowsingSurveysEnabled = 0
    BraveGlobalPrivacyControlEnabled = 1
    BraveTrackingQueryParametersFilteringEnabled = 1
}

$Key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($Path, $true)

if (-not $Key) {
    $Key = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($Path)
}

$Backup = foreach ($Name in $Policies) {
    if ($Key.GetValueNames() -contains $Name) {
        [PSCustomObject]@{
            Name = $Name
            Exists = $true
            Kind = $Key.GetValueKind($Name).ToString()
            Value = $Key.GetValue($Name)
        }
    }
    else {
        [PSCustomObject]@{
            Name = $Name
            Exists = $false
            Kind = $null
            Value = $null
        }
    }
}

$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$Receipt = Join-Path $BackupDir "backup-$Stamp.json"

@{
    RegistryPath = $Path
    Values = @($Backup)
} | ConvertTo-Json -Depth 8 |
    Set-Content -Path $Receipt -Encoding UTF8

foreach ($Name in $Policies) {
    $Key.SetValue(
        $Name,
        [int]$Values[$Name],
        [Microsoft.Win32.RegistryValueKind]::DWord
    )
}

$Key.Close()

Write-Host "Brave Origin Policy instalado!" -ForegroundColor Green
Write-Host "Backup: $Receipt"
Write-Host "Reinicie o Brave e confira brave://policy."
