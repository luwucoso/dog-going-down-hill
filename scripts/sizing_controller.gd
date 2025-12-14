class_name SizingController extends Node

@export var x_position_scale: Curve

@export var far_plane_distance: float = 20
@export var near_plane_distance: float = -5.5


var objects_moving: Array[Node3D]

func add_object(object: Node3D) -> void:
	objects_moving.push_back(object)

func remove_object(object: Node3D) -> void:
	objects_moving.erase(object)

func _process(delta: float) -> void:
	for object in objects_moving:
		if object.position.x <= -far_plane_distance:
			object.scale = Vector3.ZERO
			continue
		if object.position.x <= near_plane_distance:
			object.scale = Vector3.ZERO
			continue
		object.scale = Vector3.ONE * x_position_scale.sample(object.position.x)
	pass
