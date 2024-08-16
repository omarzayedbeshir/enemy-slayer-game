class_name BlockPlayerState

extends State


func update(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		transition.emit("IdlePlayerState")
	else:
		PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Block_Attack")
