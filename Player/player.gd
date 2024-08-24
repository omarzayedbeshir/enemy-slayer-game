extends CharacterBody3D

var health = 100
var energy = 100
const SPEED = 5.0
var new_hit = true
var is_invisible = false
var found_anvil = false
var found_crossbow = false
var found_staff = false
const JUMP_VELOCITY = 9.0
var arrow_count = 4
@export var inventory_data: InventoryData
var spark_count = 2
var direction
var current_weapon = "sword"
signal toggle_inventory()
@onready var interact_ray = $Rogue_Hooded/InteractRay
@onready var player_mesh = $Rogue_Hooded

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	PlayerManager.player = self

func _physics_process(delta):
	$AmmunitionCount/AmmunitionCell/ArrowCount/Count.text = str(arrow_count)
	$AmmunitionCount/AmmunitionCell/SparkCount/Count.text = str(spark_count)
	if current_weapon == "crossbow":
		$CrosshairControl.show()
	else:
		$CrosshairControl.hide()
	var health_bar_dimensions = Rect2(0, 0, health / 100.0 * 560, 85)
	$ProgressUI/Control/HealthBar.region_rect = health_bar_dimensions
	$ProgressUI/EnergyProgressBar.value = int(energy) + 1
	energy -= delta * 0.2
	if energy <= 0 or health <= 0:
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
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
	elif Input.is_action_just_pressed("toggle_sword"):
		hide_weapons()
		$Rogue_Hooded/Rig/Skeleton3D/Knife.show()
	elif Input.is_action_just_pressed("toggle_anvil") and found_anvil:
		hide_weapons()
		current_weapon = "anvil"
		$Rogue_Hooded/Rig/Skeleton3D/Anvil.show()
	elif Input.is_action_just_pressed("toggle_crossbow") and found_crossbow:
		hide_weapons()
		$AmmunitionCount/AmmunitionCell/ArrowCount.show()
		$AmmunitionCount.show()
		current_weapon = "crossbow"
		$"Rogue_Hooded/Rig/Skeleton3D/1H_Crossbow".show()
	elif Input.is_action_just_pressed("toggle_staff") and found_staff:
		hide_weapons()
		$AmmunitionCount/AmmunitionCell/SparkCount.show()
		$AmmunitionCount.show()
		current_weapon = "staff"
		$Rogue_Hooded/Rig/Skeleton3D/Staff.show()
	elif Input.is_action_just_pressed("Vanish") and energy > 20 and not is_invisible:
		is_invisible = true
		$InvisibleGlobe.show()
		energy -= 10
		$InvisibleTimer.start()
	
func hide_weapons():
	$AmmunitionCount/AmmunitionCell/ArrowCount.hide()
	$AmmunitionCount/AmmunitionCell/SparkCount.hide()
	$AmmunitionCount.hide()
	$Rogue_Hooded/Rig/Skeleton3D/Knife.hide()
	$Rogue_Hooded/Rig/Skeleton3D/Anvil.hide()
	$"Rogue_Hooded/Rig/Skeleton3D/1H_Crossbow".hide()
	$Rogue_Hooded/Rig/Skeleton3D/Staff.hide()
	
	
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
	if anim_name == "1H_Ranged_Shoot":
		$PlayerStateMachine/CrossbowShootPlayerState.transition.emit("IdlePlayerState")
	if anim_name == "Spellcast_Long":
		$PlayerStateMachine/StaffShootPlayerState.transition.emit("IdlePlayerState")

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


func _on_invisible_timer_timeout():
	is_invisible = false
	$InvisibleGlobe.hide()
