extends Area2D


func _on_Portal_body_entered(body):
	if body.get_name() == "Player":
		body.add_Portal()
		queue_free()
		get_tree().change_scene("res://Scenes/Levels/"+str(get_parent().get_next_level())+".tscn")
