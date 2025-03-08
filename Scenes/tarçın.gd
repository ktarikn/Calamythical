extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var el_sprite = $"../El/Sprite2D"
@onready var instruction = $"../Instruction"
@onready var bulamaç = $"../El/Sprite2D/Bulamaç"
@onready var main_scene = $".."
@onready var cpu_particles_2d = $CPUParticles2D
@onready var tarçın_alan = $"../El/TarçınAlan"

var mini_game_state = 1
var mouse_on_hand = false
var tarçın_amount = 0
var mouse_vel

func _input(_event):
	if area_2d.mini_game_on:
		instruction.set_text("\"Sol Tıka\" basarak aşağı salla")
		match mini_game_state:
			0:
				if Input.is_action_pressed("tarçın_dökme"):
					set_rotation_degrees(-120)
					mouse_vel = Input.get_last_mouse_velocity()
					if mouse_vel.y > 500:
						cpu_particles_2d.emitting = true
						if area_2d in tarçın_alan.get_overlapping_areas():
							tarçın_amount += 0.001
							print(tarçın_amount)
					if tarçın_amount > 0.32:
						mini_game_state += 1
				else:
					set_rotation_degrees(0)
			1: # END STATE
				set_rotation_degrees(0)
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				
						
func _on_area_2d_mouse_entered():
	mouse_on_hand = true

func _on_area_2d_mouse_exited():
	mouse_on_hand = false
