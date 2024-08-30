extends CanvasLayer


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for index in range(len(PlayerManager.inventory_data_transfer.slot_datas)):
		PlayerManager.inventory_data_transfer.slot_datas[index] = null

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_end_pressed():
	get_tree().quit()
