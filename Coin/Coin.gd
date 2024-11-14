extends Area2D

# Evento que se activa cuando otro objeto (body) entra en el área de colisión de la moneda
func _on_Coin_body_entered(body):
	# Verifica si el objeto que entra en contacto es el jugador
	if body.get_name() == "Player":
		# Llama a la función del jugador para añadir una moneda al puntaje
		body.add_Coin()
		
		# Ajusta el tono del efecto de sonido de recolección de moneda y lo reproduce
		$sfxCoinCollected.pitch_scale = 1.5 
		$sfxCoinCollected.play()

		# Desactiva la detección de colisiones para evitar recolecciones múltiples
		set_deferred("monitoring", false)
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)
		visible = false  # Oculta la moneda visualmente
		
		# Espera 0.5 segundos antes de eliminar el nodo de la moneda de la escena
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()  # Elimina el nodo de la moneda de la escena para liberar recursos
