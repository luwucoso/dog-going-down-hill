class_name LevelLoader extends Node

@export var level_scene: PackedScene

@export var obstacles_controller: ObstraclesController


func load_obstacles(from: Array[Node]):
	for template in from:
		var texture_node := template as Sprite2D
		var node := Sprite3D.new()
		node.texture = texture_node.texture
		node.scale = Vector3.ONE * 0.37
		node.pixel_size = 0.01
		node.double_sided = false
		node.offset.y = 1000
		node.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		node.position.x = -texture_node.position.y / Global.scale_modifier
		node.position.z = texture_node.position.x / Global.scale_modifier
		add_sibling.call_deferred(node)
		obstacles_controller.add_obstacle(node)


func _ready() -> void:
	var level: Node2D = level_scene.instantiate()
	print("loading level: ", level.name)
	load_obstacles(level.get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
