extends Node

# Variables para almacenar el nombre y el puntaje del jugador
var player_name = ""
var player_score = 0

# Ruta al archivo de puntajes y límite máximo de puntajes guardados
const SCORE_FILE_PATH = "res://DataGame/score.txt"
const MAX_SCORES = 8 

# Método _ready: Inicializa el puntaje del jugador y actualiza la visualización
func _ready():
	player_score = GameData.coins  # Obtiene el puntaje inicial basado en las monedas recogidas
	update_display()

# Actualiza el texto de la etiqueta de puntaje
func update_display():
	$ScoreLabel.text = "Score: " + str(player_score)  # Muestra el puntaje actual en la interfaz

# Evento que se activa al presionar el botón de guardar
func _on_btnSave_pressed():
	player_name = $NameInput.text  # Captura el nombre ingresado
	if player_name == "":
		print("Debe ingresar un nombre para guardar el score")
		return  # No continúa si el nombre está vacío

	# Guarda el puntaje y regresa al menú principal
	save_score(player_name, player_score)
	get_tree().change_scene("res://Scenes/Menu/Main_Menu.tscn")

# Guarda el puntaje del jugador en el archivo
func save_score(name, score):
	var scores = load_scores()  # Carga los puntajes actuales
	scores.append({"name": name, "score": score})  # Añade el nuevo puntaje

	# Ordena los puntajes de mayor a menor y mantiene solo los mejores puntajes
	scores.sort_custom(self, "get_best_score")
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)

	# Guarda los puntajes en formato JSON
	var file = File.new()
	file.open(SCORE_FILE_PATH, File.WRITE)
	file.store_string(to_json(scores))  # Almacena el JSON de los puntajes en el archivo
	file.close()

# Carga los puntajes desde el archivo
func load_scores():
	var file = File.new()
	if file.file_exists(SCORE_FILE_PATH):  # Verifica si el archivo existe
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()
		file.close()
		return parse_json(data)  # Retorna los puntajes como una lista de diccionarios
	return []  # Retorna una lista vacía si no hay puntajes guardados

# Obtiene el mejor puntaje registrado en la lista
func get_best_score():
	var scores = load_scores()  # Carga los puntajes
	var best_score = 0
	for score_entry in scores:
		if score_entry["score"] > best_score:
			best_score = score_entry["score"]  # Actualiza el mejor puntaje si encuentra uno mayor
	return best_score  # Devuelve el mejor puntaje encontrado
