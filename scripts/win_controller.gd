class_name WinController extends Node

@export var hero_controller: HeroController
@export var flags_controller: FlagsController
var amount_of_flags: int = 0

@export var black_colorrect: ColorRect
@export var confetti_anim: AnimatedSprite3D

func won_level() -> void:
	print("level won! (got all flags)")
	confetti()
	await get_tree().create_timer(2).timeout
	fadeout()
	pass

func finished_level() -> void:
	print("level finished :c")
	fadeout()
	pass

func confetti() -> void:
	confetti_anim.visible = true
	confetti_anim.play("default")
	await confetti_anim.animation_finished
	confetti_anim.visible = false

func fadeout() -> void:
	black_colorrect.color = Color8(0,0,0,0)
	var tween := create_tween()
	tween.tween_property(black_colorrect, "color", Color.BLACK, 1)
	tween.play()
	await tween.finished

func level_finish() -> void:
	if flags_controller.flags_gotten == amount_of_flags:
		won_level()
	else:
		finished_level()

func _ready() -> void:
	hero_controller.level_beat.connect(level_finish)
