class_name AnvilSwingPlayerState

extends State


func enter():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		PlayerManager.player.new_hit = true
		PlayerManager.player.get_node("Audio/AnvilAudio").playing = true
		PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("1H_Melee_Attack_Slice_Diagonal")
	
func update(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		PlayerManager.player.velocity.x = 0
		PlayerManager.player.velocity.z = 0
