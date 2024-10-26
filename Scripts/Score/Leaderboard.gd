extends Node

const SCORE_FILE_PATH = "res://score.txt"
const SCORE_ENTRY_SCENE_PATH = "res://Scenes/Score/ScoreEntry.tscn"  # Ajusta la ruta a donde tengas la escena de ScoreEntry
const MAX_SCORES = 8

func _ready():
	load_and_display_scores()

# Función para cargar y mostrar los puntajes
func load_and_display_scores():
	var scores = load_scores()
	# Agregar cada puntaje al leaderboard
	for i in range(scores.size()):
		var entry = scores[i]
		add_score_to_list(i + 1, entry["name"], entry["score"])

# Función que instancia y configura un ScoreEntry en el leaderboard
func add_score_to_list(position: int, name: String, score: int):
	var score_entry_scene = load(SCORE_ENTRY_SCENE_PATH)
	if not score_entry_scene:
		print("Error: No se encontró la escena ScoreEntry.")
		return
	
	# Instanciar y configurar ScoreEntry
	var score_entry = score_entry_scene.instance()
	score_entry.setPosition(position)
	score_entry.setNamePlayer(name)
	score_entry.setScore(score)
	
	# Agregar ScoreEntry a VBoxContainer
	$Panel/VBoxContainer.add_child(score_entry)

# Función para cargar puntajes desde el archivo
func load_scores():
	var file = File.new()
	var scores = []
	
	if file.file_exists(SCORE_FILE_PATH):
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()
		file.close()
		
		# Parsear JSON y verificar si es un array
		var parsed_data = parse_json(data)
		if typeof(parsed_data) == TYPE_ARRAY:
			scores = parsed_data
		else:
			print("Error: El archivo de puntajes está vacío o mal formateado.")
	
	# Asegura que solo se devuelvan los mejores puntajes, ordenados
	scores.sort_custom(self, "_sort_scores")
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)
	
	return scores

# Función para ordenar puntajes de mayor a menor
func _sort_scores(a, b):
	return int(b["score"]) - int(a["score"])
