extends Node3D

func _on_area_3d_body_entered(body):
	if body == PlayerManager.player:
		get_parent().get_node("AbductedKing").keys_found = true
		PlayerManager.player.get_node("Audio/ItemEquip").play()
		queue_free()
