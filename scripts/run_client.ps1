param(
  [string]$ServerHost = "127.0.0.1",
  [int]$Port = 9000,
  [switch]$Headless
)
$ErrorActionPreference = "Stop"
$root = (Split-Path -Parent $MyInvocation.MyCommand.Path) | Split-Path -Parent
$useHeadless = $true
if ($PSBoundParameters.ContainsKey('Headless')) { $useHeadless = [bool]$Headless }

$scriptBlock = {
    param($Root, $SrvHost, $Port, $UseHeadless)
    Set-Location $Root
    $env:GODOT_FORCE_CLIENT = '1'
    $pkgRoot = Join-Path $env:LOCALAPPDATA 'Microsoft\\WinGet\\Packages'
    $godotPkg = Get-ChildItem -Path $pkgRoot -Filter 'GodotEngine.GodotEngine*' -Directory -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $godotPkg) { throw 'Godot package folder not found' }
    $console = Get-ChildItem -Path $godotPkg.FullName -Filter '*_console.exe' -File -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $console) { throw 'Godot console binary not found' }
    if ($UseHeadless) {
      & $console.FullName --headless --display-driver headless --path . -- --client --host=$SrvHost --port=$Port
    } else {
      & $console.FullName --path . -- --client --host=$SrvHost --port=$Port
    }
}

Start-Job -Name 'godot-client-3d-pvp' -ScriptBlock $scriptBlock -ArgumentList $root, $ServerHost, $Port, $useHeadless | Out-Null
Start-Sleep -Seconds 2
Get-Job -Name 'godot-client-3d-pvp' | Select-Object Id, Name, State