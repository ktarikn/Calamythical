extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var el_sprite = $"../El/Sprite2D"
@onready var instruction = $"../Instruction"
@onready var bulamaç = $"../El/Sprite2D/Bulamaç"
@onready var main_scene = $".."
@onready var audio = $AudioStreamPlayer2D
@onready var initial_scale = sprite_2d.scale
@onready var kremasyon = $"../El/kremasyon"
@onready var audio2 = $AudioStreamPlayer2D2

var mini_game_state = 0
var mouse_on_hand = false
var bulamaç_amount = 0.0
var mouse_vel

func _process(_delta):
	if area_2d.mini_game_on:
		match mini_game_state:
			0:
				if Input.is_action_just_pressed("inp_e_button"):
					sprite_2d.play()
					audio.play()
					instruction.set_text("Bölgeye uygula \"B'ye basılı tutarken sür\"")
					mini_game_state += 1
			1:
				if sprite_2d.frame == 6:
					sprite_2d.stop()
					sprite_2d.frame = 6
				if Input.is_action_pressed("vazelin_bulama"):
					var end_amount = 500.0
					if mouse_on_hand:
						if not audio2.playing:
							audio2.play()
						mouse_vel = Input.get_last_mouse_velocity()
						mouse_vel = sqrt(mouse_vel.x**2 + mouse_vel.y**2)
						if mouse_vel < 300:
							instruction.set_text("TOO SLOW")
						elif mouse_vel > 800:
							instruction.set_text("TOO FAST")
						else:
							kremasyon.visible = true
							bulamaç_amount += 1.0
							var ratio = (end_amount - bulamaç_amount)/end_amount
							kremasyon.frame = int((1-ratio)*5)
							instruction.set_text("MÜKEMMEL!!")
						if bulamaç_amount > end_amount:
							mini_game_state += 1
				else:
					audio2.stop()
					instruction.set_text("Bölgeye uygula \"B'ye basılı tutarken sür\"")
			2: # END STATE
				audio2.stop()
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				
						
func _on_area_2d_mouse_entered():
	mouse_on_hand = true

func _on_area_2d_mouse_exited():
	mouse_on_hand = false
