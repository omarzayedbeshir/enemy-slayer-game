extends Node3D



func _on_area_3d_body_entered(body):
	if "Player" == body.name:
		PlayerManager.player.arrow_count += 3
		queue_free()
