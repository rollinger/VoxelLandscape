extends Camera3D

# Speed settings for movement and mouse sensitivity
var move_speed = 8.0
var mouse_sensitivity = 0.005

# Stores the mouse movement for rotation
var rotation_x = 0
var rotation_y = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Capture mouse for FPS-like movement

func _process(delta):
	handle_camera_rotation(delta)
	handle_camera_movement(delta)

# Handle mouse-based camera rotation
func handle_camera_rotation(delta):
	var mouse_movement = Input.get_last_mouse_velocity()
	# Update rotation based on mouse movement
	rotation_x -= mouse_movement.y * mouse_sensitivity * delta
	rotation_y -= mouse_movement.x * mouse_sensitivity * delta
	# Limit up/down looking angles
	rotation_x = clamp(rotation_x, -1.5, 1.5)
	# Apply rotation to the camera
	rotation_degrees.x = rad_to_deg(rotation_x)
	rotation_degrees.y = rad_to_deg(rotation_y)


# This function ensures that the camera moves in the direction it's currently pointing
func handle_camera_movement(delta):
	var movement = Vector3()
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	# Move forward and backward relative to the camera's local Z-axis (forward/backward)
	if Input.is_action_pressed("ui_up"):  # Move forward
		movement += -transform.basis.z * move_speed * delta
	if Input.is_action_pressed("ui_down"):  # Move backward
		movement += transform.basis.z * move_speed * delta
	
	# Move left and right relative to the camera's local X-axis (strafing/lateral movement)
	if Input.is_action_pressed("ui_left"):  # Move left (strafe)
		movement += -transform.basis.x * move_speed * delta
	if Input.is_action_pressed("ui_right"):  # Move right (strafe)
		movement += transform.basis.x * move_speed * delta

	# Move up and down relative to the camera's local Y-axis (up/down)
	if Input.is_action_pressed("ui_ascend"):  # Move up
		movement += transform.basis.y * move_speed * delta
	if Input.is_action_pressed("ui_descend"):  # Move down
		movement += -transform.basis.y * move_speed * delta

	# Apply the calculated movement (relative to the current rotation and direction)
	translate(movement)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Perform the raycast
		var from = project_ray_origin(event.position)
		var to = from + project_ray_normal(event.position) * 1000  # Extend the ray far into the distance
		
		# Prepare the raycast query using a dictionary
		var query = PhysicsRayQueryParameters3D.create(from, to)
		
		# Get the physics space state and perform the raycast
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(query)
		
		# Check for collisions
		if result:
			var collider = result.collider
			if collider is MeshInstance3D:
				print("Collision detected with a MeshInstance3D!")
				print("Collision point: ", result.position)
				print("Collider: ", collider)
		else:
			print("No collision detected")
		
		## Check if the raycast hit something
		#if result:
			#var clicked_voxel = result.collider
			#if clicked_voxel:
				#clicked_voxel.queue_free()  # Remove the clicked voxel
