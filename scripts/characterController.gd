extends CharacterBody3D

@export
var speed:float


@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1


@onready var camera: Camera3D = $Camera3D

var look_dir: Vector2

var absoulteVelocityX : float

var absoulteVelocityZ : float


var mouse_captured: bool = false

func _ready() -> void:
	capture_mouse()
	
func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	
func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(sens_mod: float = 1.0) -> void:
	rotation.y -= look_dir.x * camera_sens * sens_mod
	#rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)
	rotation.x -= look_dir.y * camera_sens * sens_mod
	

func _input(event: InputEvent):
	
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()
	
	var direction = Vector3.ZERO
	if event.is_action_pressed("forward"):
		
		absoulteVelocityZ +=  -speed
		
		
	elif event.is_action_released("forward"):
		
		absoulteVelocityZ -= -speed
		
	elif event.is_action_pressed("backward"):
		
		absoulteVelocityZ -=  -speed
		
		
	elif event.is_action_released("backward"):
		
		absoulteVelocityZ += -speed
		
	elif event.is_action_pressed("left"):
		
		absoulteVelocityX +=  -speed
		
		
	elif event.is_action_released("left"):
		
		absoulteVelocityX -= -speed
		
	elif event.is_action_pressed("right"):
		
		absoulteVelocityX -=  -speed
		
		
	elif event.is_action_released("right"):
		
		absoulteVelocityX += -speed
		
func _physics_process(delta):
	var temp = transform.basis*Vector3(absoulteVelocityX,0,absoulteVelocityZ)
	temp.y = 0
	velocity = temp
	move_and_slide()
