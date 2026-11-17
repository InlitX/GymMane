param(
  [Parameter(Position = 0)][string]$Source,
  [Parameter(Position = 1)][string]$Serial
)

$ErrorActionPreference = 'Stop'
$watchDir = '/sdcard/Android/data/com.gymmane.app/files/sync'
$prefix = 'gymmane-auto-'

if (-not $Source -or $Source -in '-h', '--help') {
  Write-Host 'GymMane watch sync'
  Write-Host ''
  Write-Host '  .\sync.ps1 <folder>            the folder where your phone or server leaves its backups'
  Write-Host '  .\sync.ps1 <backup.zip>        a single backup exported from the phone'
  Write-Host '  .\sync.ps1 <folder> <serial>   pick the watch when more than one device is connected'
  Write-Host ''
  Write-Host 'Sends your newest backup to the watch and brings back the workouts done on the watch.'
  exit 0
}

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
  Write-Host 'adb was not found. Install Android platform-tools first.'
  exit 1
}

function Invoke-Adb {
  if ($Serial) { & adb -s $Serial @args } else { & adb @args }
}

if (-not $Serial) {
  $devices = @(& adb devices | Select-Object -Skip 1 | Where-Object { $_ -match '\tdevice$' })
  if ($devices.Count -eq 0) { Write-Host 'No device connected. Pair the watch first (see WEAR.md).'; exit 1 }
  if ($devices.Count -ne 1) {
    Write-Host 'More than one device is connected. Run it again with the watch serial:'
    $devices | ForEach-Object { Write-Host "  $(($_ -split "`t")[0])" }
    exit 1
  }
}

$installed = Invoke-Adb shell pm path com.gymmane.app 2>$null
if (-not $installed) { Write-Host 'GymMane is not installed on that device.'; exit 1 }
Invoke-Adb shell mkdir -p $watchDir | Out-Null

$newest = $null
if (Test-Path $Source -PathType Container) {
  $folder = (Resolve-Path $Source).Path
  $newest = Get-ChildItem $folder -Filter "$prefix*.zip" |
    Where-Object { $_.Name -match "^$prefix([a-z]+)-(.+)\.zip$" -and $Matches[1] -notlike 'watch*' } |
    Sort-Object { $_.Name -replace "^$prefix[a-z]+-", '' } | Select-Object -Last 1
  if ($newest) { $target = [IO.Path]::GetFileNameWithoutExtension($newest.Name) + '.json' }
} elseif (Test-Path $Source -PathType Leaf) {
  $newest = Get-Item $Source
  $folder = $newest.DirectoryName
  $target = $prefix + 'phone-' + [DateTime]::UtcNow.ToString('yyyy-MM-dd-HHmmss') + '.json'
} else {
  Write-Host "$Source is not a folder or a file."
  exit 1
}

$tmp = Join-Path ([IO.Path]::GetTempPath()) ("gymmane-watch-" + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $tmp | Out-Null
try {
  if ($newest) {
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $sent = $false
    $zip = $null
    try {
      $zip = [IO.Compression.ZipFile]::OpenRead($newest.FullName)
      $entry = $zip.Entries | Where-Object { $_.FullName -eq 'gymmane.json' } | Select-Object -First 1
      if ($entry) {
        $out = Join-Path $tmp $target
        [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $out, $true)
        Invoke-Adb push $out "$watchDir/$target" | Out-Null
        $sent = $true
      }
    } catch {
      $sent = $false
    } finally {
      if ($zip) { $zip.Dispose() }
    }
    if ($sent) { Write-Host "Sent to the watch: $($newest.Name)" }
    else { Write-Host "$($newest.Name) is not a GymMane backup, nothing was sent." }
  } else {
    Write-Host "No backup found in $folder, nothing was sent."
  }

  $brought = 0
  $names = @(Invoke-Adb shell ls $watchDir 2>$null | ForEach-Object { $_.Trim() } |
    Where-Object { $_ -match "^${prefix}watch[a-z]*-.+\.zip$" })
  foreach ($name in $names) {
    $local = Join-Path $folder $name
    if (Test-Path $local) { continue }
    Invoke-Adb pull "$watchDir/$name" $local | Out-Null
    $brought++
  }
  if ($brought -eq 0) { Write-Host 'Nothing new on the watch.' }
  else { Write-Host "Brought from the watch: $brought file(s) into $folder" }
  Write-Host 'On the watch, open GymMane > Settings > Sync now.'
} finally {
  Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}
