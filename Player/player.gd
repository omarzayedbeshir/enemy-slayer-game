extends CharacterBody3D

var health = 100
var energy = 100
const SPEED = 5.0
const JUMP_VELOCITY = 9.0
var direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	PlayerManager.player = self

func _physics_process(delta):
	var health_bar_dimensions = Rect2(0, 0, health / 100.0 * 560, 85)
	$ProgressUI/Control/HealthBar.region_rect = health_bar_dimensions
	print(energy)
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
