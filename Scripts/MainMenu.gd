extends Control

func _ready():
	pass
	
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Tutorial.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_HowToPlayBtn_pressed():
	get_tree().change_scene("res://Scenes/HowToPlay.tscn")
