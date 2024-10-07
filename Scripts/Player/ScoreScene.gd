extends Node

var player_name = ""
var player_score = 0

const SCORE_FILE_PATH = "user://scores.json"
const MAX_SCORES = 10  

func _ready():
	player_score = GameData.coins  
	update_display()

func update_display():
	$ScoreLabel.text = "Score: " + str(player_score)

func _on_btnSave_pressed():
	player_name = $NameInput.text
	if player_name == "":
		print("Debe ingresar un nombre para guardar el score")
		return
	save_score(player_name, player_score)
	#get_tree().change_scene("res://Scenes/Menu/Leaderboard.tscn")

func save_score(name, score):
	var scores = load_scores() 
	scores.append({"name": name, "score": score})
	scores.sort_custom(self, "_sort_scores")
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)
	var file = File.new()
	file.open(SCORE_FILE_PATH, File.WRITE)
	file.store_string(to_json(scores)) 
	file.close()

func load_scores():
	var file = File.new()
	if file.file_exists(SCORE_FILE_PATH):
		file.open(SCORE_FILE_PATH, File.READ)
		var data = file.get_as_text()
		file.close()
		return parse_json(data) 
	return []  

func _sort_scores(a, b):
	return int(b["score"]) - int(a["score"]) 

func _on_btnMainMenu_pressed():
	get_tree().change_scene("res://Scenes/Menu/Main_Menu.tscn")
