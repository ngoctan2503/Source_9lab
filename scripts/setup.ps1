param([string]$Only = '')
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw 'Flutter is not on PATH. Install Flutter stable, then reopen PowerShell.'
}
$labs = Get-Content (Join-Path $root 'labs.json') -Raw | ConvertFrom-Json
if ($Only) {
  $labs = @($labs | Where-Object { $_.name -eq $Only })
  if ($labs.Count -eq 0) { throw "Unknown lab: $Only. See labs.json." }
}
$utf8 = New-Object System.Text.UTF8Encoding($false)
foreach ($lab in $labs) {
  $destination = Join-Path $root ("apps/" + $lab.name)
  if (Test-Path $destination) {
    Write-Host "SKIP existing folder: $destination (no files overwritten)"
    continue
  }
  $null = New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force
  & flutter create --empty --platforms=android,ios,web --org com.example.flutterlabs --project-name $lab.name $destination
  if ($LASTEXITCODE -ne 0) { throw "flutter create failed: $($lab.name). Inspect the partial apps folder before retrying." }
  $template = Join-Path $root ("templates/" + $lab.name)
  Copy-Item -Path (Join-Path $template '*') -Destination $destination -Recurse -Force
  if ($lab.name -eq 'lab09_clima') {
    $manifest = Join-Path $destination 'android/app/src/main/AndroidManifest.xml'
    $content = [IO.File]::ReadAllText($manifest)
    $permissions = @'
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
'@
    $content = $content.Replace('<application', $permissions + "`n    <application")
    [IO.File]::WriteAllText($manifest, $content, $utf8)
    $plist = Join-Path $destination 'ios/Runner/Info.plist'
    $content = [IO.File]::ReadAllText($plist)
    $entry = @'
<key>NSLocationWhenInUseUsageDescription</key>
<string>Clima uses your location to show local weather.</string>
'@
    $content = [regex]::Replace($content, '</dict>\s*</plist>', $entry + "`n</dict>`n</plist>")
    [IO.File]::WriteAllText($plist, $content, $utf8)
  }
  Push-Location $destination
  try {
    & flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "pub get failed: $($lab.name)" }
  } finally { Pop-Location }
  Write-Host "READY: $($lab.name)"
}
Write-Host 'Done. Open an apps/labXX folder and run flutter analyze, then flutter run.'
