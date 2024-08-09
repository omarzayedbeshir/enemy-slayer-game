class_name SwordSwingPlayerState

extends State


func enter():
	PlayerManager.player.new_hit = true
	PlayerManager.player.get_node("Audio/SwordAudio").playing = true
	PlayerManager.player.get_node("AnimationTree")["parameters/playback"].travel("1H_Melee_Attack_Slice_Diagonal")
	
func update(_delta):
	PlayerManager.player.velocity.x = 0
	PlayerManager.player.velocity.z = 0
