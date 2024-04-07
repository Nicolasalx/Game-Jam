extends Area2D

@export var speed = 200

func _ready():
	$AnimatedSprite2D.scale = Vector2(0.5, 0.5)
 
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("sprint"):
		speed = 350
	else:
		speed = 200
	if my_global.nb_water <= 0:
		speed = 50
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	

	position += velocity * delta
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "right" if velocity.x > 0 else "left"
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up" if velocity.y > 0 else "down"
