extends Node3D




func _on_area_3d_body_entered(body):
	if body.name == "Player":
		body.spark_count += 3
		queue_free()
