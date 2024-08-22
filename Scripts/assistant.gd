extends StaticBody3D

@export var dialogue_file = "Dialogues/level_one_dialogues.dialogue"
@export var dialogue_name = "first_dialogue"
var player_near = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Mage/AnimationPlayer.play("Idle")


func _on_area_3d_body_entered(body):
	if body == PlayerManager.player:
		$InteractText.show()
		player_near = true
		
func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact") and player_near:
		DialogueManager.show_example_dialogue_balloon(load(dialogue_file), dialogue_name)

func _on_area_3d_body_exited(body):
	if body == PlayerManager.player:
		$InteractText.hide()
		player_near = false
	
