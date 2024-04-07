extends CharacterBody2D

@onready var end_cinematic = preload("res://cinematic_end.tscn") as PackedScene

var target_positions = [Vector2(0, 0), Vector2(700, 600)]
var current_target_index = 0
var current_state = "idle"
@onready var interaction_text1 = $InteractionText
@onready var interaction_text2 = $InteractionText2
@onready var interaction_text3 = $InteractionText3


var speed = 200

func _ready():
	interaction_text1.visible = false
	interaction_text2.visible = false
	interaction_text3.visible = false
	position = Vector2(500, 800)
	$AnimatedSprite2D.scale = Vector2(2.5, 2.5)
	
	current_state = "walking"
	set_process_input(true)

func _process(delta):
	if current_state == "walking":
		move_towards_target(delta)

func move_towards_target(delta):
	var direction = (target_positions[current_target_index] - position).normalized()
	var velocity = direction * speed * delta
	position += velocity
	
	if position.distance_to(target_positions[current_target_index]) < 5:
		velocity = Vector2.ZERO
		current_state = "idle"
		set_idle_timer()
		
	if current_state == "idle":
		$AnimatedSprite2D.animation = "idle"
		
	if velocity.length() == 0:
		$AnimatedSprite2D.stop()
	else:
		$AnimatedSprite2D.play()
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "right" if velocity.x > 0 else "left"
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "down" if velocity.y > 0 else "up"

func set_idle_timer():
	$Timer.start()

func _on_Timer_timeout():
	current_state = "walking"

func _input(event):
	if event is InputEventKey and event.is_action_pressed("interact"):
		if my_global.mission == 0:
			if my_global.nb_tomato >= 5:
				my_global.nb_tomato -= 5
				my_global.mission = 1
				print("c'est bon")
		elif my_global.mission == 1:
			if my_global.nb_goute_deau >= 10:
				my_global.nb_goute_deau -= 10
				my_global.mission = 2
				print("c'est bon 2")

func _on_area_2d_area_entered(_area):
	match my_global.mission:
		0:
			interaction_text1.visible = true
			interaction_text2.visible = false
			interaction_text3.visible = false
		1:
			interaction_text1.visible = false
			interaction_text2.visible = true
			interaction_text3.visible = false
		2:
			interaction_text1.visible = false
			interaction_text2.visible = false
			interaction_text3.visible = true
			get_tree().change_scene_to_packed(end_cinematic)

func _on_area_2d_area_exited(_area):
	interaction_text1.visible = false
	interaction_text2.visible = false
	interaction_text3.visible = false

func _on_button_pressed():
	pass
