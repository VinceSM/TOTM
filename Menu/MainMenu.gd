# MainMenu.gd
extends Control

func _on_PlayButton_pressed():
	ChangeScene.change_scene("res://Menu/HowToPlay.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
