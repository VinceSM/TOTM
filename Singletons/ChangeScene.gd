extends Node

func change_scene(path: String) -> void:
	var error = get_tree().change_scene(path)
	if error != OK:
		push_error("Error al cambiar de escena: " + str(error))
