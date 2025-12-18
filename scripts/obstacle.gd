@tool
class_name Obstacle extends Sprite2D

# template for collisions:
# {
#    "Type" = "Circle",
#    "Radius = number,
#    "offset" = Vector3,
# }

const TEMPLATES: Dictionary = {
	"Tree": {
		"texture" = preload("res://tree.png"),
		"pixelsize" = 0.023,
		"yoffset3d" = 1000,
		"yoffset2d" = -1200,
		"collision" = {
			"type" = "Circle",
			"radius" = 100.0,
			"offset" = Vector3(0, 0, 0),
		}
	},
	"Rock": {
		"texture" = preload("res://rock.png"),
		"pixelsize" = 0.005,
		"yoffset3d" = 1000,
		"yoffset2d" = -1200,
		"collision" = {
			"type" = "Circle",
			"radius" = 100.0,
			"offset" = Vector3(0, 0, 0),
		}
	},
	"Flag": {
		"texture" = preload("res://flag.png"),
		"pixelsize" = 0.05,
		"yoffset3d" = 1000,
		"yoffset2d" = -1200,
		"collision" = {
			"type" = "Circle",
			"radius" = 100.0,
			"offset" = Vector3(0, 0, 0),
		}
	}
}

@export_enum("None", "Tree", "Rock", "Flag")
var template = "None":
	set(new): template = new; template_set(new)

func template_set(new):
	if new == "None": return
	var data = TEMPLATES[new];
	texture = data["texture"]
	pixel_size_3d = data["pixelsize"]
	offset_y_3d = data["yoffset3d"]
	offset.y = data["yoffset2d"]
	if data["collision"]["type"] == "Circle":
		collision_type = "Circle"
		collision_circle_radius = data["collision"]["radius"]
		collision_offset = data["collision"]["offset"]
	pass

@export
var offset_y_3d: float = 1000

@export
var pixel_size_3d: float = 0.01

@export_enum("Circle")
var collision_type = "Circle"

@export
var collision_circle_radius = 1.0

@export
var collision_offset: Vector3

func get_collision_3d() -> Area3D:
	var shape := CollisionShape3D.new();
	
	shape.position = collision_offset
	if collision_type == "Circle":
		var sphere := SphereShape3D.new();
		sphere.radius = collision_circle_radius
		shape.shape = sphere
	
	var area3d := Area3D.new()
	area3d.add_child(shape)
	area3d.set_collision_layer_value(1, false)
	area3d.set_collision_layer_value(2, true)
	area3d.set_disable_scale(true)
	return area3d;

func get_sprite_3d() -> Sprite3D:
	var node := Sprite3D.new()
	node.texture = texture
	node.pixel_size = pixel_size_3d
	node.offset.y = offset_y_3d
	node.double_sided = false
	node.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	node.position.x = -position.y / Global.scale_modifier
	node.position.z = position.x / Global.scale_modifier
	node.add_child(get_collision_3d())
	return node
