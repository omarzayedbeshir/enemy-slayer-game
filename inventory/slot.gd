extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel

func set_slot_data(slot_data: SlotData):
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	if slot_data.quantity > 1:
		quantity_label.text = "x" + str(slot_data.quantity)
		quantity_label.show()
	else:
		quantity_label.hide()
	
	tooltip_text = item_data.name + "/n" + item_data.description
