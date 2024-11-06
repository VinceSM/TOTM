extends Node

# Constantes
const SCORE_FILE_PATH = "res://DataGame/score.txt" # Ruta del archivo donde se guardan los puntajes.
const SCORE_ENTRY_SCENE_PATH = "res://Scenes/Score/ScoreEntry.tscn" # Ruta de la escena de cada entrada de puntaje.
const MAX_SCORES = 8 # Número máximo de puntajes que se mostrarán.

# Método que se ejecuta cuando el nodo está listo. Carga y muestra los puntajes al iniciar.
func _ready():
	load_and_display_scores()

# Carga los puntajes del archivo, los ordena de mayor a menor y los muestra en la interfaz.
func load_and_display_scores():
	var scores = load_scores()
	
	# Ordenamos los puntajes de mayor a menor
	scores.sort_custom(self, "sort_scores_descending")
	
	# Limpiamos los puntajes existentes antes de mostrar los nuevos
	for child in $Panel/VBoxContainer.get_children():
		child.queue_free()
	
	# Mostramos los puntajes ordenados, hasta el número máximo de puntajes permitidos
	for i in range(min(scores.size(), MAX_SCORES)):
		var entry = scores[i]
		add_score_to_list(i + 1, entry["name"], entry["score"])

# Añade un puntaje específico a la lista de la interfaz, en la posición correspondiente
# @param position La posición del puntaje en el leaderboard (1, 2, 3, etc.)
# @param name Nombre del jugador
# @param score Puntaje del jugador
func add_score_to_list(position: int, name: String, score: int):
	var score_entry_scene = load(SCORE_ENTRY_SCENE_PATH) 
	if not score_entry_scene:
		print("Error: No se encontró la escena ScoreEntry.")
		return
	
	var score_entry = score_entry_scene.instance()
	score_entry.setPosition(position)
	score_entry.setNamePlayer(name)
	score_entry.setScore(score)
	
	$Panel/VBoxContainer.add_child(score_entry)

# Carga los puntajes almacenados en el archivo y los devuelve como una lista.
# Si el archivo está vacío o mal formateado, muestra un mensaje de error.
# @return Lista de puntajes
func load_scores():
	var file = File.new() 
	var scores = []  
	
	if file.file_exists(SCORE_FILE_PATH): 
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()  
		file.close()
		
		var parsed_data = parse_json(data)
		if typeof(parsed_data) == TYPE_ARRAY:
			scores = parsed_data
		else:
			print("Error: El archivo de puntajes está vacío o mal formateado.")
	
	return scores

# Función de comparación para ordenar los puntajes de mayor a menor
# @param a Primer elemento de puntaje
# @param b Segundo elemento de puntaje
# @return true si a es mayor que b
func sort_scores_descending(a, b):
	return a["score"] > b["score"]
