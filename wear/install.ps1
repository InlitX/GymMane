param(
  [Parameter(Position = 0)][string]$Apk
)

$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$repo = 'InlitX/GymMane'
$tools = Join-Path $env:LOCALAPPDATA 'GymMane\platform-tools'

function Say($t) { Write-Host "  $t" }
function Step($n, $t) { Write-Host ''; Write-Host "  $n/4  $t" -ForegroundColor White; Write-Host '' }
function Ok($t) { Write-Host "     OK  $t" -ForegroundColor Green }
function Fail($t) { Write-Host ''; Write-Host "  $t" -ForegroundColor Red; Write-Host ''; exit 1 }
function Ask($q) { Write-Host "  ? $q " -NoNewline -ForegroundColor Yellow; return (Read-Host).Trim() }

if ($Apk -in '-h', '--help') {
  Write-Host 'GymMane watch installer'
  Write-Host ''
  Write-Host '  .\install.ps1              connects to the watch and installs the right APK from the latest release'
  Write-Host '  .\install.ps1 <file.apk>   installs that APK instead'
  exit 0
}

Write-Host ''
Write-Host '  GymMane for Wear OS' -ForegroundColor White
Say 'Before you start, on the watch: Settings > System > About > Versions, tap Build number 7 times.'
Say 'Then Settings > Developer options: turn on ADB debugging and Wireless debugging.'
Say 'The watch and this computer must be on the same Wi-Fi.'

Step 1 'adb'
$adb = (Get-Command adb -ErrorAction SilentlyContinue).Source
if (-not $adb -and (Test-Path "$tools\adb.exe")) { $adb = "$tools\adb.exe" }
if (-not $adb) {
  Say 'adb (Android platform-tools) is not installed. Downloading it from Google...'
  $zip = Join-Path ([IO.Path]::GetTempPath()) 'gymmane-platform-tools.zip'
  try {
    Invoke-WebRequest -UseBasicParsing 'https://dl.google.com/android/repository/platform-tools-latest-windows.zip' -OutFile $zip -ErrorAction Stop
    Expand-Archive -Path $zip -DestinationPath (Split-Path $tools) -Force -ErrorAction Stop
  } catch {
    Fail 'Could not download platform-tools. Get them from developer.android.com/tools/releases/platform-tools and run this again.'
  } finally {
    Remove-Item $zip -ErrorAction SilentlyContinue
  }
  $adb = "$tools\adb.exe"
}
Ok $adb

function Watches {
  $list = @()
  foreach ($line in (& $adb devices | Select-Object -Skip 1)) {
    if ($line -notmatch '^(\S+)\s+device$') { continue }
    $serial = $Matches[1]
    $features = & $adb -s $serial shell pm list features 2>$null
    if ($features -match 'android.hardware.type.watch') { $list += $serial }
  }
  return $list
}

Step 2 'Connect to the watch'
$watch = @(Watches) | Select-Object -First 1
if (-not $watch) {
  Say 'On the watch, open Developer options > Wireless debugging.'
  $address = Ask 'IP address and port shown there (like 192.168.1.20:41235):'
  if (-not $address) { Fail 'No address given.' }
  $out = & $adb connect $address 2>&1 | Out-String
  if ($out -notmatch 'connected to' -or $out -match 'failed|unable') {
    Say 'The watch needs pairing first. On the watch, tap Pair new device.'
    $pair = Ask 'Pairing address and port shown in that dialog:'
    $code = Ask 'Pairing code:'
    $p = & $adb pair $pair $code 2>&1 | Out-String
    if ($p -notmatch 'Successfully paired') { Fail "Pairing failed: $($p.Trim())" }
    Ok 'Paired'
    & $adb connect $address | Out-Null
  }
  Start-Sleep -Seconds 1
  $watch = @(Watches) | Select-Object -First 1
  if (-not $watch) { Fail 'The watch did not answer. Check that it is awake, on the same Wi-Fi, and that you allowed debugging on its screen.' }
}
$model = (& $adb -s $watch shell getprop ro.product.model).Trim()
Ok "$model ($watch)"

Step 3 'GymMane'
$tmp = $null
if ($Apk) {
  if (-not (Test-Path $Apk -PathType Leaf)) { Fail "$Apk does not exist." }
  $file = (Resolve-Path $Apk).Path
} else {
  $abis = (& $adb -s $watch shell getprop ro.product.cpu.abilist).Trim() -split ','
  $abi = $abis | ForEach-Object { $_.Trim() } | Where-Object { @('arm64-v8a', 'armeabi-v7a', 'x86_64') -contains $_ } | Select-Object -First 1
  if (-not $abi) { Fail "This watch reports $($abis -join ', '), and there is no GymMane APK for it." }
  $tmp = Join-Path ([IO.Path]::GetTempPath()) "GymMane-$abi.apk"
  Say "Downloading GymMane for $abi from the latest release..."
  try {
    Invoke-WebRequest -UseBasicParsing "https://github.com/$repo/releases/latest/download/GymMane-$abi.apk" -OutFile $tmp -ErrorAction Stop
  } catch {
    Fail 'Could not download the APK. Check the connection and try again.'
  }
  $file = $tmp
}
Ok (Split-Path $file -Leaf)

Step 4 'Install'
try {
  $r = & $adb -s $watch install -r $file 2>&1 | Out-String
} finally {
  if ($tmp) { Remove-Item $tmp -ErrorAction SilentlyContinue }
}
if ($r -match 'VERSION_DOWNGRADE') { Fail 'The watch already has a newer GymMane than this one. Nothing to do.' }
if ($r -match 'UPDATE_INCOMPATIBLE') { Fail 'The GymMane on the watch was signed by someone else. Uninstall it from the watch first, then run this again.' }
if ($r -notmatch 'Success') { Fail "The watch refused the install: $($r.Trim())" }
Ok 'GymMane is on the watch'

Write-Host ''
Say 'Open GymMane on the watch. To sync it with your phone, see WEAR.md.'
Say 'You can turn Wireless debugging off now.'
Write-Host ''
