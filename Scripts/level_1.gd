extends Node3D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)

