class_name StaffShootPlayerState

extends State

@onready var camera_raycast = $"../../camroot/h/v/Camera3D/RayCast3D"
var instance
var spark = load("res://Scenes/spark.tscn")

func enter():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		instance = spark.instantiate()
		instance.transform.basis = PlayerManager.player.get_node("Rogue_Hooded/InteractRay").global_transform.basis
		instance.position = PlayerManager.player.get_node("Rogue_Hooded/InteractRay").global_position + Vector3(0.0, 2.0, 0.0)
		get_parent().add_child(instance)
		PlayerManager.player.spark_count -= 1
		PlayerManager.player.new_hit = true
		PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Spellcast_Long")
		PlayerManager.player.get_node("Rogue_Hooded").rotation.y = PlayerManager.player.get_node("camroot/h").rotation.y
func update(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		PlayerManager.player.velocity.x = 0
		PlayerManager.player.velocity.z = 0
