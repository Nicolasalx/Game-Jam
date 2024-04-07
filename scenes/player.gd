extends CharacterBody2D

@export var speed = 200

func _ready():
	$Player/AnimatedSprite2D.scale = Vector2(0.5, 0.5)

func _process(_delta):
	if Input.is_action_pressed("sprint"):
		speed = 350
	else:
		speed = 200

	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Player/AnimatedSprite2D.play()
	else:
		$Player/AnimatedSprite2D.stop()

	move_and_slide()
	update_animation()

func update_animation():
	if velocity.x != 0:
		$Player/AnimatedSprite2D.animation = "right" if velocity.x > 0 else "left"
	elif velocity.y != 0:
		$Player/AnimatedSprite2D.animation = "up" if velocity.y > 0 else "down"
