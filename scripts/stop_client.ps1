$job = Get-Job -Name 'godot-client-3d-pvp' -ErrorAction SilentlyContinue
if ($job) {
    Stop-Job -Job $job -ErrorAction SilentlyContinue
    Remove-Job -Job $job -ErrorAction SilentlyContinue
    Write-Output "Stopped job: $($job.Name)"
} else {
    Write-Output "No client job found."
}
