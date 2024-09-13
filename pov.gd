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

# Move the camera based on input and current rotation
func handle_camera_movement(delta):
	var movement = Vector3()
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_up"):  # Move forward
		movement -= transform.basis.z * move_speed * delta
	if Input.is_action_pressed("ui_down"):  # Move backward
		movement += transform.basis.z * move_speed * delta
	if Input.is_action_pressed("ui_left"):  # Move left
		movement -= transform.basis.x * move_speed * delta
	if Input.is_action_pressed("ui_right"):  # Move right
		movement += transform.basis.x * move_speed * delta
	if Input.is_action_pressed("ui_ascend"):  # Move up (optional keybind)
		movement += Vector3.UP * move_speed * delta
	if Input.is_action_pressed("ui_descend"):  # Move down (optional keybind)
		movement -= Vector3.UP * move_speed * delta
	# Apply the calculated movement
	translate(movement)


#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#var ray_origin = project_ray_origin(get_viewport().get_mouse_position())
		#var ray_dir = project_ray_normal(get_viewport().get_mouse_position())
		#var space_state = get_world_3d().direct_space_state
		#var ray = PhysicsRayQueryParameters3D(from=ray_origin, to=ray_origin + ray_dir * 100)
		#var result = space_state.intersect_ray(ray)
#
		#if result:
			#var clicked_voxel = result["collider"]
			#if clicked_voxel:
				#clicked_voxel.queue_free()  # remove the clicked voxel
