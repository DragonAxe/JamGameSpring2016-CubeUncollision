# test
extends Node

var body
var cam
var updateE
var restrict_rot = 0

func _ready():
	body = get_node("RigidBody")
	cam = get_node("RigidBody/Camera")
	var vp_middle = get_viewport().get_rect().size / 2
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process(true)
	
func _process(delta):
	camera_rotation()
	player_movement()

func player_movement():
	if (Input.is_action_pressed("player_forward")):
		var rot = cam.get_rotation().normalized()
		var vel = Vector3(sin(rot.y), 0, -cos(rot.y)*cos(rot.x))
		body.set_linear_velocity(vel*10)
		print(rot)
		print(vel)
	pass

func camera_rotation():
	# Get middle pos of viewport
	var vp_middle = get_viewport().get_rect().size / 2
	
	# Get change in position of cursor
	var mouse_delta = get_viewport().get_mouse_pos() - vp_middle
	if (abs(mouse_delta.x) < 1):
		mouse_delta.x = 0
	if (abs(mouse_delta.y) < 1):
		mouse_delta.y = 0
	
	# Initally restrict player rotation
	if (restrict_rot > 10):
		# Set body left-right rotation
		body.rotate_y(mouse_delta.x / 900)
		
		# Set camera up-down rotation
		cam.rotate_x(mouse_delta.y / 900)
		pass
	else:
		restrict_rot += 1
	
	Input.warp_mouse_pos(vp_middle)