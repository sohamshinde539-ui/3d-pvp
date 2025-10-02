param([int]$Port = 9000)
$ErrorActionPreference = "Stop"
$root = (Split-Path -Parent $MyInvocation.MyCommand.Path) | Split-Path -Parent
Start-Job -Name 'godot-server-3d-pvp' -ScriptBlock {
    param($Root, $Port)
    Set-Location $Root
    godot_headless --path . -- --port=$Port
} -ArgumentList $root, $Port | Out-Null
Start-Sleep -Seconds 2
Get-Job -Name 'godot-server-3d-pvp' | Select-Object Id, Name, State
