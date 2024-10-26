extends Node

const SCORE_FILE_PATH = "res://score.txt"

func _ready():
	load_scores()

func load_scores():
	var file = File.new()
	if file.file_exists(SCORE_FILE_PATH):
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()
		file.close()

		var scores = parse_json(data)

		# Mostrar los puntajes en el leaderboard
		for score_entry in scores:
			add_score_to_list(score_entry["position"],score_entry["name"], score_entry["score"])

func add_score_to_list(position, name, score):
	$Panel/VBoxContainer/ScoreEntry.setPosition(position)
	$Panel/VBoxContainer/ScoreEntry.setNamePlayer(name)
	$Panel/VBoxContainer/ScoreEntry.setScore(score)

