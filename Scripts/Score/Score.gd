extends Node

# Nombre del jugador y su puntuación
var player_name = ""
var player_score = 0

# Ruta del archivo de puntuaciones y límite de puntajes a guardar
const SCORE_FILE_PATH = "res://DataGame/score.txt"
const MAX_SCORES = 8 

# Método llamado cuando el nodo está listo
# Obtiene la puntuación del jugador y actualiza el HUD
func _ready():
	player_score = GameData.coins  # Obtiene el puntaje del jugador desde GameData
	update_display()  # Actualiza el puntaje en pantalla

# Actualiza el puntaje en el HUD
func update_display():
	$ScoreLabel.text = "Score: " + str(player_score)

# Guarda la puntuación al presionar el botón de guardar
func _on_btnSave_pressed():
	player_name = $NameInput.text  # Obtiene el nombre del jugador desde el campo de texto
	if player_name == "":
		print("Debe ingresar un nombre para guardar el score")
		return
	save_score(player_name, player_score)  # Guarda el puntaje
	get_tree().change_scene("res://Scenes/Menu/Main_Menu.tscn")  # Cambia a la escena del menú principal

# Guarda el puntaje en el archivo
func save_score(name: String, score: int):
	var scores = load_scores()  # Carga los puntajes actuales
	scores.append({"name": name, "score": score})  # Añade el nuevo puntaje
	scores.sort_custom(self, "compare_scores")  # Ordena los puntajes de mayor a menor
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)  # Mantiene solo los MAX_SCORES puntajes más altos
	
	# Guarda el array de puntajes en el archivo como JSON
	var file = File.new()
	file.open(SCORE_FILE_PATH, File.WRITE)
	file.store_string(to_json(scores))  # Guarda el array en formato JSON
	file.close()

# Carga los puntajes desde el archivo y los devuelve como un array de diccionarios
func load_scores() -> Array:
	var file = File.new()
	if file.file_exists(SCORE_FILE_PATH):
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()
		file.close()
		# Si el archivo está vacío o el contenido es incorrecto, retorna un array vacío
		if data.strip_edges() == "":
			return []
		var scores = parse_json(data)
		if typeof(scores) == TYPE_ARRAY:
			return scores  # Retorna el array de puntajes si el archivo tenía datos válidos
	return []  # Retorna una lista vacía si el archivo no existe o está vacío

# Función de comparación para ordenar puntajes de mayor a menor
func compare_scores(a: Dictionary, b: Dictionary) -> int:
	return b["score"] - a["score"]  # Retorna la diferencia entre los puntajes para ordenar

# Devuelve el puntaje más alto en el archivo
func get_best_score() -> int:
	var scores = load_scores()
	if scores.size() > 0:
		return scores[0]["score"]  # El puntaje más alto es el primer elemento tras ordenar
	return 0
