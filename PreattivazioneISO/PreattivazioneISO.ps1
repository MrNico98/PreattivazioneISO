if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Necessita di essere lanciato come Amministratore. Riavvio."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "irm -Uri https://bit.ly/preattivazioneiso | iex"
    break
}

Set-MpPreference -ExclusionPath "C:\Preattivazione"

# Change to the desktop directory

New-Item -ItemType Directory -Path C:\Preattivazione -Force

cd "C:\Preattivazione"

# Download the script from GitHub
Invoke-WebRequest -Uri "https://github.com/MrNico98/PreattivazioneISO/archive/refs/heads/main.zip" -OutFile "PreattivazioneISO-main.zip"


Expand-Archive -Path "PreattivazioneISO-main.zip" -DestinationPath "." -Force


Move-Item -Path "PreattivazioneISO-main\PreattivazioneISO" -Destination "PreattivazioneISO" -Force


Remove-Item -Path "PreattivazioneISO-main" -Recurse -Force


Remove-Item -Path "PreattivazioneISO-main.zip" -Force


Start-Process -FilePath ".\PreattivazioneISO\WinCustomizerPreattivazioneISO.cmd" -Wait


Remove-Item -Path "C:\Preattivazione" -Recurse -Force

Write-Host: "Fatto"
