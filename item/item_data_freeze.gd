class_name ItemDataFreeze

extends ItemData

func use():
	PlayerManager.player.freeze_game_activate()
