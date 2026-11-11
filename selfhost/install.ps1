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

  $vt = $false
  try { $vt = [bool]$Host.UI.SupportsVirtualTerminal } catch { }
  if ($env:NO_COLOR -or [Console]::IsOutputRedirected) { $vt = $false }
  $e = [char]27
  function Rgb($r, $g, $b) { if ($vt) { "$e[38;2;$r;$g;${b}m" } else { '' } }
  $R = if ($vt) { "$e[0m" } else { '' }
  $B = if ($vt) { "$e[1m" } else { '' }
  $A = Rgb 217 161 132
  $G = Rgb 143 181 140
  $D = Rgb 128 128 128
  $F = Rgb 80 80 80
  $Y = Rgb 230 190 110
  $X = Rgb 230 120 110
  $SH = Rgb 96 78 66
  $CLR = if ($vt) { "`r$e[K" } else { "`r" }

  $tick = [string][char]0x2713
  $cross = [string][char]0x2717
  $dot = [string][char]0x00B7
  $bul = [string][char]0x203A
  $hz = [string][char]0x2500
  $vbar = [string][char]0x2502
  $spin = @(0x280B, 0x2819, 0x2839, 0x2838, 0x283C, 0x2834, 0x2826, 0x2827, 0x2807, 0x280F) | ForEach-Object { [string][char]$_ }

  $script:step = 0
  $script:steps = 4
  $script:boxW = 52

  function Put($t) { Write-Host $t -NoNewline }
  function Line($t) { Write-Host $t }
  function Step($t) { $script:step++; Line ''; Line "  $A$B$($script:step)$R$F/$($script:steps)$R  $B$t$R"; Line '' }
  function Ok($t) { Line "     $G$tick$R  $t" }
  function Note($t) { Line "     $D$dot  $t$R" }
  function Warn($t) { Line "     $Y!$R  $t" }
  function Prompt-Line($q, $hint) { Put "  $A?$R  $q $F$hint$R $A$bul$R " }

  function Spinner($i, $msg) { if ($vt) { Put "$CLR     $A$($spin[$i % 10])$R  $D$msg$R" } }
  function Unspin { if ($vt) { Put $CLR } }

  function BoxFit([string[]]$values) { foreach ($v in $values) { if ($v.Length + 11 -gt $script:boxW) { $script:boxW = $v.Length + 11 } } }
  function BoxTop { Line "  $F$([char]0x256D)$($hz * ($script:boxW + 2))$([char]0x256E)$R" }
  function BoxBottom { Line "  $F$([char]0x2570)$($hz * ($script:boxW + 2))$([char]0x256F)$R" }
  function BoxRow([string]$plain, [string]$styled) {
    if (-not $styled) { $styled = $plain }
    $pad = [Math]::Max(0, $script:boxW - $plain.Length)
    Line "  $F$vbar$R $styled$(' ' * $pad) $F$vbar$R"
  }
  function BoxPair($label, $value) { BoxRow ($label.PadRight(11) + $value) ("$D$($label.PadRight(11))$R$value") }

  function Ask($q, $default) {
    if ($quiet) { return $default }
    Prompt-Line $q $default
    $a = Read-Host
    if ([string]::IsNullOrWhiteSpace($a)) { return $default }
    return $a.Trim()
  }

  function YesNo($q, $default) {
    if ($quiet) { return $default }
    $hint = if ($default) { 'Y/n' } else { 'y/N' }
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

  function Banner {
    $map = @{ '#' = [char]0x2588; '7' = [char]0x2557; 'L' = [char]0x255A; 'J' = [char]0x255D; 'F' = [char]0x2554; '=' = [char]0x2550; '|' = [char]0x2551 }
    $art = @(
      '   ######7 ##7   ##7###7   ###7###7   ###7 #####7 ###7   ##7#######7',
      '  ##F====J L##7 ##FJ####7 ####|####7 ####|##F==##7####7  ##|##F====J',
      '  ##|  ###7 L####FJ ##F####F##|##F####F##|#######|##F##7 ##|#####7  ',
      '  ##|   ##|  L##FJ  ##|L##FJ##|##|L##FJ##|##F==##|##|L##7##|##F==J  ',
      '  L######FJ   ##|   ##| L=J ##|##| L=J ##|##|  ##|##| L####|#######7',
      '   L=====J    L=J   L=J     L=JL=J     L=JL=J  L=JL=J  L===JL======J'
    )
    $tones = @(@(242, 200, 174), @(234, 188, 160), @(225, 175, 146), @(212, 164, 135), @(198, 153, 124), @(185, 143, 114))
    Line ''
    for ($i = 0; $i -lt $art.Count; $i++) {
      $c = Rgb $tones[$i][0] $tones[$i][1] $tones[$i][2]
      $sb = New-Object Text.StringBuilder
      $last = ''
      foreach ($ch in $art[$i].ToCharArray()) {
        $s = [string]$ch
        if ($map.ContainsKey($s)) {
          $want = if ($s -eq '#') { $c } else { $SH }
          if ($want -ne $last) { [void]$sb.Append($want); $last = $want }
          [void]$sb.Append($map[$s])
        } else { [void]$sb.Append($s) }
      }
      Line ($sb.ToString() + $R)
    }
    Line ''
    Line "  ${B}Self-host installer$R  $F$dot$R  ${D}your gym log, on your own machine$R"
    Line "  ${D}No account, no cloud. Your data stays in one folder here.$R"
  }

  Banner

  Step 'This machine'
  $os = (Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption
  if (-not $os) { $os = 'Windows' }
  Ok "$os $D($($env:PROCESSOR_ARCHITECTURE.ToLower()))$R"
  if ($admin) { Note 'Running as administrator: GymMane starts with Windows' } else { Note "Running as $env:USERNAME, no administrator needed: GymMane starts when you log in" }
  $installed = Test-Path $exe
  if ($installed) { Ok "GymMane is already installed in $home_" }

  if ($installed -and -not $action) {
    if ($quiet) { $action = 'update' } else {
      Line ''
      while (-not $action) {
        Prompt-Line 'What do you want to do?' '[U]pdate, [r]emove, [c]ancel'
        switch ((Read-Host).Trim().ToLower()) {
          { $_ -in '', 'u', 'update' } { $action = 'update' }
          { $_ -in 'r', 'remove' } { $action = 'remove' }
          { $_ -in 'c', 'cancel' } { Line ''; return }
          default { Note 'Type u, r or c.' }
        }
      }
    }
  }

  if ($action -eq 'remove') {
    $script:steps = 2
    Line ''
    if (-not $quiet -and -not (YesNo "Remove GymMane? Your data stays in $data" $false)) { Line ''; return }
    Step 'Removing GymMane'
    Unregister-ScheduledTask -TaskName 'GymMane' -Confirm:$false -ErrorAction SilentlyContinue
    Get-Process gymmane-server -ErrorAction SilentlyContinue | Stop-Process -Force
    Ok 'Stopped it and removed it from startup'
    if ($admin) { Remove-NetFirewallRule -DisplayName 'GymMane' -ErrorAction SilentlyContinue }
    Remove-Item -Recurse -Force (Join-Path $home_ 'web'), $exe, (Join-Path $home_ 'run.cmd'), (Join-Path $home_ 'start.bat') -ErrorAction SilentlyContinue
    Ok 'Removed the program files'
    Line ''
    Line "  Your data is still in $B$data$R. Delete that folder yourself if you want it gone."
    Line ''
    return
  }

  $update = $action -eq 'update'
  $oldPort = EnvValue 'GYMMANE_PORT'
  $port = if ($env:GYMMANE_PORT) { $env:GYMMANE_PORT } elseif ($oldPort) { $oldPort } else { '8080' }

  Step 'Settings'
  if ($update) { Ok 'Keeping your port, password and data' } elseif (-not $quiet) { Note 'Press Enter to keep the value in grey.'; Line '' }
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
        $p = Secret 'Password, or Enter to make one up'
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

  $starts = if ($admin) { 'starts with Windows' } else { 'starts when you log in' }
  BoxFit @($home_, $starts)
  Line ''
  BoxTop
  if ($update) { BoxRow 'Ready to update' "${B}Ready to update$R" } else { BoxRow 'Ready to install' "${B}Ready to install$R" }
  BoxRow ''
  BoxPair 'Folder' $home_
  BoxPair 'Runs with' $starts
  BoxPair 'Port' $port
  BoxPair 'Password' $(if ($pass) { 'yes' } else { 'no, open to your network' })
  BoxBottom
  Line ''
  if (-not (YesNo 'Go ahead?' $true)) { Line ''; return }

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
      Ok "Unpacked $(Split-Path $env:GYMMANE_ARCHIVE -Leaf)"
    } else {
      $zip = Join-Path $tmp 'gymmane.zip'
      Spinner 0 'Downloading gymmane-selfhost-windows-x64.zip'
      [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
      try { Invoke-WebRequest -UseBasicParsing "https://github.com/$repo/releases/latest/download/gymmane-selfhost-windows-x64.zip" -OutFile $zip }
      catch { Unspin; throw 'Could not download GymMane from the latest release. Check the internet connection and try again.' }
      Unspin
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
  Ok "Started GymMane, it $starts"

  if ($openPort) {
    Remove-NetFirewallRule -DisplayName 'GymMane' -ErrorAction SilentlyContinue
    New-NetFirewallRule -DisplayName 'GymMane' -Direction Inbound -Protocol TCP -LocalPort $port -Action Allow | Out-Null
    Ok "Opened port $port in Windows Firewall"
  }

  $up = $false
  for ($i = 0; $i -lt 60; $i++) {
    Spinner $i 'Waiting for GymMane to answer'
    if (($i % 2 -eq 0) -and (Healthy $port $pass)) { $up = $true; break }
    Start-Sleep -Milliseconds 500
  }
  Unspin
  if ($up) { Ok "GymMane answers on port $port" } else { Warn "GymMane is not answering yet. See what it says in $home_\gymmane.log" }

  $links = @("http://localhost:$port")
  $real = @(Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'VirtualBox|VMware|Hyper-V|WSL|TAP|Loopback' } | ForEach-Object { $_.ifIndex })
  Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
    Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' -and ($real.Count -eq 0 -or $real -contains $_.InterfaceIndex) } |
    ForEach-Object { $links += "http://$($_.IPAddress):$port" }
  $script:boxW = 52
  BoxFit $links
  if ($generated) { BoxFit @("$pass  (any user name works)") }

  Line ''
  BoxTop
  if ($up) { BoxRow "+ GymMane is running" "$G$tick$R ${B}GymMane is running$R" } else { BoxRow 'GymMane is installed' "${B}GymMane is installed$R" }
  BoxRow ''
  BoxRow 'Open it from any device on your network:' "${D}Open it from any device on your network:$R"
  foreach ($l in $links) { BoxRow "  $l" "  $A$B$l$R" }
  if ($pass) {
    BoxRow ''
    if ($generated) {
      BoxPair 'Password' $pass
      BoxRow '           made up for you, any user name works' "           ${D}made up for you, any user name works$R"
    } else {
      BoxPair 'Password' 'the one you chose'
    }
  }
  BoxBottom
  if (-not $admin) {
    Line ''
    Line "  ${D}Run this as administrator to start it with Windows and open the firewall port.$R"
  }
  Line ''
  Line "  ${D}Data      $R$data"
  Line "  ${D}Settings  $R$envFile"
  Line "  ${D}Logs      $R$home_\gymmane.log"
  Line "  ${D}Update    ${R}run this command again"
  Line ''
}

try { Install-GymMane } catch {
  Write-Host ''
  Write-Host "     x  $($_.Exception.Message)" -ForegroundColor Red
  Write-Host ''
}
