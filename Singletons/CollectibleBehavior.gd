extends Node

# Maneja la recolección de un objeto coleccionable
func handle_collection(collectible: Area2D, body: Node, sound_node: AudioStreamPlayer, collection_method: String):
	if body.get_name() == "Player":
		# Llama al método de recolección en el jugador
		body.call(collection_method)
		
		# Reproduce el sonido de recolección
		play_collection_sound(sound_node)

		# Desactiva el coleccionable
		disable_collectible(collectible)
		
		# Programa la eliminación del coleccionable
		schedule_collectible_removal(collectible)

# Reproduce el sonido de recolección
func play_collection_sound(sound_node: AudioStreamPlayer):
	sound_node.pitch_scale = 1.5 
	sound_node.play()

# Desactiva el coleccionable (colisiones y visibilidad)
func disable_collectible(collectible: Area2D):
	collectible.set_deferred("monitoring", false)
	collectible.set_deferred("collision_layer", 0)
	collectible.set_deferred("collision_mask", 0)
	collectible.visible = false

# Programa la eliminación del coleccionable después de un corto retraso
func schedule_collectible_removal(collectible: Area2D):
	collectible.get_tree().create_timer(0.5).connect("timeout", collectible, "queue_free")

