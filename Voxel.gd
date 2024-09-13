extends MeshInstance3D

func _init():
	var cube_mesh = BoxMesh.new()
	cube_mesh.size = Vector3(1, 1, 1)  # size of the voxel
	mesh = cube_mesh
	
	#var material = StandardMaterial3D.new()
	#material.albedo_texture = load("res://path_to_texture.png")
	#mesh.material_override = material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
