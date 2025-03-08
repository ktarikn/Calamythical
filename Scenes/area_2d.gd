extends Area2D

var mouse_on_sprite = false

func _on_mouse_entered():
	mouse_on_sprite = true
	
func _on_mouse_exited():
	mouse_on_sprite = false
