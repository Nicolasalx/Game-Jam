extends Node2D

@onready var interaction_text = $InteractionText
@onready var generator_panel = $GeneratorPanel
@onready var progresse_bar = $GeneratorPanel/WaterIcon/MiningBar
@onready var progresse_bar_extern = $WaterIcon/MiningBar
@onready var text_nb_water = $GeneratorPanel/NbWater
var is_close_to_generator = false
var generate_water = false
var available_water = 0

func _ready():
	interaction_text.visible = false
	generator_panel.visible = false
	progresse_bar.value = 0
	progresse_bar_extern.get_parent().visible = false
	text_nb_water.text = str(available_water)

func _process(_delta):
	if Input.is_action_pressed("interact") and is_close_to_generator:
		generator_panel.visible = true
	elif not is_close_to_generator:
		generator_panel.visible = false
	if generate_water:
		progresse_bar.value += 0.05
		if progresse_bar.value >= 100:
			progresse_bar.value = 0
			available_water += 10
			text_nb_water.text = str(available_water)
	progresse_bar_extern.value = progresse_bar.value
	progresse_bar_extern.get_parent().visible = generate_water

func _on_area_2d_area_entered(_area):
	interaction_text.visible = true
	is_close_to_generator = true

func _on_area_2d_area_exited(_area):
	interaction_text.visible = false
	is_close_to_generator = false

func _on_check_button_toggled(toggled_on):
	generate_water = toggled_on

func _on_button_pressed():
	my_global.nb_water += available_water
