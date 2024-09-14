extends CanvasLayer


func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_cancel") and not get_tree().paused:
		show()
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		if not $"../UI/InventoryInterface".visible:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		hide()
		get_tree().paused = false
