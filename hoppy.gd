extends CharacterBody2D

var speed = 1
var current_state = "walking"
var direction = Vector2.RIGHT

func _ready():
	position = Vector2(-800, 0)
	$AnimatedSprite2D.scale = Vector2(5, 5)

func move_right():
	if current_state == "walking":
		$AnimatedSprite2D.play("right")
		position.x += speed
		if position.x >= -200 and direction == Vector2.RIGHT:
			direction = Vector2.LEFT
			$AnimatedSprite2D.flip_h = true
		elif position.x <= -800 and direction == Vector2.LEFT:
			direction = Vector2.RIGHT
			$AnimatedSprite2D.flip_h = false

func _process(_delta):
	move_right()

	if direction == Vector2.LEFT:
		speed = -1
	else:
		speed = 1


func _on_area_2d_area_entered(_area):
	pass # Replace with function body.


func _on_area_2d_area_exited(_area):
	pass # Replace with function body.
