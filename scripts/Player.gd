# test
extends Node

var body
var cam
var updateE

func _ready():
	body = get_node("RigidBody")
	cam = get_node("RigidBody/Camera")
	set_process(true)
	
func _process(delta):
	print(delta)
	