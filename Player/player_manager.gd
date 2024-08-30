extends Node


var player
var health_transfer
var energy_transfer
var found_anvil_transfer
var found_crossbow_transfer
var found_stick_transfer
var inventory_data_transfer
var arrows_transfer
var sparks_transfer

func get_global_position():
	return player.global_position

func use_slot_data(slot_data):
	slot_data.item_data.use()
