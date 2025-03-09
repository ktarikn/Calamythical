extends Node2D

@onready var area_2d = $Area2D
@onready var instruction = $"../Instruction"
@onready var main_scene = $".."
@onready var yeşil = $Yeşil
@onready var sarı = $Sarı
@onready var pembe = $Pembe
@onready var lokumlar = [yeşil, sarı, pembe]

var mini_game_state = 4
var mouse_on_hand = false
var end_amount = 3
var mouse_vel
var dondurma_topları = []

func _input(_event):
	if area_2d.mini_game_on:
		match mini_game_state:
			0:
				instruction.set_text("\"Sol Tıka\" basarak lokumları yerleştir")
				if Input.is_action_just_pressed("lokum_koyma"):
					yeşil.reparent(main_scene)
					yeşil.global_position = get_global_mouse_position()
					mini_game_state += 1
			1:
				if Input.is_action_just_pressed("lokum_koyma"):
					sarı.reparent(main_scene)
					sarı.global_position = get_global_mouse_position()
					mini_game_state += 1
			2:
				if Input.is_action_just_pressed("lokum_koyma"):
					pembe.reparent(main_scene)
					pembe.global_position = get_global_mouse_position()
					mini_game_state += 1
					instruction.set_text("\"Sol Tıka\" basıp sürükleyerek lokumları yedir")
			3:
				if Input.is_action_pressed("lokum_koyma"):
					for i in lokumlar:
						var vel = Input.get_last_mouse_velocity()
						mouse_vel = sqrt(vel.x**2 + vel.y**2)
						print(i.get_child(0).mouse_on_sprite, mouse_vel)
						if i.get_child(0).mouse_on_sprite and mouse_vel > 900:
							i.smudge += 1
						if i.smudge == 20:
							i.visible = false
							i.smudge += 1
							end_amount -= 1
				if end_amount == 0:
					mini_game_state += 1
							
			4: # END STATE
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				
						
func _on_area_2d_mouse_entered():
	mouse_on_hand = true

func _on_area_2d_mouse_exited():
	mouse_on_hand = false
