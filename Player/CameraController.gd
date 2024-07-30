extends Node3D

@export var cam_v_max = 75
@export var cam_v_min = -20

var h_sensitivity = 0.01
var v_sensitivity = 0.01

var camroot_h = 0
var camroot_v = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		camroot_h += event.relative.x * h_sensitivity
		camroot_v += event.relative.y * v_sensitivity
	
	if event is InputEventMouseButton:
		if event.button_index == 5:
			if $h/v.spring_length > -10:
				$h/v.spring_length -= 0.1
		elif event.button_index == 4:
			if $h/v.spring_length < -2:
				$h/v.spring_length += 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	camroot_v = clamp(camroot_v,deg_to_rad(cam_v_min), deg_to_rad(cam_v_max))
	$h.rotation.y = camroot_h
	$h/v.rotation.x = camroot_v
