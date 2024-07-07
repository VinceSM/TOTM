extends Control

func _ready():
	pass
	
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
