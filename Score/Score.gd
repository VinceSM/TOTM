# Score.gd
extends Node

var player_name = ""
var player_score = 0

func _ready():
	player_score = GameManager.coins
	update_display()

func update_display():
	$ScoreLabel.text = "Score: " + str(player_score)

func _on_btnSave_pressed():
	player_name = $NameInput.text
	if player_name == "":
		print("Debe ingresar un nombre para guardar el score")
		return

	save_score(player_name, player_score)
	get_tree().change_scene("res://Menu/Main_Menu.tscn")
	GameManager.reset_data()

func save_score(name, score):
	var scores = ScoreManager.load_scores()
	scores.append({"name": name, "score": score})
	ScoreManager.save_scores(scores)
