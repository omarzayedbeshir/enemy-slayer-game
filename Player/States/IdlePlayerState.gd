class_name IdlePlayerState

extends State

func update(_delta):
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Idle")
	if PlayerManager.player.direction:
		transition.emit("RunPlayerState")
	elif PlayerManager.player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		transition.emit("JumpPlayerState")
	elif Input.is_action_just_pressed("Attack") and PlayerManager.player.is_on_floor():
		transition.emit("SwordSwingPlayerState")
