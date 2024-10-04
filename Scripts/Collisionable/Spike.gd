extends Area2D

func _on_Spike_body_entered(body):
	if body.get_name() == "Player":
		$deadSound.pitch_scale = 1.5
		$deadSound.play()
		body.die()
		_restart_game()

func _restart_game():	
	GameData.reset_data()

