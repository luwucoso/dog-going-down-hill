class_name UIControls extends Control

@export var base_knob: Control

@export var knob_box: BoxContainer

var flag_count: int = 5
var flags_got: int = 0

func got_flag() -> void:
	var knob := knob_box.get_child(flags_got)
	
	var knob_anim := knob.get_child(0) as AnimationPlayer
	knob_anim.play("drop")
	
	flags_got += 1;

func make_knobs() -> void:
	for i in range(flag_count):
		var node := base_knob.duplicate()
		knob_box.add_child(node)
	pass

func _ready() -> void:
	base_knob = base_knob.duplicate() # we make a new base knob so we can clean
	for child in knob_box.get_children():
		child.free()
	# we free the children to make space for knobs defined later
