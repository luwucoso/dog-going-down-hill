class_name ObstraclesController extends Node

@export var sizing_controller: SizingController

var speed: float = 20

var allow_movement: bool = true

var obstacles: Array[Node3D] = []

func add_obstacle(node: Node3D) -> void:
	obstacles.append(node)
	sizing_controller.add_object(node)

func x_position_to_scale(x: float) -> Vector3:
	return Vector3.ONE * (-x + 20)

func _process(delta: float) -> void:
	if not allow_movement: return
	for obstacle in obstacles:
		obstacle.position.x -= speed * delta
		if obstacle.position.x <= -6:
			obstacles.erase(obstacle)
			sizing_controller.remove_object(obstacle)
			obstacle.queue_free()
			continue
	pass
