extends RichTextLabel

func _ready() -> void:
	pass

func _process(delta) -> void:
	self.text = str(my_global.nb_goute_deau)
