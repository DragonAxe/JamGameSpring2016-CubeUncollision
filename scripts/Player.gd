
extends KinematicBody



var cam
var body
var restrict_rot = 0

var g = -9.8
var vel = Vector3()
const MAX_SPEED = 5
const JUMP_SPEED = 7
const ACCEL= 2
const DEACCEL= 4
const MAX_SLOPE_ANGLE = 30



func _ready():
	cam = get_node("Camera")
	body = self
	
	var vp_middle = get_viewport().get_rect().size / 2
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	set_process(true)
	set_fixed_process(true)



func _fixed_process(delta):
	player_movement(delta)



func _process(delta):
	camera_rotation()



# Called by _process()
func player_movement(delta):
	var body_xform = body.get_global_transform()
	if (Input.is_action_pressed("player_forward")):
		body.move(-body_xform.basis[2]/30)
	
	if (Input.is_action_pressed("player_backward")):
		body.move(body_xform.basis[2]/30)
	
	if (Input.is_action_pressed("player_left")):
		body.move(-body_xform.basis[0]/30)
	
	if (Input.is_action_pressed("player_right")):
		body.move(body_xform.basis[0]/30)



# Called by _process()
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