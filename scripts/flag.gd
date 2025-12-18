@tool
class_name Flag extends Node2D

func get_3d() -> Node3D:
	var sprite := AnimatedSprite3D.new()
	sprite.sprite_frames = preload("res://krita/flag/frames.tres")
	sprite.offset = Vector2(250, 600)
	sprite.pixel_size = 0.025
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	
	var shape := CollisionShape3D.new();
	
	shape.position = Vector3(0, 10, 0)
	var sphere := SphereShape3D.new();
	sphere.radius = 10
	shape.shape = sphere
	
	var area3d := Area3D.new()
	area3d.add_child(shape)
	area3d.set_collision_layer_value(1, false)
	area3d.set_collision_layer_value(3, true)
	area3d.set_disable_scale(true)
	
	var node := Node3D.new()
	node.position.x = -position.y / Global.scale_modifier
	node.position.z = position.x / Global.scale_modifier
	node.add_child(sprite)
	return node

func make_pretty() -> void:
	var sprite = Sprite2D.new()
	sprite.texture = preload("res://krita/flag/frame0000.png")
	sprite.scale = Vector2.ONE * 0.1
	sprite.offset = Vector2(270, -600)
	add_child(sprite)
	pass

func _ready() -> void:
	if Engine.is_editor_hint():
		make_pretty()
