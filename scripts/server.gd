extends Node

@export var port: int = 9000
@export var max_clients: int = 32

func _ready():
    # Parse command-line args like --port=1234
    for a in OS.get_cmdline_args():
        if a.begins_with("--port="):
            port = int(a.substr(7))
    var is_headless := (DisplayServer.get_name() == "headless") or OS.has_feature("headless") or OS.has_feature("server")
    if is_headless:
        print("[Server] Starting headless server on port %d" % port)
        var peer := ENetMultiplayerPeer.new()
        var err := peer.create_server(port, max_clients)
        if err != OK:
            push_error("[Server] Failed to start server: %s" % err)
            get_tree().quit(1)
            return
        var mp = get_tree().get_multiplayer()
        mp.multiplayer_peer = peer
        mp.peer_connected.connect(_on_peer_connected)
        mp.peer_disconnected.connect(_on_peer_disconnected)
        print("[Server] Initialized. Waiting for clients...")
    else:
        print("[Server] Not running headless; server not started.")

func _on_peer_connected(id: int) -> void:
    print("[Server] Peer connected: %s" % id)

func _on_peer_disconnected(id: int) -> void:
    print("[Server] Peer disconnected: %s" % id)
