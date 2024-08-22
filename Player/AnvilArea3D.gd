extends Area3D


func _on_body_entered(body):
	if "Enemy" in body.name and PlayerManager.player.get_node("PlayerStateMachine").CURRENT_STATE.name == "AnvilSwingPlayerState" and PlayerManager.player.new_hit:
		body.health -= 4
		PlayerManager.player.new_hit = false
