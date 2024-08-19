extends Node


var player


func get_global_position():
	return player.global_position

func use_slot_data(slot_data):
	slot_data.item_data.use()
