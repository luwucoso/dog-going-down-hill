class_name ObstraclesController extends Node

var obstacles: Array[Node3D] = []

@export var x_position_scale: Curve

@export var far_plane_distance: float = 20


func add_obstacle(node: Node3D) -> void:
	obstacles.append(node)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


func x_position_to_scale(x: float) -> Vector3:
	return Vector3.ONE * (-x + 20)


func _process(delta: float) -> void:
	for obstacle in obstacles:
		obstacle.position.x -= 20 * delta
		if obstacle.position.x <= -far_plane_distance:
			obstacle.scale = Vector3.ZERO
			continue
		if obstacle.position.x <= -5.5:
			obstacle.scale = Vector3.ZERO
			obstacles.erase(obstacle)
			continue
		obstacle.scale = Vector3.ONE * x_position_scale.sample(obstacle.position.x)
	pass
