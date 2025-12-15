class_name LevelLoader extends Node

@export var level_scene: PackedScene

@export var obstacles_controller: ObstraclesController

@export var left_wall_collision: CollisionShape3D
@export var right_wall_collision: CollisionShape3D


func load_obstacles(from: Array[Node]):
	for template in from:
		var texture_node := template as Sprite2D
		var node := Sprite3D.new()
		node.texture = texture_node.texture
		node.pixel_size = 0.01
		node.double_sided = false
		node.offset.y = 1000
		node.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		node.position.x = -texture_node.position.y / Global.scale_modifier
		node.position.z = texture_node.position.x / Global.scale_modifier
		add_sibling.call_deferred(node)
		obstacles_controller.add_obstacle(node)

func make_barrier(level: LevelScene) -> void:
	#left_wall_collision.position.z = level.bounds.position.x / Global.scale_modifier
	#right_wall_collision.position.z = level.bounds.end.x / Global.scale_modifier
	pass

func _ready() -> void:
	var level: LevelScene = level_scene.instantiate() as LevelScene
	self.add_child(level)
	print("loading level: ", level.name)
	load_obstacles(level.get_children())
	make_barrier(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
