extends Area2D

func _on_Coin_body_entered(body):
	if body.get_name() == "Player":
		body.add_Coin()
		$sfxCoinCollected.play()
		queue_free()
		
