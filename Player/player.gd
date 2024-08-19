extends CharacterBody3D

var health = 100
var energy = 100
const SPEED = 5.0
var new_hit = true
const JUMP_VELOCITY = 9.0
@export var inventory_data: InventoryData
var direction
signal toggle_inventory()
@onready var interact_ray = $Rogue_Hooded/InteractRay
@onready var player_mesh = $Rogue_Hooded

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	PlayerManager.player = self

func _physics_process(delta):
	var health_bar_dimensions = Rect2(0, 0, health / 100.0 * 560, 85)
	$ProgressUI/Control/HealthBar.region_rect = health_bar_dimensions
	$ProgressUI/EnergyProgressBar.value = int(energy) + 1
	energy -= delta * 0.2
	if energy <= 0 or health <= 0:
		get_tree().quit()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Right", "Left", "Down", "Up")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var h_rot = $camroot/h.rotation.y
	direction = direction.rotated(Vector3.UP, h_rot).normalized()

	move_and_slide()

func _unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory.emit()
	elif Input.is_action_just_pressed("Interact"):
		interact()
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "1H_Melee_Attack_Slice_Diagonal":
		$PlayerStateMachine/SwordSwingPlayerState.transition.emit("IdlePlayerState")
	if anim_name == "Block_Attack":
		$PlayerStateMachine/BlockPlayerState.transition.emit("IdlePlayerState")
	if anim_name == "Dodge_Backward":
		$PlayerStateMachine/DodgeBackwardPlayerState.transition.emit("IdlePlayerState")
	if anim_name == "Dodge_Left":
		$PlayerStateMachine/DodgeLeftPlayerState.transition.emit("IdlePlayerState")
	if anim_name == "Dodge_Right":
		$PlayerStateMachine/DodgeRightPlayerState.transition.emit("IdlePlayerState")

func interact():
	if interact_ray.is_colliding():
		interact_ray.get_collider().player_interact()

func get_drop_position():
	return player_mesh.global_position + player_mesh.global_transform.basis.z + Vector3.UP

func heal():
	health += 10
	if health > 100:
		health = 100

func can_use_item(item_type):
	if item_type is ItemDataHeal:
		if health >= 100:
			return false
	if item_type is ItemDataEnergize:
		if energy >= 95:
			return false
	return true

func energize():
	energy += 10
	if energy > 100:
		energy = 100
