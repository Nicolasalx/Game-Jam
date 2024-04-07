extends ProgressBar

@onready var healthBar = $HealthBar

var health: int = 100
var time_passed: float = 0
var update_interval: float = 2.0

func _ready():
	value = my_global.nb_water

func _process(delta):
	time_passed += delta
	if time_passed >= update_interval && value > 0:
		time_passed = 0
		value -= 1
	my_global.nb_water = value
