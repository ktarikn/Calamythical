extends Area2D

var mouse_on_sprite = false
var holding_this = false
var returning = false
var mini_game_on = false
@onready var parent = get_parent()
@onready var initial_position = get_parent().position
@onready var initial_scale = get_parent().scale
@onready var masa_sınır = $"../../MasaSınır"
@onready var main_scene = $"../.."

var rand
var current_rot = 0
var clockwise = false
@export var speed:float = 0.15

func setrand(): rand = randi_range(5,10)
	
func _physics_process(delta: float) -> void:
	if not holding_this:
		if not rand:
			setrand()
		if clockwise:
			parent.rotation_degrees = parent.rotation_degrees+speed
			if(parent.rotation_degrees >= rand):
				clockwise = false
				setrand()
		else:
			parent.rotation_degrees = parent.rotation_degrees-speed
			if(parent.rotation_degrees <= -rand):
				clockwise = true
				setrand()

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
	if b:get_parent().scale = lerp(get_parent().scale, Vector2(initial_scale.x*1.3,
															   initial_scale.y*1.3), 0.2)
	else:get_parent().scale = lerp(get_parent().scale, initial_scale, 0.4)
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
