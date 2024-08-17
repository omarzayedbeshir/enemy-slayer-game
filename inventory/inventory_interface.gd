extends Control

@onready var player_inventory = $PlayerInventory
var grabbed_slot_data
@onready var grabbed_slot = $GrabbedSlot
var external_inventory_owner
@onready var external_inventory = $ExternalInventory
signal force_close

func _physics_process(delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
	if external_inventory_owner and external_inventory_owner.global_position.distance_to(PlayerManager.get_global_position()) > 4:
		force_close.emit()		
func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)
	
func on_inventory_interact(inventory_data, index, button):
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
		
	update_grabbed_slot()

func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()


func set_external_inventory(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	inventory_data.inventory_interact.connect(on_inventory_interact)
	
	external_inventory.set_inventory_data(inventory_data)
	external_inventory.show()
	
func clear_external_inventory():
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		
		external_inventory.clear_inventory_data(inventory_data)
		external_inventory.hide()
		external_inventory_owner = null
