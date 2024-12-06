#ScoreManager.gd
extends Node

# Ruta del archivo que almacena las puntuaciones
const SCORE_FILE_PATH = "res://DataGame/score.txt"

# Número máximo de puntuaciones que se almacenan
const MAX_SCORES = 8

# Carga las puntuaciones desde el archivo
static func load_scores() -> Array:
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

# Guarda las puntuaciones en el archivo
static func save_scores(scores: Array) -> void:
	scores.sort_custom(ScoreManager, "sort_scores_descending")
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)
	
	var file = File.new()
	file.open(SCORE_FILE_PATH, File.WRITE)
	file.store_string(to_json(scores))
	file.close()

# Función de comparación para ordenar las puntuaciones en orden descendente
static func sort_scores_descending(a: Dictionary, b: Dictionary) -> bool:
	return a["score"] > b["score"]

# Obtiene la mejor puntuación
static func get_best_score() -> int:
	var scores = load_scores()
	var best_score = 0
	for score_entry in scores:
		if score_entry["score"] > best_score:
			best_score = score_entry["score"]
	return best_score
