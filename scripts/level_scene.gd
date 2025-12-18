class_name LevelScene extends Node2D

@export var player_speed: float = 10
@export var obstacles_speed: float = 20
@export var bounds_node: Sprite2D
var bounds: Rect2

var amount_of_flags: int = 0

func _ready() -> void:
	assert(bounds_node, "needs bounds!")
	bounds = bounds_node.get_rect();
	bounds.position += bounds_node.position
	bounds.size *= bounds_node.scale
	bounds_node.free();
	for node in get_children():
		if node as Flag:
			amount_of_flags += 1;

func get_left_boundary_start() -> Vector2:
	return Vector2(
		bounds.position.x,
		bounds.position.y,
	)

func get_left_boundary_end() -> Vector2:
	return Vector2(
		bounds.position.x,
		bounds.end.y,
	)

func get_right_boundary_start() -> Vector2:
	return Vector2(
		bounds.end.x,
		bounds.position.y,
	)

func get_right_boundary_end() -> Vector2:
	return Vector2(
		bounds.end.x,
		bounds.end.y,
	)
