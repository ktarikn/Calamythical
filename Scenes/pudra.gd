extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var instruction = $"../Instruction"
@onready var bulamaç = $"../El/Sprite2D/Bulamaç"
@onready var cpu_particles_2d = $CPUParticles2D

var mini_game_state = 1
var pudra_amount = 0
var mouse_vel

func _input(_event):
	if area_2d.mini_game_on:
		instruction.set_text("\"Sol Tıka\" basarak aşağı salla")
		sprite_2d.texture = load("res://Assets/MiniGames/PudraŞekeri/pudra_kaşık.png")
		match mini_game_state:
			0:
				if Input.is_action_pressed("pudra_dökme"):
					mouse_vel = Input.get_last_mouse_velocity()
					if mouse_vel.x > 500:
						cpu_particles_2d.emitting = true
						pudra_amount += 1
					if pudra_amount == 250:
						mini_game_state += 1
			1: # END STATE
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				self.visible = false
				
