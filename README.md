# Brave Origin Policy

Pacote de políticas para aproximar o Brave convencional de uma configuração
minimalista no estilo Brave Origin.

## Perfil

- Privacidade Maximum
- Brave Sync desativado por política
- Extensões liberadas
- Brave Shields mantido
- Safe Browsing principal mantido
- Atualizações mantidas

## Windows 10/11

Abra PowerShell como Administrador:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
cd .\Brave-Origin-Policy\Windows
.\Install-BraveOriginPolicy.ps1
```

Para restaurar:

```powershell
.\Restore-BraveOriginPolicy.ps1
```

Os backups ficam em:

`%ProgramData%\BraveOriginPolicy`

## Linux

Instalar:

```bash
cd Brave-Origin-Policy/Linux
sudo bash install.sh
```

Verificar:

```bash
bash verify.sh
```

Restaurar:

```bash
sudo bash restore.sh
```

## Verificação geral

Abra:

`brave://policy`

Clique em Recarregar políticas e confira os resultados.

## Observações

- Políticas não removem componentes do executável.
- Algumas políticas dependem da versão e plataforma.
- Snap e Flatpak podem exigir configuração diferente.
- SyncDisabled bloqueia o Sync, mas não apaga dados já sincronizados.
- Telemetria opcional desativada não significa ausência de conexões de rede.
- Extensões continuam livres para instalação.
- O pacote não desativa Brave Shields nem seus filtros.

Documentação:
https://support.brave.app/hc/en-us/articles/360039248271-Group-Policy
https://chromeenterprise.google/policies/
