class_name FlagsController extends Node

@export var hero_controller: HeroController
@export var ui_controls: UIControls

var flags_gotten: int = 0

func got_flag():
	ui_controls.got_flag()
	flags_gotten += 1;
	pass

func _ready() -> void:
	hero_controller.got_flag.connect(got_flag)
	pass
