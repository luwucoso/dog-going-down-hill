class_name DeathController extends Node

@export
var hero_controller: HeroController

@export var obstacle_controller: ObstraclesController

@export
var animation: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hero_controller.frikin_died.connect(on_death)
	pass # Replace with function body.

func on_death() -> void:
	hero_controller.allow_movement = false
	obstacle_controller.allow_movement = false
	animation.play("diediedie")
	pass
