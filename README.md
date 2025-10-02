# 3d-pvp (Godot 4)

Minimal Godot 4 project scaffold with a headless ENet server for quick previews.

## Prereqs
- Godot 4 console/headless available as `godot_headless` or `godot_server` (already set up in this shell)

## Run the headless server
```
# from repo root
./scripts/run_server.ps1 -Port 9000
```
This launches a background job named `godot-server-3d-pvp`.

## Stop the server
```
./scripts/stop_server.ps1
```

## Notes
- The server listens on `--port` (default 9000). Change via `./scripts/run_server.ps1 -Port 1234`.
- Main scene is `res://scenes/Main.tscn`. Server logic lives in `res://scripts/server.gd`.
