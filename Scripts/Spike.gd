extends Area2D

func _on_Spike_body_entered(body):
	if body.get_name() == "Player":
		_restart_scene()

func _restart_scene():
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()

