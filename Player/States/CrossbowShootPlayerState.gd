class_name CrossbowShootPlayerState

extends State

@onready var camera_raycast = $"../../camroot/h/v/Camera3D/RayCast3D"
var arrow = load("res://Scenes/arrow.tscn")
var instance

func enter():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		PlayerManager.player.arrow_count -= 1
		instance = arrow.instantiate()
		instance.position = camera_raycast.global_position
		instance.transform.basis = camera_raycast.global_transform.basis
		get_parent().add_child(instance)
		PlayerManager.player.new_hit = true
		PlayerManager.player.get_node("Audio/CrossbowAudio").playing = true
		PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("1H_Ranged_Shoot")
		PlayerManager.player.get_node("Rogue_Hooded").rotation.y = PlayerManager.player.get_node("camroot/h").rotation.y
func update(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		PlayerManager.player.velocity.x = 0
		PlayerManager.player.velocity.z = 0
