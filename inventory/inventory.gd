extends PanelContainer

const slot = preload("res://inventory/slot.tscn")
@onready var item_grid = $MarginContainer/ItemGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	var inv_data = preload("res://test_inv.tres")
	populate_item_grid(inv_data.slot_datas)

func populate_item_grid(slot_datas: Array[SlotData]):
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = slot.instantiate()
		item_grid.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
