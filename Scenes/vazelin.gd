extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var el_sprite = $"../El/Sprite2D"
@onready var instruction = $"../Instruction"
@onready var bulamaç = $"../El/Sprite2D/Bulamaç"
@onready var main_scene = $".."
@onready var initial_scale = sprite_2d.scale

var mini_game_state = 3 # Vazelini açmak
var mouse_on_hand = false
var bulamaç_amount = 0
var mouse_vel

func _input(event):
	if area_2d.mini_game_on:
		match mini_game_state:
			0:
				if event is InputEventKey and event.keycode == KEY_E:
					sprite_2d.texture = load("res://Assets/MiniGames/Vazelin/vazelin_açık.png")
					instruction.set_text("Bulamaç almak için \"Sol Tık\"")
					mini_game_state += 1
			1:
				if event is InputEventMouseButton and event.pressed:
					sprite_2d.texture = load("res://Assets/MiniGames/Vazelin/bulamaç.png")
					instruction.set_text("Bölgeye uygula \"B'ye basılı tutarken sür\"")
					mini_game_state += 1
			2:
				if Input.is_action_pressed("vazelin_bulama"):
					var end_amount = 0.5
					if mouse_on_hand:
						mouse_vel = Input.get_last_mouse_velocity()
						mouse_vel = sqrt(mouse_vel.x**2 + mouse_vel.y**2)
						if mouse_vel < 300:
							instruction.set_text("TOO SLOW")
						elif mouse_vel > 800:
							instruction.set_text("TOO FAST")
						else:
							bulamaç_amount += 0.001
							var ratio = (end_amount - bulamaç_amount)/end_amount
							bulamaç.scale = Vector2(bulamaç_amount, bulamaç_amount)
							sprite_2d.scale = Vector2(initial_scale[0]*ratio, initial_scale[1]*ratio)
							instruction.set_text("MÜKEMMEL!!")
						if bulamaç_amount > end_amount:
							mini_game_state += 1
				else:
					instruction.set_text("Bölgeye uygula \"B'ye basılı tutarken sür\"")
			3: # END STATE
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				
						
func _on_area_2d_mouse_entered():
	mouse_on_hand = true

func _on_area_2d_mouse_exited():
	mouse_on_hand = false
