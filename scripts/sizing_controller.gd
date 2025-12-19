class_name SizingController extends Node

@export var player_center: Node3D
@export var x_position_scale: Curve
@export var z_position_scale: Curve

@export var far_plane_distance: float = 20
@export var near_plane_distance: float = -5.5


var objects_moving: Array[Node3D]

func add_object(object: Node3D) -> void:
	objects_moving.push_back(object)

func remove_object(object: Node3D) -> void:
	objects_moving.erase(object)

func _physics_process(_delta: float) -> void:
	for object in objects_moving:
		object.show()
		if object.position.x <= -far_plane_distance:
			object.hide()
			continue
		if object.position.x <= near_plane_distance:
			object.hide()
			continue
		var new_scale = Vector3.ONE * x_position_scale.sample(
			object.position.x + z_position_scale.sample(object.position.z - player_center.position.z)
		)
		if new_scale.is_zero_approx():
			object.scale = Vector3.ONE
			object.hide()
		else:
			object.scale = new_scale
	pass
