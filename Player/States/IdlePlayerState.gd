class_name IdlePlayerState

extends State

func update(_delta):
	PlayerManager.player.velocity.x = move_toward(PlayerManager.player.velocity.x, 0, PlayerManager.player.SPEED)
	PlayerManager.player.velocity.z = move_toward(PlayerManager.player.velocity.z, 0, PlayerManager.player.SPEED)
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Idle")
	if Input.is_action_pressed("Roll") and Input.is_action_just_pressed("Down") and PlayerManager.player.is_on_floor():
		transition.emit("DodgeBackwardPlayerState")
	elif Input.is_action_pressed("Roll") and Input.is_action_just_pressed("Right") and PlayerManager.player.is_on_floor():
		transition.emit("DodgeRightPlayerState")
	elif Input.is_action_pressed("Roll") and Input.is_action_just_pressed("Left") and PlayerManager.player.is_on_floor():
		transition.emit("DodgeLeftPlayerState")
	elif PlayerManager.player.direction:
		transition.emit("RunPlayerState")
	elif PlayerManager.player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		transition.emit("JumpPlayerState")
	elif Input.is_action_just_pressed("Attack") and PlayerManager.player.is_on_floor() and PlayerManager.player.current_weapon == "sword":
		transition.emit("SwordSwingPlayerState")
	elif Input.is_action_just_pressed("Attack") and PlayerManager.player.is_on_floor() and PlayerManager.player.current_weapon == "anvil":
		transition.emit("AnvilSwingPlayerState")
	elif Input.is_action_just_pressed("Block") and PlayerManager.player.is_on_floor():
		transition.emit("BlockPlayerState")
