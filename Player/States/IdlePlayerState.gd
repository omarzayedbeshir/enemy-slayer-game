class_name IdlePlayerState

extends State

func update(_delta):
	if PlayerManager.player.direction:
		transition.emit("RunPlayerState")
