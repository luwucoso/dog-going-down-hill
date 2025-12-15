class_name LevelScene extends Node2D

@export var speed: float = 1
@export var bounds_node: Sprite2D
var bounds: Rect2

func _ready() -> void:
	assert(bounds_node, "needs bounds!")
	bounds = bounds_node.get_rect().abs();
	bounds_node.free();

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
