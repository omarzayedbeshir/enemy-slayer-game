extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel
signal slot_clicked(index, button)

func set_slot_data(slot_data: SlotData):
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	if slot_data.quantity > 1:
		quantity_label.text = "x" + str(slot_data.quantity)
		quantity_label.show()
	else:
		quantity_label.hide()
	
	tooltip_text = item_data.name + "\n" + item_data.description


func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
