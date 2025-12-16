extends Node

var scale_modifier = 16

const FENCE_SEPARATION: float = 3.5
const FENCE_PREFABS: Array[PackedScene] = [
	preload("res://scenes/fences/fence1.tscn"),
	preload("res://scenes/fences/fence2.tscn"),
	preload("res://scenes/fences/fence3.tscn"),
]
