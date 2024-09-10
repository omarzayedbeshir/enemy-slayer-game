extends CharacterBody3D

@export var patrol = false
var see_player = false
var attack_player = false
var new_hit = true
var SPEED = 2.0
var health = 12
var direction
var forward = true
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var mesh = $Barbarian
@onready var anim = $Barbarian/AnimationPlayer
var previous_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SubViewport/HealthBar3D.value = health
	if health <= 0:
		anim.play("Death_A")
		await anim.animation_finished
	if not is_on_floor():
		velocity.y -= gravity * delta
	var player = PlayerManager.player
	direction = (player.position - position).normalized()
	if see_player and not PlayerManager.player.is_invisible:
		if previous_position and is_on_floor():
			if previous_position.distance_to(position) < 0.01:
				velocity.y = 5
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		anim.play("Running_A")
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta * 10)
		previous_position = position
	elif attack_player and not PlayerManager.player.is_invisible:
		velocity.x = 0
		velocity.z = 0
		anim.play("1H_Melee_Attack_Slice_Diagonal")
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta * 10)		
	else:
		if patrol:
			if forward:
				mesh.rotation = Vector3(0, -0.5 * PI, 0)
				velocity.x = -SPEED
				velocity.z = 0
				anim.play("Running_A")
			else:
				mesh.rotation = Vector3(0, 0.5 * PI, 0)
				velocity.x = SPEED
				velocity.z = 0
				anim.play("Running_A")
		else:
			velocity.x = 0
			velocity.z = 0
			anim.play("Idle")
	move_and_slide()


func _on_chase_player_body_entered(body):
	if body.name == "Player":
		see_player = true


func _on_chase_player_body_exited(body):
	if body.name == "Player":
		see_player = false


func _on_attack_player_body_entered(body):
	if body.name == "Player":
		see_player = false
		attack_player = true	


func _on_attack_player_body_exited(body):
	if body.name == "Player":
		attack_player = false
		see_player = true


func _on_timer_timeout():
	forward = !forward


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death_A":
		queue_free()
	elif anim_name == "1H_Melee_Attack_Slice_Diagonal":
		new_hit = true
