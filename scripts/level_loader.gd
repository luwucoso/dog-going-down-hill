class_name LevelLoader extends Node

@export var level_scene: PackedScene

@export var obstacles_controller: ObstraclesController
@export var sizing_controller: SizingController
@export var hero_controller: HeroController

@export var left_wall_collision: CollisionShape3D
@export var right_wall_collision: CollisionShape3D

func load_obstacles(from: Array[Node]):
	for template in from:
		var obstacle := template as Obstacle
		if not obstacle: continue
		var node := obstacle.get_sprite_3d()
		add_sibling.call_deferred(node)
		obstacles_controller.add_obstacle(node)

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
	make_barrier(level)
	make_fences(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
