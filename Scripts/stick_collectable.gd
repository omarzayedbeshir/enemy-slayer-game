extends Node3D


func _on_area_3d_body_entered(body):
	if body == PlayerManager.player:
		PlayerManager.player.found_staff = true
		PlayerManager.player.get_node("Audio/ItemEquip").play()
		PlayerManager.player.get_node("WeaponInventory/InventoryCells/StaffIcon").show()
		queue_free()
