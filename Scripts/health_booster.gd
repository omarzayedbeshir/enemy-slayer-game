extends Node3D

var move_vector = Vector3(0, 1, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(delta)
	position += move_vector * delta
	

func _on_timer_timeout():
	move_vector.y *= -1


func _on_area_3d_body_entered(body):
	if "Player" == body.name:
		if PlayerManager.player.health < 100:
			PlayerManager.player.health += 15
			if PlayerManager.player.health > 100:
				PlayerManager.player.health = 100
			queue_free()
