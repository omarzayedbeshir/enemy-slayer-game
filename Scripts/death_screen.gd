extends CanvasLayer


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_end_pressed():
	get_tree().quit()
