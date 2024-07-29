class_name RunPlayerState

extends State


func update(_delta):
	if not PlayerManager.player.direction:
		transition.emit("IdlePlayerState")
