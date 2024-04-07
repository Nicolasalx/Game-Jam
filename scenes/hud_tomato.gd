extends RichTextLabel

func _ready() -> void:
	pass

func _process(_delta) -> void:
	self.text = str(my_global.nb_tomato)
