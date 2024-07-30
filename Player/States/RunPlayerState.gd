class_name RunPlayerState

extends State


func update(delta):
	if PlayerManager.player.direction:
		PlayerManager.player.get_node("Rogue_Hooded").rotation.y = lerp_angle(PlayerManager.player.get_node("Rogue_Hooded").rotation.y, atan2(PlayerManager.player.direction.x, PlayerManager.player.direction.z), delta * 10) 
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Running_A")
	if not PlayerManager.player.direction and PlayerManager.player.is_on_floor():
		transition.emit("IdlePlayerState")
	elif PlayerManager.player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		transition.emit("JumpPlayerState")
	elif Input.is_action_just_pressed("Attack") and PlayerManager.player.is_on_floor():
		transition.emit("SwordSwingPlayerState")
