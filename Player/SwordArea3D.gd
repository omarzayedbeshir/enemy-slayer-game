extends Area3D


func _on_body_entered(body):
	if "Enemy" in body.name and PlayerManager.player.get_node("PlayerStateMachine").CURRENT_STATE.name == "SwordSwingPlayerState" and PlayerManager.player.new_hit:
		body.health -= 3
		PlayerManager.player.new_hit = false

