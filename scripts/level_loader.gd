class_name LevelLoader extends Node

@export var level_scene: PackedScene

@export var obstacles_controller: ObstraclesController
@export var sizing_controller: SizingController
@export var hero_controller: HeroController
@export var ui_controls: UIControls

@export var left_wall_collision: CollisionShape3D
@export var right_wall_collision: CollisionShape3D

func load_flags(from: Array[Node]):
	for template in from:
		var flag := template as Flag
		if not flag: continue
		var node := flag.get_3d()
		add_sibling.call_deferred(node)
		obstacles_controller.add_obstacle(node)

func load_obstacles(from: Array[Node]):
	for template in from:
		var obstacle := template as Obstacle
		if not obstacle: continue
		var node := obstacle.get_sprite_3d()
		add_sibling.call_deferred(node)
		obstacles_controller.add_obstacle(node)

func make_ending_tape(level: LevelScene) -> void:
	const tape_separation: float = 6.14
	
	var tape_nodes := Node3D.new()
	tape_nodes.name = "endingtapes"
	var x_pos: float = level.bounds.position.y / Global.scale_modifier
	var start_z: float = level.bounds.position.x / Global.scale_modifier
	start_z -= 6 # a little margin helps the medicine go down
	var size_z: float = level.bounds.size.x / Global.scale_modifier
	size_z += 6 # same
	var current_size: float = 0
	while (current_size < size_z):
		var node := Sprite3D.new()
		node.texture = preload("res://krita/endingtape/endingtape.png")
		node.axis = Vector3.AXIS_X
		node.pixel_size = 0.0155
		node.offset.y = 1000
		node.position.x = -x_pos
		node.position.z = start_z + current_size + tape_separation 
		tape_nodes.add_child(node)
		obstacles_controller.add_obstacle(node)
		current_size += tape_separation
	
	add_sibling.call_deferred(tape_nodes)

func make_barrier(level: LevelScene) -> void:
	left_wall_collision.position.z = level.bounds.position.x / Global.scale_modifier
	right_wall_collision.position.z = level.bounds.end.x / Global.scale_modifier

func make_fences(level: LevelScene) -> void:
	var fences_node := Node3D.new()
	fences_node.name = "fences"
	# left side:
	var left_z_pos: float = level.bounds.position.x / Global.scale_modifier
	var left_start: float = level.bounds.end.y / Global.scale_modifier
	var left_size: float = level.bounds.size.y / Global.scale_modifier
	var left_current_size := 0.0
	while (left_current_size < left_size):
		var prefab: PackedScene = Global.FENCE_PREFABS.pick_random();
		var fence: Sprite3D = prefab.instantiate()
		fence.flip_h = randi_range(0, 1) == 0
		fence.flip_v = randi_range(0, 1) == 0
		fence.position.z = left_z_pos
		fence.position.x = left_start + left_current_size + Global.FENCE_SEPARATION
		left_current_size += Global.FENCE_SEPARATION
		obstacles_controller.add_obstacle(fence)
		fences_node.add_child(fence)
		pass
	var right_z_pos: float = level.bounds.end.x / Global.scale_modifier
	var right_start: float = level.bounds.end.y / Global.scale_modifier
	var right_size: float = level.bounds.size.y / Global.scale_modifier
	var right_current_size := 0.0
	while (right_current_size < right_size):
		var prefab: PackedScene = Global.FENCE_PREFABS.pick_random();
		var fence: Sprite3D = prefab.instantiate()
		fence.flip_h = randi_range(0, 1) == 0
		fence.flip_v = randi_range(0, 1) == 0
		fence.position.z = right_z_pos
		fence.position.x = right_start + right_current_size + Global.FENCE_SEPARATION
		right_current_size += Global.FENCE_SEPARATION
		obstacles_controller.add_obstacle(fence)
		fences_node.add_child(fence)
		pass
	add_sibling.call_deferred(fences_node)
	pass

func _ready() -> void:
	var level: LevelScene = level_scene.instantiate() as LevelScene
	self.add_child(level)
	print("loading level: ", level.name)
	hero_controller.speed = level.player_speed
	obstacles_controller.speed = level.obstacles_speed
	load_obstacles(level.get_children())
	load_flags(level.get_children())
	make_barrier(level)
	make_fences(level)
	make_ending_tape(level)
	ui_controls.flag_count = level.amount_of_flags
	ui_controls.flags_got = 0
	ui_controls.make_knobs()
