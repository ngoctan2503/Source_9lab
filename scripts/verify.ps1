param([string]$Only = '')
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$labs = Get-Content (Join-Path $root 'labs.json') -Raw | ConvertFrom-Json
if ($Only) {
  $labs = @($labs | Where-Object { $_.name -eq $Only })
  if ($labs.Count -eq 0) { throw "Unknown lab: $Only" }
}
foreach ($lab in $labs) {
  $path = Join-Path $root ("apps/" + $lab.name)
  if (-not (Test-Path $path)) { throw "Run setup first: $($lab.name)" }
  Push-Location $path
  try {
    & dart format lib
    if ($LASTEXITCODE -ne 0) { throw 'Formatting failed' }
    if (Test-Path 'test') {
      & dart format test
      if ($LASTEXITCODE -ne 0) { throw 'Test formatting failed' }
    }
    & flutter analyze
    if ($LASTEXITCODE -ne 0) { throw "Analysis failed: $($lab.name)" }
    if (Test-Path 'test') {
      & flutter test
      if ($LASTEXITCODE -ne 0) { throw "Tests failed: $($lab.name)" }
    }
  } finally { Pop-Location }
}
