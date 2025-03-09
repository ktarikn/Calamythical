extends Area2D

var slide_amount = 260
var mouse_on_sprite = false
@onready var parent = $".."
@onready var original_position = Vector2(1167, 294)

func _ready():
	parent.global_position = lerp(parent.global_position, original_position, 0.1)

func _process(_delta):
	var pos = parent.global_position
	if mouse_on_sprite:
		parent.global_position = lerp(pos, Vector2(original_position.x-slide_amount, original_position.y), 0.2)
	else:
		parent.global_position = lerp(pos, original_position, 0.2)
		
func _on_mouse_entered():
	mouse_on_sprite = true

func _on_mouse_exited():
	mouse_on_sprite = false
