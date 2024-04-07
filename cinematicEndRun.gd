extends Sprite2D

func _ready():
	$AnimationPlayer.play("run")
	await get_tree().create_timer(30).timeout
	get_tree().quit()
