extends Area2D


func _on_Portal_body_entered(body):
	if body.get_name() == "Player":
		$SongPortal.pitch_scale = 1.5
		$SongPortal.play()
		body.add_Portal()
		if $SongPortal.playing :
			get_tree().change_scene("res://Scenes/Levels/"+str(get_parent().get_next_level())+".tscn")
			queue_free()

