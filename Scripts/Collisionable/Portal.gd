extends Area2D

func _on_Portal_body_entered(body):
	if body.get_name() == "Player":
		body.add_Portal()
		$SongPortal.pitch_scale = 1.5 
		$SongPortal.play()

		set_deferred("monitoring", false)
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)
		visible=false
		
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free() 
		advance_to_next_level() 

func advance_to_next_level():
	var next_level = get_parent().get_next_level()
	get_tree().change_scene("res://Scenes/Levels/" + str(next_level) + ".tscn")
	queue_free()

