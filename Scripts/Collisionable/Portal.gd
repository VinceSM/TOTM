extends Area2D

# Método que se ejecuta cuando un cuerpo entra en el área del portal
# Verifica si el cuerpo es el jugador y, si es así, realiza una serie de acciones.
func _on_Portal_body_entered(body):
	if body.get_name() == "Player":  # Verifica si el cuerpo es el jugador
		body.add_Portal()  # Llama a la función para agregar un portal al contador del jugador
		
		# Ajusta la velocidad de reproducción de la canción y la reproduce
		$SongPortal.pitch_scale = 1.5 
		$SongPortal.play()

		# Desactiva la detección de colisiones y oculta el portal
		set_deferred("monitoring", false)  # Desactiva la monitorización de colisiones
		set_deferred("collision_layer", 0)  # Remueve el portal de su capa de colisión
		set_deferred("collision_mask", 0)  # Remueve el portal de la máscara de colisión
		visible = false 
		
		# Espera 0.5 segundos antes de liberar el portal y avanzar al siguiente nivel
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free() 
		advance_to_next_level()  

# Avanza al siguiente nivel
func advance_to_next_level():
	var next_level = get_parent().get_next_level()  # Obtiene el índice del próximo nivel
	get_tree().change_scene("res://Scenes/Levels/" + str(next_level) + ".tscn")  # Cambia a la escena del siguiente nivel
	queue_free()  # Elimina el portal de la escena actual
