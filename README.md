# Brave Origin Policy

A policy package to bring the standard Brave closer to a minimalist, "Brave Origin"-style configuration.

## Profile

- Maximum privacy
- Brave Sync disabled by policy
- Extensions allowed
- Brave Shields retained
- Core Safe Browsing functionality retained
- Updates enabled

## Windows 10/11

Open PowerShell as Administrator:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
cd .\Brave-Origin-Policy\Windows
.\Install-BraveOriginPolicy.ps1
```

To restore:

```powershell
.\Restore-BraveOriginPolicy.ps1
```

The backups are located in:

`%ProgramData%\BraveOriginPolicy`

## Linux

Install:

```bash
cd Brave-Origin-Policy/Linux
sudo bash install.sh
```

To check:

```bash
bash verify.sh
```

Restore:

```bash
sudo bash restore.sh
```

## General check

Open:

`brave://policy`

Click on Reload policies and check the results.

## Notes

- Policies do not remove components from the executable.
- Some policies depend on the version and platform.
- Snap and Flatpak may require a different configuration.
- `SyncDisabled` blocks synchronization but does not delete data that has already been synced.
- Disabling optional telemetry does not mean there will be no network connections.
- Extensions can still be installed freely.
- The package does not disable Brave Shields or its filters.

Documentation:
https://support.brave.app/hc/en-us/articles/360039248271-Group-Policy
https://chromeenterprise.google/policies/
