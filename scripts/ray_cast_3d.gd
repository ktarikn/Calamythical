extends RayCast3D

@onready var table: StaticBody3D = $"../../table"


@onready var rich_text_label: RichTextLabel = $"../RichTextLabel"

@export var highlight:String = "res://shader/outlineHighlight.gdshader"

@export var outline : String = "res://shader/outline.gdshader"

var highlighter:ShaderMaterial = ShaderMaterial.new()
var outliner:ShaderMaterial = ShaderMaterial.new()

func _ready() -> void:
	highlighter.shader = load(highlight)
	outliner.shader = load(outline)

var grabbableObject:Node3D
var empty = Node3D.new()

var masa
var object

func _process(delta: float):
	masa = false
	object = false
	if is_colliding():
		var hit_object = get_collider()
		print(hit_object)
		if(hit_object and hit_object.has_meta("grabbable")):
			print(hit_object)
			print(Time.get_unix_time_from_system())
			
			if(setChildrenMeshNextP(hit_object,highlighter)):
				grabbableObject = hit_object
				object = true
			rich_text_label.text = "Almak için E'ye bas"
			rich_text_label.visible=true
		elif(hit_object and hit_object.has_meta("table")):
			rich_text_label.text = "Masaya Koymak için E'ye bas"
			rich_text_label.visible = true
			setChildrenMeshNextP(hit_object,outliner)
			masa = true
		else:
			setChildrenMeshNextP(grabbableObject,outliner)
			
			grabbableObject =empty
			rich_text_label.visible=false
			
	
	else:
		setChildrenMeshNextP(grabbableObject,outliner)
		grabbableObject =empty
		rich_text_label.visible=false
func _input(event: InputEvent) -> void:
	if(masa):
		if(event.is_action_pressed("interact")):
			while not GlobalInventory.inventory.is_empty():
				var temp = GlobalInventory.inventory[0]
				table.acquireItem(temp)
				GlobalInventory.useItem(GlobalInventory.inventory[0])
				
	
	elif(object):
		if(event.is_action_pressed("interact") and grabbableObject.has_meta("grabbable")):
		
			grab(grabbableObject)
		
func grab(object:Node3D):
	var text_box: Node2D = $"../../TextBox"
	text_box.visible = true
	
	if(grabbableObject.has_meta("itemNo")):
		GlobalInventory.acquire(grabbableObject.get_meta("itemNo"))
	else:
		printerr("item " + grabbableObject.name + " has no itemNo assigned")
	grabbableObject.queue_free()

func setChildrenMeshNextP(node,shader:ShaderMaterial):
	var flag = false
	if(node and node is StaticBody3D):
		var children = get_all_children(node)
		for child in children:
			if(child is MeshInstance3D):
				for j in range(child.mesh.get_surface_count()):
					if(child.mesh.surface_get_material(j) is ShaderMaterial):
						var my_shader = child.mesh.surface_get_material(j)
						my_shader.set_next_pass(shader)
						flag = true
	return flag
	
func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
