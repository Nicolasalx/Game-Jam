extends Node2D

@onready var start_level = preload("res://scenes/game.tscn") as PackedScene

func _ready():
	pass

func _process(delta) -> void:
	await get_tree().create_timer(26.5).timeout
	get_tree().change_scene_to_packed(start_level)
