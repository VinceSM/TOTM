# Leaderboard.gd
extends Node

const SCORE_ENTRY_SCENE_PATH = "res://Score/ScoreEntry.tscn"

func _ready():
	load_and_display_scores()

func load_and_display_scores():
	var scores = ScoreManager.load_scores()
	
	scores.sort_custom(ScoreManager, "sort_scores_descending")
	
	for child in $Panel/VBoxContainer.get_children():
		child.queue_free()
	
	for i in range(min(scores.size(), ScoreManager.MAX_SCORES)):
		var entry = scores[i]
		add_score_to_list(i + 1, entry["name"], entry["score"])

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
