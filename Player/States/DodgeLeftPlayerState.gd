class_name DodgeLeftPlayerState

extends State

func update(_delta):
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Dodge_Left")
	var angle = PlayerManager.player.get_node("Rogue_Hooded").rotation.y
	PlayerManager.player.velocity.x = cos(angle)
	PlayerManager.player.velocity.z = -sin(angle)
	PlayerManager.player.velocity = PlayerManager.player.velocity.normalized()
	PlayerManager.player.velocity *= 5
