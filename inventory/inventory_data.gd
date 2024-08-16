extends Resource

class_name InventoryData
signal inventory_interact(inventory_data, index, button)
@export var slot_datas: Array[SlotData]
signal inventory_updated(inventory_data: InventoryData)

func on_slot_clicked(index, button):
	inventory_interact.emit(self, index, button)

func grab_slot_data(index):
	var slot_data = slot_datas[index]
	
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null
		
func drop_slot_data(grabbed_slot_data, index):
	var slot_data = slot_datas[index]
	
	slot_datas[index] = grabbed_slot_data
	inventory_updated.emit(self)
	
	return slot_data
