extends Node3D

var keys_found = false
var started_playing = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if keys_found == true:
		$Lock.hide()


func _on_area_3d_body_entered(body):
	if PlayerManager.player == body:
		if keys_found == true and len(get_parent().get_node("OtherEnemies").get_children()) == 0 and not started_playing:
			$"Tower-hexagon-top-wood".hide()
			$"Tower-hexagon-roof".hide()
			$"Tower-hexagon-top".hide()
			$Knight/AnimationPlayer.play("Cheer")
			$CheerAudio.play()
			PlayerManager.player.won = true
			started_playing = true


func _on_cheer_audio_finished():
	get_tree().change_scene_to_file("res://Scenes/victory_screen.tscn")
