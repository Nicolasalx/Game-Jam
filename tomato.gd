extends Node2D

@onready var interaction_text = $InteractionText
@onready var generator_panel = $GeneratorPanel
@onready var button = $GeneratorPanel/Button
var is_close_to_generator = false

func _ready():
	interaction_text.visible = false
	generator_panel.visible = false

func _process(_delta):
	if Input.is_action_pressed("interact") and is_close_to_generator:
		generator_panel.visible = true
	elif not is_close_to_generator:
		generator_panel.visible = false

func _on_area_2d_area_entered(_area):
	interaction_text.visible = true
	is_close_to_generator = true

func _on_area_2d_area_exited(_area):
	interaction_text.visible = false
	is_close_to_generator = false


func _on_button_pressed():
	if my_global.nb_tomato < 10:
		my_global.nb_tomato += 1
