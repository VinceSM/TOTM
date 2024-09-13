extends Area2D

func _on_Coin_body_entered(body):
	if body.get_name() == "Player":
		body.add_Coin()
		queue_free()

func _on_sfxCoinCollected_finished():
	queue_free()
	

