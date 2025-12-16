@tool
class_name Obstacle extends Sprite2D

const TEMPLATES: Dictionary = {
	"Tree": {
		"texture" = preload("res://tree.png"),
		"pixelsize" = 0.023,
		"yoffset3d" = 1000,
		"yoffset2d" = -1200,
	}
}

@export_enum("None", "Tree", "Rock")
var template = "None":
	set(new): template = new; template_set(new)

func template_set(new):
	if new == "None": return
	var data = TEMPLATES[new];
	texture = data["texture"]
	pixel_size_3d = data["pixelsize"]
	offset_y_3d = data["yoffset3d"]
	offset.y = data["yoffset2d"]
	pass

@export
var offset_y_3d: float = 1000

@export
var pixel_size_3d: float = 0.01

func get_sprite_3d() -> Sprite3D:
	var node := Sprite3D.new()
	node.texture = texture
	node.pixel_size = pixel_size_3d
	node.offset.y = offset_y_3d
	node.double_sided = false
	node.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	node.position.x = -position.y / Global.scale_modifier
	node.position.z = position.x / Global.scale_modifier
	return node
