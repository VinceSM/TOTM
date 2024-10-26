extends Area2D

func _on_Portal_body_entered(body):
	if body.get_name() == "Player":
		$SongPortal.pitch_scale = 1.5
		$SongPortal.play() 
		body.add_Portal()
		$SongTimer.start() 

func _on_SongTimer_timeout():
	if $SongPortal.playing:
		$SongPortal.stop() 
	advance_to_next_level() 

func advance_to_next_level():
	var next_level = get_parent().get_next_level()
	get_tree().change_scene("res://Scenes/Levels/" + str(next_level) + ".tscn")
	queue_free()

