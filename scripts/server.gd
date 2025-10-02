extends Node

@export var port: int = 9000
@export var max_clients: int = 32
@export var host: String = "127.0.0.1"
var client_mode: bool = false

func _ready():
    # Parse command-line args like --port=1234, --host=1.2.3.4, --client
    for a in OS.get_cmdline_args():
        if a.begins_with("--port="):
            port = int(a.substr(7))
        elif a.begins_with("--host="):
            host = a.substr(7)
        elif a == "--client":
            client_mode = true
    var is_headless := (DisplayServer.get_name() == "headless") or OS.has_feature("headless") or OS.has_feature("server")
    if client_mode:
        _start_client()
    elif is_headless:
        _start_server()
    else:
        print("[Info] Not headless and no --client flag; idle.")

func _start_server() -> void:
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

func _start_client() -> void:
    print("[Client] Connecting to %s:%d" % [host, port])
    var peer := ENetMultiplayerPeer.new()
    var err := peer.create_client(host, port)
    if err != OK:
        push_error("[Client] Failed to create client peer: %s" % err)
        get_tree().quit(1)
        return
    var mp = get_tree().get_multiplayer()
    mp.multiplayer_peer = peer
    mp.connected_to_server.connect(_on_connected_to_server)
    mp.connection_failed.connect(_on_connection_failed)
    mp.server_disconnected.connect(_on_server_disconnected)

func _on_peer_connected(id: int) -> void:
    print("[Server] Peer connected: %s" % id)

func _on_peer_disconnected(id: int) -> void:
    print("[Server] Peer disconnected: %s" % id)

func _on_connected_to_server() -> void:
    var mp = get_tree().get_multiplayer()
    print("[Client] Connected. My id: %s" % mp.get_unique_id())

func _on_connection_failed() -> void:
    print("[Client] Connection failed.")
    get_tree().quit(2)

func _on_server_disconnected() -> void:
    print("[Client] Server disconnected.")
    get_tree().quit(0)
