extends Area3D




func _on_body_entered(body):
	if "Player" == body.name and $"../../../../AnimationPlayer".current_animation == "1H_Melee_Attack_Slice_Diagonal" and $"../../../../..".new_hit:
		body.health -= 5
		$"../../../../..".new_hit = false
