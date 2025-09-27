# SPDX-License-Identifier: MIT
# Copyright (c) 2025 KraftyUX

param(
  [Parameter(Mandatory=$false)][string]$Owner = "KraftyUX",
  [Parameter(Mandatory=$false)][string]$Repo = "SENSES",
  [Parameter(Mandatory=$false)][string]$TokenEnvVar = "GH_TOKEN"
)

$ErrorActionPreference = 'Stop'

$token = [Environment]::GetEnvironmentVariable($TokenEnvVar)
if (-not $token) {
  Write-Error "Environment variable $TokenEnvVar is not set. Set it to a GitHub Personal Access Token with 'repo' scope."
  exit 1
}

$headers = @{
  "Accept"        = "application/vnd.github+json"
  "Authorization" = "Bearer $token"
  "X-GitHub-Api-Version" = "2022-11-28"
}

$baseUrl = "https://api.github.com/repos/$Owner/$Repo"

function Protect-Branch($branch) {
  Write-Host "Setting protection for $branch..." -ForegroundColor Cyan
  $body = @{ 
    required_status_checks = @{ 
      strict = $true
      contexts = @("CI")
    }
    enforce_admins = $true
    required_pull_request_reviews = @{ 
      dismiss_stale_reviews = $true
      required_approving_review_count = 1
    }
    restrictions = $null
    allow_force_pushes = $false
    allow_deletions = $false
    block_creations = $false
    required_linear_history = $true
    require_conversation_resolution = $true
    allow_fork_syncing = $true
    lock_branch = $false
  } | ConvertTo-Json -Depth 5

  $url = "$baseUrl/branches/$branch/protection"
  Invoke-RestMethod -Method Put -Uri $url -Headers $headers -ContentType 'application/json' -Body $body | Out-Null
}

Protect-Branch -branch "main"
Protect-Branch -branch "dev"

Write-Host "Branch protection configured for main and dev." -ForegroundColor Green
