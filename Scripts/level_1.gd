extends Node3D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.force_close.connect(toggle_inventory_interface)
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null):
	inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
		
	if not external_inventory_owner:
		inventory_interface.clear_external_inventory()
