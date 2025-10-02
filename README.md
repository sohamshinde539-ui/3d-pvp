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

## Run a headless client (connects to localhost:9000)
```
./scripts/run_client.ps1 -Host 127.0.0.1 -Port 9000 -Headless
```
This launches a background job named `godot-client-3d-pvp`.

## View logs
```
# server
Receive-Job -Name 'godot-server-3d-pvp' -Keep | Select-Object -Last 50
# client
Receive-Job -Name 'godot-client-3d-pvp' -Keep | Select-Object -Last 50
```

## Stop the server or client
```
./scripts/stop_server.ps1
./scripts/stop_client.ps1
```

## Notes
- The server listens on `--port` (default 9000). Change via `./scripts/run_server.ps1 -Port 1234`.
- Client mode is built into `scripts/server.gd` (pass `--client` and optional `--host`, `--port`).
- Main scene is `res://scenes/Main.tscn`. Logic lives in `res://scripts/server.gd`.

## Web preview (GitHub Pages)
- On every push to `main`, GitHub Actions will export a Web build and deploy it to GitHub Pages.
- After the first run completes, your preview will be available at:
  - https://sohamshinde539-ui.github.io/3d-pvp/
