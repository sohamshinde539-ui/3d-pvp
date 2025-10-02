$job = Get-Job -Name 'godot-server-3d-pvp' -ErrorAction SilentlyContinue
if ($job) {
    Stop-Job -Job $job -Force -ErrorAction SilentlyContinue
    Remove-Job -Job $job -Force -ErrorAction SilentlyContinue
    Write-Output "Stopped job: $($job.Name)"
} else {
    Write-Output "No server job found."
}
