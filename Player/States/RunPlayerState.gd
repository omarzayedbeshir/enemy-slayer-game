class_name RunPlayerState

extends State

func enter():
	PlayerManager.player.get_node("Audio/MoveAudio").playing = true

func update(delta):
	PlayerManager.player.velocity.x = PlayerManager.player.direction.x * PlayerManager.player.SPEED
	PlayerManager.player.velocity.z = PlayerManager.player.direction.z * PlayerManager.player.SPEED
	if PlayerManager.player.direction:
		PlayerManager.player.get_node("Rogue_Hooded").rotation.y = lerp_angle(PlayerManager.player.get_node("Rogue_Hooded").rotation.y, atan2(PlayerManager.player.direction.x, PlayerManager.player.direction.z), delta * 10) 
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Running_A")
	if not PlayerManager.player.direction and PlayerManager.player.is_on_floor():
		PlayerManager.player.get_node("Audio/MoveAudio").playing = false
		transition.emit("IdlePlayerState")
	elif PlayerManager.player.is_on_floor() and Input.is_action_just_pressed("Jump"):
		PlayerManager.player.get_node("Audio/MoveAudio").playing = false		
		transition.emit("JumpPlayerState")
	elif Input.is_action_just_pressed("Attack") and PlayerManager.player.is_on_floor() and PlayerManager.player.current_weapon == "sword":
		PlayerManager.player.get_node("Audio/MoveAudio").playing = false
		transition.emit("SwordSwingPlayerState")
	elif Input.is_action_just_pressed("Attack") and PlayerManager.player.is_on_floor() and PlayerManager.player.current_weapon == "anvil":
		PlayerManager.player.get_node("Audio/MoveAudio").playing = false
		transition.emit("AnvilSwingPlayerState")
