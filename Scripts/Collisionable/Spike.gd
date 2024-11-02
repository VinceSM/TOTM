extends Area2D

# Evento que se activa cuando el cuerpo de otro objeto (body) entra en el área de colisión
func _on_Spike_body_entered(body):
	# Verifica si el objeto que entra en contacto es el jugador
	if body.get_name() == "Player":
		# Ajusta el tono del sonido de muerte y lo reproduce
		$deadSound.pitch_scale = 1.5
		$deadSound.play()
		
		# Llama a la función de muerte del jugador
		body.die()
		
		# Reinicia el juego después de la colisión
		_restart_game()

# Reinicia el juego y restablece los datos
func _restart_game():	
	GameData.reset_data()  # Restablece los datos del juego (puntaje, objetos recolectados, etc.)
