param(
  [switch]$CreateVenv = $false
)

$ErrorActionPreference = 'Stop'

Write-Host "Preparing repository..." -ForegroundColor Cyan

# Optionally create and activate virtual env
if ($CreateVenv) {
  if (-not (Test-Path .\.venv)) {
    Write-Host "Creating virtual environment (.venv)..." -ForegroundColor Yellow
    python -m venv .venv
  }
  Write-Host "Activating virtual environment..." -ForegroundColor Yellow
  $venvActivate = Join-Path (Get-Location) ".venv\Scripts\Activate.ps1"
  if (Test-Path $venvActivate) { & $venvActivate } else { Write-Warning "Could not find venv activation script at $venvActivate" }
}

Write-Host "Upgrading pip and installing requirements..." -ForegroundColor Yellow
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

Write-Host "Running unit tests..." -ForegroundColor Yellow
python -m unittest discover -v

Write-Host "Done." -ForegroundColor Green
