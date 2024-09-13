extends Area2D

func _on_Spike_body_entered(body):
	if body.get_name() == "Player":
		_restart_game()

func _restart_game():
	get_tree().change_scene("res://Scenes/Levels/1.tscn")
	GameData.reset_data()

