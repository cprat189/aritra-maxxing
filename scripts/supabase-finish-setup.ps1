param(
  [Parameter(Mandatory=$true)]
  [string]$ServiceRoleKey,

  [Parameter(Mandatory=$true)]
  [string]$AritraEmail,

  [Parameter(Mandatory=$true)]
  [string]$AritraPassword,

  [Parameter(Mandatory=$true)]
  [string]$AdminPassword,

  [string]$ProjectUrl = "https://fjjhrpyszzjbdeoahvqv.supabase.co",
  [string]$AdminEmail = "pratyushch9@gmail.com"
)

$ErrorActionPreference = "Stop"

function Invoke-Supabase {
  param(
    [Parameter(Mandatory=$true)][string]$Method,
    [Parameter(Mandatory=$true)][string]$Path,
    [object]$Body = $null,
    [hashtable]$ExtraHeaders = @{}
  )

  $headers = @{
    apikey = $ServiceRoleKey
    Authorization = "Bearer $ServiceRoleKey"
  }
  foreach ($key in $ExtraHeaders.Keys) { $headers[$key] = $ExtraHeaders[$key] }

  $args = @{
    Method = $Method
    Uri = "$ProjectUrl$Path"
    Headers = $headers
  }

  if ($null -ne $Body) {
    $args.ContentType = "application/json"
    $args.Body = ($Body | ConvertTo-Json -Depth 20)
  }

  Invoke-RestMethod @args
}

function Upsert-ConfirmedUser {
  param(
    [Parameter(Mandatory=$true)][string]$Email,
    [Parameter(Mandatory=$true)][string]$Password
  )

  $users = Invoke-Supabase -Method GET -Path "/auth/v1/admin/users"
  $existing = @($users.users) | Where-Object { $_.email -eq $Email } | Select-Object -First 1

  if ($existing) {
    Invoke-Supabase -Method PUT -Path "/auth/v1/admin/users/$($existing.id)" -Body @{
      password = $Password
      email_confirm = $true
      user_metadata = @{ workspace = "aritra-maxxing" }
    } | Out-Null
    Write-Host "Confirmed and reset password for $Email"
  } else {
    Invoke-Supabase -Method POST -Path "/auth/v1/admin/users" -Body @{
      email = $Email
      password = $Password
      email_confirm = $true
      user_metadata = @{ workspace = "aritra-maxxing" }
    } | Out-Null
    Write-Host "Created confirmed user $Email"
  }
}

Upsert-ConfirmedUser -Email $AritraEmail -Password $AritraPassword
Upsert-ConfirmedUser -Email $AdminEmail -Password $AdminPassword

$indexPath = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\index.html")
$html = Get-Content -LiteralPath $indexPath -Raw
$html = $html.Replace("aritra@example.com", $AritraEmail.ToLowerInvariant())
Set-Content -LiteralPath $indexPath -Value $html -NoNewline -Encoding utf8
Write-Host "Updated index.html editorEmail"

$schemaPath = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\supabase\schema.sql")
$schema = Get-Content -LiteralPath $schemaPath -Raw
$schema = $schema.Replace("aritra@example.com", $AritraEmail.ToLowerInvariant())
Set-Content -LiteralPath $schemaPath -Value $schema -NoNewline -Encoding utf8
Write-Host "Updated supabase/schema.sql editor policies"

Write-Host ""
Write-Host "Done. After committing/pushing these files, send:"
Write-Host "Preview: https://cprat189.github.io/aritra-maxxing/?preview=1"
Write-Host "Login:   https://cprat189.github.io/aritra-maxxing/"
