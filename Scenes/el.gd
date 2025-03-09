extends Node2D

@onready var original_position = Vector2(-139, -2)

var rand
@export var speed:float = 0.2
var clockwise = 0
var is_placed = false
func setrand(): rand = randi_range(8,17)
	
func _physics_process(delta: float) -> void:
	if not rand:
		setrand()
	if clockwise:
		global_position += Vector2(0, speed)
		if(global_position.y >= original_position.y + rand):
			clockwise = false
			setrand()
	else:
		global_position -= Vector2(0, speed)
		if(global_position.y <= original_position.y - rand):
			clockwise = true
			setrand()

func _process(_delta):
	if not is_placed:
		global_position = lerp(global_position, original_position, 0.1)
		if abs(global_position.y - original_position.y) < 10: is_placed = true
