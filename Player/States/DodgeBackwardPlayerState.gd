class_name DodgeBackwardPlayerState

extends State

func update(_delta):
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Dodge_Backward")
	var angle = PlayerManager.player.get_node("Rogue_Hooded").rotation.y
	PlayerManager.player.velocity.x = -sin(angle)
	PlayerManager.player.velocity.z = -cos(angle)
	PlayerManager.player.velocity = PlayerManager.player.velocity.normalized()
	PlayerManager.player.velocity *= 5
