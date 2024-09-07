extends Node

func _ready():
	pass

func _on_BackBtn_pressed():
	if(Input.action_press("ui_pause")):
		get_tree().change_scene("res://Scenes/Menu/Pause_Menu.tscn")
	else:
		get_tree().change_scene("res://Scenes/Menu/Main_Menu.tscn")
