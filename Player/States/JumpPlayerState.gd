class_name JumpPlayerState

extends State

func enter():
	PlayerManager.player.velocity.y = PlayerManager.player.JUMP_VELOCITY

func update(delta):
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Jump_Full_Long")
	if PlayerManager.player.direction and PlayerManager.player.is_on_floor():
		transition.emit("RunPlayerState")
	elif not PlayerManager.player.direction and PlayerManager.player.velocity.y == 0:
		transition.emit("IdlePlayerState")
