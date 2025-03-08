extends RigidBody3D



@export var path: Array[Node3D]
var index = 0
@export var speed:float
@export var rotate_speed:float

var destination :Vector3
var moving = false


func _input(event):
	if(event.is_action_pressed("tempButton")):
		move_to_next()

func move_to_next():
	if(index> path.size()):
		return
	destination = path[index].position
	index+= 1
	moving = true

func _physics_process(delta: float) -> void:
	
	if(moving):
		
		
		self.linear_velocity = (destination-self.position).normalized()*speed
		var target_transform = global_transform.looking_at((destination-self.position).normalized())
		
		global_transform = global_transform.interpolate_with(target_transform, delta * 5.0) 
		if (self.position- destination).length()<=speed*delta:
			self.position = destination
			moving = false
	else:
		self.linear_velocity = Vector3.ZERO
