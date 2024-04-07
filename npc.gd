extends CharacterBody2D

var target_positions = [Vector2(0, 0), Vector2(700, 600)]
var current_target_index = 0
var is_close_to_generator = false
var current_state = "idle"
@onready var interaction_text = $InteractionText

var speed = 200

func _ready():
	interaction_text.visible = false
	position = Vector2(500, 800)
	$AnimatedSprite2D.scale = Vector2(0.5, 0.5)
	
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
		interaction_text.visible = true
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
		open_water_menu()

func open_water_menu():
	print("water --")
	pass
