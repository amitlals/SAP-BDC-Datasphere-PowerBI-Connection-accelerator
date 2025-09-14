Param(
  [Parameter(Mandatory=$true)][string]$Url,
  [string]$OutDir = "$PSScriptRoot/../docs/images",
  [switch]$Overwrite
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }

Write-Host "🌐 Fetching" $Url

try {
  $resp = Invoke-WebRequest -UseBasicParsing -Uri $Url
} catch {
  Write-Error "Failed to fetch URL: $($_.Exception.Message)"
  exit 1
}

$content = $resp.Content
$regex = '<img[^>]*src=["\']([^"\']+)["\']'
$matches = [System.Text.RegularExpressions.Regex]::Matches($content, $regex)
$hashset = New-Object System.Collections.Generic.HashSet[string]
$baseUri = [System.Uri]$Url

$downloaded = @()
foreach ($m in $matches) {
  $src = $m.Groups[1].Value
  if ($src -match '^data:') { continue }
  try {
    if ($src -notmatch '^https?://') {
      $src = [System.Uri]::new($baseUri, $src).AbsoluteUri
    }
  } catch { continue }
  [void]$hashset.Add($src)
}

if ($hashset.Count -eq 0) {
  Write-Warning "No <img> sources found or page is dynamic/auth-protected."
  exit 0
}

foreach ($src in $hashset) {
  try {
    $u = [System.Uri]$src
    $name = [System.IO.Path]::GetFileName($u.LocalPath)
    if (-not $name) { $name = (Get-Random -Minimum 10000 -Maximum 99999).ToString() + '.png' }
    $dest = Join-Path $OutDir $name
    if ((Test-Path $dest) -and -not $Overwrite) {
      Write-Host "⚠️  Exists, skip:" $name
      continue
    }
    Invoke-WebRequest -UseBasicParsing -Uri $src -OutFile $dest
    Write-Host "✅ Downloaded:" $name
    $downloaded += $dest
  } catch {
    Write-Warning "Failed to download $src: $($_.Exception.Message)"
  }
}

Write-Host "📁 Saved to" (Resolve-Path $OutDir)
Write-Host ("Total downloaded: {0}" -f $downloaded.Count)

