extends RayCast3D

@onready var rich_text_label: RichTextLabel = $"../RichTextLabel"

var grabbableObject:Node3D

func _process(delta: float):
	if is_colliding():
		var hit_object = get_collider()
		if(hit_object and hit_object.has_meta("grabbable")):
			print(hit_object)
			print(Time.get_unix_time_from_system())
			grabbableObject =hit_object
			rich_text_label.visible=true
		else:
			grabbableObject =null
			rich_text_label.visible=false
	else:
			grabbableObject =null
			rich_text_label.visible=false
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("interact") and grabbableObject):
		grabbableObject.queue_free()
		grab(grabbableObject)
		
func grab(object:Node3D):
	pass
