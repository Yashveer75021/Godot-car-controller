extends Camera3D

@export var target_vehicle: Node3D
@export var follow_distance: float = 3.0
@export var camera_height: float = 1.0
@export var move_speed: float = 20.0
@export var look_speed: float = 20.0

var current_focus_point: Vector3 = Vector3.ZERO

func _ready() -> void:
	# Camera ko parent ki rotation/position se azad karta hai
	set_as_top_level(true)
	if target_vehicle:
		current_focus_point = target_vehicle.global_position

func _physics_process(delta: float) -> void:
	if not target_vehicle:
		return
		
	var car_pos = target_vehicle.global_position
	
	# Camera aur gadi ke beech ka direction nikalna (Y-axis ignore karke)
	var dir_to_camera = (global_position - car_pos)
	dir_to_camera.y = 0.0 
	
	if dir_to_camera.length_squared() < 0.01:
		dir_to_camera = Vector3.BACK
	else:
		dir_to_camera = dir_to_camera.normalized()
		
	# Camera ki exact position calculate karna
	var ideal_position = car_pos + (dir_to_camera * follow_distance)
	ideal_position.y = car_pos.y + camera_height
	
	# Smoothly move karna (Lerp)
	global_position = global_position.lerp(ideal_position, move_speed * delta)
	
	# Smoothly target ki taraf dekhna (Focus interpolate karna)
	current_focus_point = current_focus_point.lerp(car_pos, look_speed * delta)
	look_at(current_focus_point, Vector3.UP)
