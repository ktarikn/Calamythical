extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var el_sprite = $"../El/Sprite2D"
@onready var instruction = $"../Instruction"
@onready var bulamaç = $"../El/Sprite2D/Bulamaç"
@onready var main_scene = $".."
@onready var cpu_particles_2d = $CPUParticles2D
@onready var tarçın_alan = $"../El/TarçınAlan"
@onready var audio = $AudioStreamPlayer2D

var mini_game_state = 0
var mouse_on_hand = false
var tarçın_amount = 0
var mouse_vel

func _process(_delta):
	if area_2d.mini_game_on:
		instruction.set_text("\"Sol Tıka\" basarak aşağı salla")
		match mini_game_state:
			0:
				if Input.is_action_pressed("tarçın_dökme"):
					mouse_vel = Input.get_last_mouse_velocity()
					if mouse_vel.y > 500:
						if sprite_2d.frame == 2:
							cpu_particles_2d.emitting = true
						if not audio.playing:
							audio.pitch_scale = 0.95 + randf()*0.1
							audio.play()
						sprite_2d.play("dökülme")
						if area_2d in tarçın_alan.get_overlapping_areas():
							tarçın_amount += 0.001
					if tarçın_amount > 0.32:
						mini_game_state += 1
						audio.stop()
						sprite_2d.play("default")
				else:
					audio.play()
					sprite_2d.play("default")
			1: # END STATE
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				
						
func _on_area_2d_mouse_entered():
	mouse_on_hand = true

func _on_area_2d_mouse_exited():
	mouse_on_hand = false
