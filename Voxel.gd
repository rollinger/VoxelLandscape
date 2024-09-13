extends MeshInstance3D

const VOXEL_SIZE = Vector3(1, 1, 1)
const VOXEL_COLOR = Color(0, 1, 0)

func _init():
	# Create the BoxMesh with colored material and a collision box
	var cube_mesh = BoxMesh.new()
	cube_mesh.size = VOXEL_SIZE # Size of the voxel
	mesh = cube_mesh  # Assign the mesh to the MeshInstance3D
	# Create a green material
	var cube_material = StandardMaterial3D.new()
	cube_material.albedo_color = VOXEL_COLOR  # Set color
	cube_mesh.material = cube_material  # Assign the material to the mesh
	# Add collision shape
	var collision_shape = CollisionShape3D.new()
	var shape = BoxShape3D.new()
	shape.size = VOXEL_SIZE  # The size of the collision box matches the mesh
	collision_shape.shape = shape  # Assign the shape to the collision
	add_child(collision_shape)  # Add the collision shape as a child to the MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
