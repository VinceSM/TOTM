extends Area2D

func _on_Coin_body_entered(body):
	if body.get_name() == "Player":
		body.add_Coin()
		$sfxCoinCollected.pitch_scale = 1.5 
		$sfxCoinCollected.play()

		set_deferred("monitoring", false)
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)
		visible=false
		
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free() 

 

	

