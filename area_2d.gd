extends Area2D

var mouse_on_sprite = false
var holding_this = false
var returning = false
var mini_game_on = false
@onready var initial_position = get_parent().position
@onready var masa_sınır = $"../../MasaSınır"
@onready var main_scene = $"../.."

func _process(_delta):
	if mini_game_on:
		set_holding(true)
	if returning:
		get_parent().position = lerp(get_parent().position, initial_position, 0.2)
		if get_parent().position.distance_to(initial_position) < 5:
			returning = false
	elif holding_this:
		if self in masa_sınır.get_overlapping_areas() and not mini_game_on:
			if get_parent() != main_scene.treatment_order[0]:
				set_holding(false)
				returning = true
			else:
				mini_game_on = true
		else:
			get_parent().position = lerp(get_parent().position, get_global_mouse_position(), 0.2)

func set_holding(b : bool):
	Global.holding_anything = b
	holding_this = b
	get_parent().z_index = int(b)

func _on_mouse_entered():
	mouse_on_sprite = true

func _on_mouse_exited():
	mouse_on_sprite = false

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if mouse_on_sprite and not Global.holding_anything:
			set_holding(true)
		elif holding_this and not mini_game_on:
			set_holding(false)
