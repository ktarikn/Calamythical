@tool
extends Node3D

@export var shader_path: String = "res://shader/cel-shader-base.gdshader"
@export var next_pass_path: String = "res://shader/outline.gdshader"
@export var run: bool:
	set(value):
		_my_button_pressed()
@export var myName:String = self.name
#changes imported metarial into shadered metarial
#add script to the root of scene
#run by clicking run checkbox
#see the magic happen



func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
func _my_button_pressed():
	var children:Array = get_all_children(self)
	for j in range(children.size()):
		if(children[j] is MeshInstance3D):
			for i in range(children[j].mesh.get_surface_count()):
				apply_shader(children[j],i)
	var scene = PackedScene.new()

	scene.pack(self)
	
	ResourceSaver.save(scene, "res://assets/savedModelScenes/"+ myName +".tscn")

func apply_shader(mesh: MeshInstance3D,metarialIndex):
	var original_material = mesh.mesh.surface_get_material(metarialIndex)
	
	if original_material and shader_path:
		
		var shader_material = ShaderMaterial.new()
		shader_material.shader = load(shader_path)  # Load the shader
		var next_pass_material = ShaderMaterial.new()
		next_pass_material.shader = load(next_pass_path)
		# Copy properties (if they exist in the original material)
		if original_material is StandardMaterial3D:
			
			shader_material.set_shader_parameter("color", original_material.albedo_color)
			shader_material.set_shader_parameter("base_texture", original_material.albedo_texture)
			#shader_material.set_shader_parameter("roughness", original_material.roughness)
			#shader_material.set_shader_parameter("metallic", original_material.metallic)
			#shader_material.set_shader_parameter("normal_texture", original_material.normal_texture)
			shader_material.set_next_pass(next_pass_material)
		print("here")
		mesh.mesh.surface_set_material(metarialIndex, shader_material)  # Apply shader material
