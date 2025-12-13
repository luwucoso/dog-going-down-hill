class_name HeroController extends Node

@export var allow_movement: bool = true

@export var sprite: Sprite3D

@export var debug_speed: float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not allow_movement:
		return

	var movement_axis := Input.get_axis("move_left", "move_right")

	sprite.position.z += movement_axis * (1 / debug_speed)
	pass
