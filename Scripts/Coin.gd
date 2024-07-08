extends Area2D

func _on_Coin_body_entered(body):
	if body.get_name() == "Player":
	#if body.is_in_group("Players"):
		body.add_Coin()
		queue_free()
