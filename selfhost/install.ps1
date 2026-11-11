$ErrorActionPreference = 'Stop'
$repo = 'InlitX/GymMane'
$port = if ($env:GYMMANE_PORT) { $env:GYMMANE_PORT } else { '8080' }
$home_ = if ($env:GYMMANE_HOME) { $env:GYMMANE_HOME } else { Join-Path $env:LOCALAPPDATA 'GymMane' }
$data = Join-Path $home_ 'data'
$envFile = Join-Path $home_ 'gymmane.env'
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($args -contains '--uninstall') {
  Unregister-ScheduledTask -TaskName 'GymMane' -Confirm:$false -ErrorAction SilentlyContinue
  Get-Process gymmane-server -ErrorAction SilentlyContinue | Stop-Process -Force
  Remove-Item -Recurse -Force (Join-Path $home_ 'web'), (Join-Path $home_ 'gymmane-server.exe'), (Join-Path $home_ 'run.cmd') -ErrorAction SilentlyContinue
  Write-Host "GymMane removed. Your data is still in $data"
  return
}

if ($null -ne $env:GYMMANE_PASSWORD) {
  $pass = $env:GYMMANE_PASSWORD
} elseif (Test-Path $envFile) {
  $pass = ((Get-Content $envFile | Where-Object { $_ -like 'GYMMANE_PASSWORD=*' }) -replace '^GYMMANE_PASSWORD=', '')
} else {
  $chars = [char[]]'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789'
  $pass = -join (1..16 | ForEach-Object { $chars | Get-Random })
}

$extra = @()
if (Test-Path $envFile) {
  $extra = @(Get-Content $envFile | Where-Object { $_ -match '^GYMMANE_' -and $_ -notmatch '^GYMMANE_(PASSWORD|PORT|DATA|WEB)=' })
}

Write-Host 'Downloading GymMane'
$tmp = Join-Path ([IO.Path]::GetTempPath()) ('gymmane-' + [guid]::NewGuid())
New-Item -ItemType Directory -Force $tmp | Out-Null
$zip = Join-Path $tmp 'gymmane.zip'
Invoke-WebRequest -UseBasicParsing "https://github.com/$repo/releases/latest/download/gymmane-selfhost-windows-x64.zip" -OutFile $zip
Expand-Archive $zip -DestinationPath $tmp -Force

Get-Process gymmane-server -ErrorAction SilentlyContinue | Stop-Process -Force
New-Item -ItemType Directory -Force $home_, $data | Out-Null
Remove-Item -Recurse -Force (Join-Path $home_ 'web') -ErrorAction SilentlyContinue
Copy-Item -Recurse -Force (Join-Path $tmp 'gymmane\*') $home_
Remove-Item -Recurse -Force $tmp

Set-Content -Path $envFile -Value (@("GYMMANE_PASSWORD=$pass", "GYMMANE_PORT=$port") + $extra) -Encoding ascii
$run = Join-Path $home_ 'run.cmd'
Set-Content -Path $run -Encoding ascii -Value @(
  '@echo off',
  "cd /d `"$home_`"",
  "set GYMMANE_DATA=$data",
  "set GYMMANE_WEB=$home_\web",
  'for /f "usebackq eol=# tokens=1,* delims==" %%a in ("gymmane.env") do set "%%a=%%b"',
  'gymmane-server.exe'
)

$action = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument "/c `"$run`"" -WorkingDirectory $home_
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit ([TimeSpan]::Zero) -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)
if ($admin) {
  $trigger = New-ScheduledTaskTrigger -AtStartup
  $principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -RunLevel Highest
  Register-ScheduledTask -TaskName 'GymMane' -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force | Out-Null
  New-NetFirewallRule -DisplayName 'GymMane' -Direction Inbound -Protocol TCP -LocalPort $port -Action Allow -ErrorAction SilentlyContinue | Out-Null
} else {
  $trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
  Register-ScheduledTask -TaskName 'GymMane' -Action $action -Trigger $trigger -Settings $settings -Force | Out-Null
}
Start-ScheduledTask -TaskName 'GymMane'

Write-Host ''
Write-Host 'GymMane is running. Open it at:'
Write-Host "  http://localhost:$port"
Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
  Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' } |
  ForEach-Object { Write-Host "  http://$($_.IPAddress):$port" }
if ($pass) {
  Write-Host ''
  Write-Host "Password: $pass   (any user name works)"
}
if (-not $admin) {
  Write-Host ''
  Write-Host 'It starts when you log in. Run this as administrator to start it with Windows and open the firewall port.'
}
Write-Host ''
Write-Host "Your data lives in $data. Run this again any time to update."
