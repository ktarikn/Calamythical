extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var instruction = $"../Instruction"
@onready var main_scene = $".."
@onready var initial_scale = sprite_2d.scale
@onready var cpu_particles_2d = $CPUParticles2D

var mini_game_state = 0
var limon_amount = 0

func _input(event):
	if area_2d.mini_game_on:
		instruction.set_text("Limonu sıkmak için sol tıka basılı tutarken s spamle")
		match mini_game_state:
			0:
				if Input.is_action_pressed("limon_sıkma") and Input.is_action_just_pressed("limon_sıkma_spam"):
					limon_amount += 1
					cpu_particles_2d.emitting = true
					if limon_amount == 50:
						mini_game_state += 1
			1: # END STATE
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
