extends Node3D

var grabbed_object = null
var grab_distance = 10
var mouse = Vector2()
const DIST = 1000 #Ray Max distance

func _process(delta: float) -> void:
	if grabbed_object:
		if grabbed_object is RigidBody3D:
			lift_item(grabbed_object,get_grab_position(),delta)
		else:
			grabbed_object.position = get_grab_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position
	if event is InputEventMouseButton:
		if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			get_mouse_world_pos(mouse)
		elif event.pressed == false and event.button_index == MOUSE_BUTTON_RIGHT:
			grabbed_object = null

func get_mouse_world_pos(mouse:Vector2):
	#The physics state of the world
	var space = get_world_3d().direct_space_state
	#start and end world positions for the ray
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse,DIST)
	#Params for 3D raycast
	#Alt var params = PhysicsRayQueryParameters3D.create(start,end)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	#cast the ray using the space and return the results as a Dictionary
	var result = space.intersect_ray(params)
	if result.is_empty() == false:
		grabbed_object = result.collider

#Get the position in the world you want to object to follow
func get_grab_position():
	return get_viewport().get_camera_3d().project_position(mouse,grab_distance)

func lift_item(item:RigidBody3D,target_position:Vector3,delta):
		#attach to objects to move
		var I = 500.0 #influence #export to make adjustable
		var S = 20.0 #stiffness #export to make adjustable
		var P = target_position - item.global_position
		var M = item.mass
		var V = item.linear_velocity
		var impulse = (I*P) - (S*M*V)
		var finalImpulse :Vector3 = impulse*delta
		finalImpulse.z = 0
		item.apply_central_impulse(finalImpulse)
