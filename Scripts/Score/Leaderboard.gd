extends Node

# Ruta del archivo donde se guardan los puntajes de los jugadores
const SCORE_FILE_PATH = "res://DataGame/score.txt"
# Ruta de la escena que representa cada entrada de puntaje en el leaderboard
const SCORE_ENTRY_SCENE_PATH = "res://Scenes/Score/ScoreEntry.tscn"
# Máximo número de puntajes a mostrar en el leaderboard
const MAX_SCORES = 8

# Método llamado cuando el nodo está listo. Carga y muestra los puntajes al iniciar.
func _ready():
	load_and_display_scores()

# Carga los puntajes del archivo y los muestra en el leaderboard
func load_and_display_scores():
	var scores = load_scores()  # Carga los puntajes del archivo
	
	# Itera sobre cada puntaje y lo añade a la lista del leaderboard
	for i in range(scores.size()):
		var entry = scores[i]
		add_score_to_list(i + 1, entry["name"], entry["score"])

# Instancia y configura un ScoreEntry en el leaderboard
# @param position: La posición del puntaje en el leaderboard (1, 2, 3, etc.)
# @param name: Nombre del jugador
# @param score: Puntaje del jugador
func add_score_to_list(position: int, name: String, score: int):
	var score_entry_scene = load(SCORE_ENTRY_SCENE_PATH)
	if not score_entry_scene:
		print("Error: No se encontró la escena ScoreEntry.")
		return
	
	# Instancia la escena ScoreEntry y configura su información
	var score_entry = score_entry_scene.instance()
	score_entry.setPosition(position)
	score_entry.setNamePlayer(name)
	score_entry.setScore(score)
	
	# Agrega la entrada de puntaje configurada al VBoxContainer para que se muestre en el leaderboard
	$Panel/VBoxContainer.add_child(score_entry)

# Carga los puntajes almacenados en el archivo y los devuelve como una lista ordenada
# @return Devuelve una lista de puntajes, ordenados de mayor a menor y limitados al número máximo de puntajes.
func load_scores() -> Array:
	var file = File.new()
	var scores = []
	
	if file.file_exists(SCORE_FILE_PATH):
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()
		file.close()
		
		# Si el archivo está vacío o los datos no son válidos, retorna una lista vacía
		if data.strip_edges() == "":
			return []
		var parsed_data = parse_json(data)
		if typeof(parsed_data) == TYPE_ARRAY:
			scores = parsed_data  # Utiliza los datos válidos
		else:
			print("Error: Datos de puntaje no válidos en el archivo")
	
	# Ordena la lista de puntajes de mayor a menor
	scores.sort_custom(self, "get_best_score")
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)
	
	return scores

# Obtiene el puntaje más alto de la lista de puntajes
# @return Devuelve el puntaje más alto
func get_best_score():
	var scores = load_scores()
	var best_score = 0
	
	# Itera sobre cada entrada de puntaje y verifica si es el más alto
	for score_entry in scores:
		if score_entry["score"] > best_score:
			best_score = score_entry["score"]
	return best_score
