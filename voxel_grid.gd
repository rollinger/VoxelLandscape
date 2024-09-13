extends Node3D

@export var grid_size = Vector3(10, 3, 10)

var Voxel = preload("res://Voxel.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_voxel_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func generate_voxel_grid():
	for x in range(int(grid_size.x)):
		for y in range(int(grid_size.y)):
			for z in range(int(grid_size.z)):
				var voxel = Voxel.new()
				voxel.position = Vector3(x, y, z)
				add_child(voxel)

# This function merges voxel meshes into one mesh
#func merge_voxels():
	#var mesh_data = ArrayMesh.new()
	#var surface_tool = SurfaceTool.new()
#
	#surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
#
	#for voxel in get_children():
		#surface_tool.add_mesh_array(voxel.mesh.surface_get_arrays(0))
		#voxel.queue_free()  # remove individual voxels
#
	#surface_tool.generate_normals()
	#mesh_data = surface_tool.commit()
#
	#var merged_mesh_instance = MeshInstance.new()
	#merged_mesh_instance.mesh = mesh_data
	#add_child(merged_mesh_instance)
