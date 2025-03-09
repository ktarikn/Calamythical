extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D
@onready var el_sprite = $"../El/Sprite2D"
@onready var instruction = $"../Instruction"
@onready var bulamaç = $"../El/Sprite2D/Bulamaç"
@onready var main_scene = $".."

var mini_game_state = 0
var mouse_on_hand = false
var end_goal = 3
var baklava_amount = 0

func _input(_event):
	if area_2d.mini_game_on:
		instruction.set_text("\"Sol Tıkla\" basarak baklavaları yapıştır")
		match mini_game_state:
			0:
				if Input.is_action_just_pressed("baklava_koyma") and mouse_on_hand:
					var baklava_üst = sprite_2d.get_child(1)
					baklava_üst.visible = false
					var baklava_sprite = Sprite2D.new()
					baklava_sprite.texture = load("res://Assets/MiniGames/Baklava/Baklava a ust.png")
					baklava_sprite.global_position = get_global_mouse_position() + Vector2(-550, -300)
					el_sprite.add_child(baklava_sprite)
					mini_game_state += 1
			1:
				if Input.is_action_just_pressed("baklava_koyma") and mouse_on_hand:
					var baklava_orta = sprite_2d.get_child(0)
					baklava_orta.visible = false
					var baklava_sprite = Sprite2D.new()
					baklava_sprite.texture = load("res://Assets/MiniGames/Baklava/Baklava a orta.png")
					baklava_sprite.global_position = get_global_mouse_position() + Vector2(-550, -300)
					el_sprite.add_child(baklava_sprite)
					mini_game_state += 1
			2:
				if Input.is_action_just_pressed("baklava_koyma") and mouse_on_hand:
					self.visible = false
					var baklava_sprite = Sprite2D.new()
					baklava_sprite.texture = load("res://Assets/MiniGames/Baklava/Baklava a alt.png")
					baklava_sprite.global_position = get_global_mouse_position() + Vector2(-550, -300)
					el_sprite.add_child(baklava_sprite)
					mini_game_state += 1
			3: # END STATE
				area_2d.set_holding(false)
				area_2d.returning = true
				area_2d.mini_game_on = false
				main_scene.treatment_order.pop_front()
				
						
func _on_area_2d_mouse_entered():
	mouse_on_hand = true

func _on_area_2d_mouse_exited():
	mouse_on_hand = false
