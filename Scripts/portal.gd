extends Node3D


func _on_area_3d_body_entered(body):
	if body == PlayerManager.player and visible:
		PlayerManager.health_transfer = body.health
		PlayerManager.energy_transfer = body.energy
		PlayerManager.found_anvil_transfer = body.found_anvil
		PlayerManager.found_crossbow_transfer = body.found_crossbow
		PlayerManager.found_stick_transfer = body.found_staff
		PlayerManager.inventory_data_transfer = body.inventory_data
		PlayerManager.arrows_transfer = body.arrow_count
		PlayerManager.sparks_transfer = body.spark_count
		$TransferScreen.show()
		PlayerManager.player.get_node("Audio/MoveAudio").playing = false
		get_parent().get_node("UI/HotBarInventory").hide()
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
