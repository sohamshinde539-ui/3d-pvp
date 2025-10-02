extends Camera3D

func _ready() -> void:
    position = Vector3(0.0, 2.0, 6.0)
    look_at(Vector3(0.0, 1.0, 0.0), Vector3.UP)
