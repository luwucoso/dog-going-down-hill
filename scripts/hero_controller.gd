class_name HeroController extends Node

@export var allow_movement: bool = true

@export var player_root: Node3D
@export var sprite: Sprite3D
@export var wall_collision: Area3D
@export var hurtbox: Area3D

# emmited when the player frikin dies
signal frikin_died

@export var debug_speed: float = 1

var left_block: bool = false
var right_block: bool = false
var last_moved_direction: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wall_collision.area_entered.connect(entered_wall)
	wall_collision.area_exited.connect(exited_wall)
	hurtbox.area_entered.connect(hurtbox_touched)
	pass  # Replace with function body.

func hurtbox_touched(_other: Area3D) -> void:
	frikin_died.emit()
	pass

func entered_wall(_other: Area3D) -> void:
	if last_moved_direction == -1:
		left_block = true
	if last_moved_direction == 1:
		right_block = true
	if last_moved_direction == 0:
		assert(false, "have to handle this!")
	pass

func exited_wall(_other: Area3D) -> void:
	left_block = false
	right_block = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not allow_movement:
		return
	
	var movement_axis := Input.get_axis("move_left", "move_right")
	
	if movement_axis == -1 && left_block:
		return
	if movement_axis == 1 && right_block:
		return
	last_moved_direction = movement_axis

	player_root.position.z += movement_axis * debug_speed * delta
	pass
