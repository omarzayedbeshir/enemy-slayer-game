extends Node3D

const SPEED = 16.0
@onready var mesh = $arrow
@onready var ray_cast = $RayCast3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	hide()
	
func _process(delta):
	show()
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray_cast.is_colliding():
		if "Enemy" in ray_cast.get_collider().name:
			ray_cast.get_collider().health -= 6
			queue_free()

func _on_timer_timeout():
	queue_free()
