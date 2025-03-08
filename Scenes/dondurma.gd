extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var el_sprite = $"../El/Sprite2D"
@onready var instruction = $"../Instruction"
@onready var main_scene = $".."

var mini_game_state = 0
var mouse_on_hand = false
var end_amount = 20
var mouse_vel
var dondurma_topları = []

func _input(_event):
	if area_2d.mini_game_on:
		match mini_game_state:
			0:
				instruction.set_text("\"Sol Tıka\" basarak dondurmayı koy")
				if Input.is_action_just_pressed("dondurma_koyma"):
					var dondurma_topu = preload("res://Scenes/dondurma_topu.tscn").instantiate()
					main_scene.add_child(dondurma_topu)
					dondurma_topu.global_position = get_global_mouse_position()
					dondurma_topları.append(dondurma_topu)
					
					if len(dondurma_topları) == 3:
						instruction.set_text("\"Sol Tıka\" basılı tutarken \"B\"ye aban.")
						mini_game_state += 1
						self.visible = false
			1, 2, 3:
				if Input.is_action_pressed("dondurma_bulama"):
					for i in dondurma_topları:
						var dondurma_sprite = i.get_child(0)
						var dondurma_area = i.get_child(1)
						if dondurma_area.mouse_on_sprite:
							if Input.is_action_just_pressed("dondurma_bulama_spam"):
								i.splash_counter -= 1
							if i.splash_counter == 0:
								i.splash_counter -= 1
								dondurma_sprite.texture = load("res://Assets/MiniGames/Dondurma/ezilmiş_top.png")
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
