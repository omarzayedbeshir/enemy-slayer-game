extends Node3D

const SPEED = 1.0



var move_status = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if move_status:
		position += transform.basis * Vector3(0, 0, SPEED)


func _on_area_3d_body_entered(body):
	if "Enemy" in body.name:
		body.health = 0


func _on_move_timer_timeout():
	move_status = true


func _on_end_spark_timeout():
	queue_free()
