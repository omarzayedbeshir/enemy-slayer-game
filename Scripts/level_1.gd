extends Node3D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)
	player.toggle_inventory.connect(toggle_inventory_interface)


func toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
