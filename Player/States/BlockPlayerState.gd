class_name BlockPlayerState

extends State


func update(_delta):
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("Block_Attack")
