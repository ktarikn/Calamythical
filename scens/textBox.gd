extends RichTextLabel

@export var Texts : Array[String]

var currentIndex :int = 0

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ProgressText") and currentIndex<Texts.size()):
		text = Texts[currentIndex]
		currentIndex += 1
