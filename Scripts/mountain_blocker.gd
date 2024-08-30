extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if len(get_parent().get_node("VillageEnemies").get_children()) == 0:
		queue_free()
