# Portal.gd
extends Area2D

# Maneja la entrada del jugador en el portal
func _on_Portal_body_entered(body) -> void:
	# Maneja la recolección del portal
	CollectibleBehavior.handle_collection(self, body, $SongPortal, "add_portal")
	
	# Verifica si el cuerpo que entró es el jugador
	if body.get_name() == "Player":
		# Crea un temporizador para avanzar al siguiente nivel después de 0.5 segundos
		self.get_tree().create_timer(0.5).connect("timeout", self, "advance_to_next_level")

# Avanza al siguiente nivel
func advance_to_next_level() -> void:
	# Obtiene el siguiente nivel desde el padre
	var next_level = get_parent().get_next_level()
	
	# Cambia la escena al siguiente nivel
	get_tree().change_scene("res://Levels/" + str(next_level) + ".tscn")
