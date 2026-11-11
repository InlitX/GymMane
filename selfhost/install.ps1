function Install-GymMane {
  $ErrorActionPreference = 'Stop'
  $ProgressPreference = 'SilentlyContinue'
  $repo = 'InlitX/GymMane'
  $home_ = if ($env:GYMMANE_HOME) { $env:GYMMANE_HOME } else { Join-Path $env:LOCALAPPDATA 'GymMane' }
  $data = Join-Path $home_ 'data'
  $envFile = Join-Path $home_ 'gymmane.env'
  $exe = Join-Path $home_ 'gymmane-server.exe'
  $admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  $quiet = $env:GYMMANE_YES -eq '1'
  $action = if ($env:GYMMANE_UNINSTALL -eq '1') { 'remove' } else { '' }

  function Step($t) { Write-Host ''; Write-Host '  > ' -ForegroundColor DarkYellow -NoNewline; Write-Host $t -ForegroundColor White }
  function Ok($t) { Write-Host '    + ' -ForegroundColor Green -NoNewline; Write-Host $t }
  function Note($t) { Write-Host "    - $t" -ForegroundColor DarkGray }
  function Warn($t) { Write-Host '    ! ' -ForegroundColor Yellow -NoNewline; Write-Host $t }
  function Prompt-Line($q, $hint) { Write-Host '  ? ' -ForegroundColor DarkYellow -NoNewline; Write-Host "$q " -NoNewline; Write-Host $hint -ForegroundColor DarkGray -NoNewline; Write-Host ' ' -NoNewline }

  function Ask($q, $default) {
    if ($quiet) { return $default }
    Prompt-Line $q "($default)"
    $a = Read-Host
    if ([string]::IsNullOrWhiteSpace($a)) { return $default }
    return $a.Trim()
  }

  function YesNo($q, $default) {
    if ($quiet) { return $default }
    $hint = if ($default) { '[Y/n]' } else { '[y/N]' }
    while ($true) {
      Prompt-Line $q $hint
      $a = (Read-Host).Trim().ToLower()
      if ($a -eq '') { return $default }
      if (@('y', 'yes', 's', 'si') -contains $a) { return $true }
      if (@('n', 'no') -contains $a) { return $false }
      Note 'Type y or n.'
    }
  }

  function Secret($q) {
    Prompt-Line $q ''
    $s = Read-Host -AsSecureString
    $p = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($s)
    try { return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($p) } finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($p) }
  }

  function EnvValue($key) {
    if (-not (Test-Path $envFile)) { return $null }
    $line = Get-Content $envFile | Where-Object { $_ -like "$key=*" } | Select-Object -First 1
    if ($null -eq $line) { return $null }
    return $line.Substring($key.Length + 1)
  }

  function ValidPassword($p) { return $p.Length -ge 8 -and $p -match '^[A-Za-z0-9._@%+=!?~^:,/-]+$' }

  function Healthy($port, $pass) {
    $headers = @{}
    if ($pass) { $headers['Authorization'] = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("gymmane:$pass")) }
    try {
      $r = Invoke-WebRequest -UseBasicParsing -TimeoutSec 3 -Headers $headers "http://127.0.0.1:$port/api/health"
      return $r.StatusCode -eq 200
    } catch { return $false }
  }

  Write-Host ''
  Write-Host @'
     ____                 __  __
    / ___|_   _ _ __ ___ |  \/  | __ _ _ __   ___
   | |  _| | | | '_ ` _ \| |\/| |/ _` | '_ \ / _ \
   | |_| | |_| | | | | | | |  | | (_| | | | |  __/
    \____|\__, |_| |_| |_|_|  |_|\__,_|_| |_|\___|
          |___/
'@ -ForegroundColor DarkYellow
  Write-Host '    Self-host installer' -ForegroundColor White
  Write-Host '    The whole app in your browser. Your data stays on this machine.' -ForegroundColor DarkGray

  Step 'Checking this machine'
  Ok "Windows, $env:PROCESSOR_ARCHITECTURE"
  if ($admin) { Ok 'Running as administrator' } else { Note 'Not running as administrator: GymMane will start when you log in' }
  $installed = Test-Path $exe
  if ($installed) { Ok "GymMane is already installed in $home_" }

  if ($installed -and -not $action) {
    if ($quiet) { $action = 'update' } else {
      Write-Host ''
      while (-not $action) {
        Prompt-Line 'What do you want to do?' '[U]pdate, [r]emove, [c]ancel'
        switch ((Read-Host).Trim().ToLower()) {
          { $_ -in '', 'u', 'update' } { $action = 'update' }
          { $_ -in 'r', 'remove' } { $action = 'remove' }
          { $_ -in 'c', 'cancel' } { Write-Host ''; return }
          default { Note 'Type u, r or c.' }
        }
      }
    }
  }

  if ($action -eq 'remove') {
    Write-Host ''
    if (-not $quiet -and -not (YesNo "Remove GymMane? Your data stays in $data" $false)) { Write-Host ''; return }
    Step 'Removing GymMane'
    Unregister-ScheduledTask -TaskName 'GymMane' -Confirm:$false -ErrorAction SilentlyContinue
    Get-Process gymmane-server -ErrorAction SilentlyContinue | Stop-Process -Force
    Ok 'Stopped it and removed it from startup'
    if ($admin) { Remove-NetFirewallRule -DisplayName 'GymMane' -ErrorAction SilentlyContinue }
    Remove-Item -Recurse -Force (Join-Path $home_ 'web'), $exe, (Join-Path $home_ 'run.cmd'), (Join-Path $home_ 'start.bat') -ErrorAction SilentlyContinue
    Ok 'Removed the program files'
    Write-Host ''
    Write-Host "  Your data is still in $data. Delete that folder yourself if you want it gone."
    Write-Host ''
    return
  }

  $update = $action -eq 'update'
  $oldPort = EnvValue 'GYMMANE_PORT'
  $port = if ($env:GYMMANE_PORT) { $env:GYMMANE_PORT } elseif ($oldPort) { $oldPort } else { '8080' }
  Write-Host ''
  if (-not $update -and -not $env:GYMMANE_PORT) {
    while ($true) {
      $p = Ask 'Port to open GymMane on' $port
      $n = 0
      if ([int]::TryParse($p, [ref]$n) -and $n -ge 1 -and $n -le 65535) { $port = "$n"; break }
      Note 'Type a number between 1 and 65535.'
    }
  }

  $generated = $false
  if ($null -ne $env:GYMMANE_PASSWORD) {
    $pass = $env:GYMMANE_PASSWORD
    if ($pass -and -not (ValidPassword $pass)) { throw 'GYMMANE_PASSWORD needs 8 or more characters: letters, digits and . _ @ % + = ! ? ~ ^ : , / -' }
  } elseif ($update) {
    $pass = EnvValue 'GYMMANE_PASSWORD'
  } elseif (YesNo 'Ask for a password in the browser?' $true) {
    $pass = ''
    if (-not $quiet) {
      while ($true) {
        $p = Secret 'Password (press Enter to make one up for you)'
        if (-not $p) { break }
        if (ValidPassword $p) { $pass = $p; break }
        Note '8 or more characters: letters, digits and . _ @ % + = ! ? ~ ^ : , / -'
      }
    }
    if (-not $pass) {
      $chars = [char[]]'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789'
      $pass = -join (1..16 | ForEach-Object { $chars | Get-Random })
      $generated = $true
    }
  } else {
    $pass = ''
  }

  $openPort = $false
  if ($admin) { $openPort = YesNo "Open port $port in Windows Firewall so other devices can reach it?" $true }

  Write-Host ''
  Write-Host $(if ($update) { '  Ready to update' } else { '  Ready to install' }) -ForegroundColor White
  Write-Host "    Folder     $home_"
  Write-Host "    Starts     $(if ($admin) { 'with Windows' } else { 'when you log in' })"
  Write-Host "    Port       $port"
  Write-Host "    Password   $(if ($pass) { 'yes' } else { 'no' })"
  Write-Host ''
  if (-not (YesNo 'Go ahead?' $true)) { Write-Host ''; return }

  $extra = @()
  if (Test-Path $envFile) {
    $extra = @(Get-Content $envFile | Where-Object { $_ -match '^GYMMANE_' -and $_ -notmatch '^GYMMANE_(PASSWORD|PORT|DATA|WEB)=' })
  }

  Step 'Installing GymMane'
  $tmp = Join-Path ([IO.Path]::GetTempPath()) ('gymmane-' + [guid]::NewGuid())
  New-Item -ItemType Directory -Force $tmp | Out-Null
  try {
    if ($env:GYMMANE_ARCHIVE) {
      Expand-Archive $env:GYMMANE_ARCHIVE -DestinationPath $tmp -Force
      Ok "Unpacked $env:GYMMANE_ARCHIVE"
    } else {
      $zip = Join-Path $tmp 'gymmane.zip'
      [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
      try { Invoke-WebRequest -UseBasicParsing "https://github.com/$repo/releases/latest/download/gymmane-selfhost-windows-x64.zip" -OutFile $zip }
      catch { throw 'Could not download GymMane from the latest release. Check the internet connection and try again.' }
      Expand-Archive $zip -DestinationPath $tmp -Force
      Ok 'Downloaded gymmane-selfhost-windows-x64.zip'
    }
    Stop-ScheduledTask -TaskName 'GymMane' -ErrorAction SilentlyContinue
    Get-Process gymmane-server -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Sleep -Milliseconds 500
    New-Item -ItemType Directory -Force $home_, $data | Out-Null
    Remove-Item -Recurse -Force (Join-Path $home_ 'web') -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force (Join-Path $tmp 'gymmane\*') $home_
    Ok "Copied it to $home_"
  } finally {
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
  }

  Set-Content -Path $envFile -Value (@("GYMMANE_PASSWORD=$pass", "GYMMANE_PORT=$port") + $extra) -Encoding ascii
  Ok "Saved the settings in $envFile"
  $run = Join-Path $home_ 'run.cmd'
  Set-Content -Path $run -Encoding ascii -Value @(
    '@echo off',
    "cd /d `"$home_`"",
    "set GYMMANE_DATA=$data",
    "set GYMMANE_WEB=$home_\web",
    'for /f "usebackq eol=# tokens=1,* delims==" %%a in ("gymmane.env") do set "%%a=%%b"',
    'gymmane-server.exe >> gymmane.log 2>&1'
  )

  $taskAction = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument "/c `"$run`"" -WorkingDirectory $home_
  $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit ([TimeSpan]::Zero) -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)
  if ($admin) {
    $trigger = New-ScheduledTaskTrigger -AtStartup
    $principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -RunLevel Highest
    Register-ScheduledTask -TaskName 'GymMane' -Action $taskAction -Trigger $trigger -Settings $settings -Principal $principal -Force | Out-Null
  } else {
    $trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
    Register-ScheduledTask -TaskName 'GymMane' -Action $taskAction -Trigger $trigger -Settings $settings -Force | Out-Null
  }
  Start-ScheduledTask -TaskName 'GymMane'
  Ok $(if ($admin) { 'Started GymMane, it starts again with Windows' } else { 'Started GymMane, it starts again when you log in' })

  if ($openPort) {
    Remove-NetFirewallRule -DisplayName 'GymMane' -ErrorAction SilentlyContinue
    New-NetFirewallRule -DisplayName 'GymMane' -Direction Inbound -Protocol TCP -LocalPort $port -Action Allow | Out-Null
    Ok "Opened port $port in Windows Firewall"
  }

  $up = $false
  for ($i = 0; $i -lt 30; $i++) {
    if (Healthy $port $pass) { $up = $true; break }
    Start-Sleep -Seconds 1
  }
  if ($up) { Ok "GymMane answers on port $port" } else { Warn "GymMane is not answering yet. See what it says in $home_\gymmane.log" }

  Write-Host ''
  Write-Host '  GymMane is ready.' -ForegroundColor Green -NoNewline
  Write-Host ' Open it from any device on your network:'
  Write-Host "      http://localhost:$port" -ForegroundColor DarkYellow
  Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
    Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' } |
    ForEach-Object { Write-Host "      http://$($_.IPAddress):$port" -ForegroundColor DarkYellow }
  if ($pass) {
    Write-Host ''
    if ($generated) {
      Write-Host '  Password  ' -NoNewline; Write-Host $pass -ForegroundColor White -NoNewline; Write-Host '   (made up for you, any user name works)' -ForegroundColor DarkGray
    } else {
      Write-Host '  Password  the one you chose   ' -NoNewline; Write-Host '(any user name works)' -ForegroundColor DarkGray
    }
  }
  if (-not $admin) {
    Write-Host ''
    Write-Host '  Run this as administrator to start it with Windows and open the firewall port.' -ForegroundColor DarkGray
  }
  Write-Host ''
  Write-Host "  Data      $data" -ForegroundColor DarkGray
  Write-Host "  Settings  $envFile" -ForegroundColor DarkGray
  Write-Host "  Logs      $home_\gymmane.log" -ForegroundColor DarkGray
  Write-Host '  Update    run this command again' -ForegroundColor DarkGray
  Write-Host ''
}

try { Install-GymMane } catch {
  Write-Host ''
  Write-Host "  x $($_.Exception.Message)" -ForegroundColor Red
  Write-Host ''
}
