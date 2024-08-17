extends Node

func _ready():
	pass

func _on_BackBtn_pressed():
	if(Input.action_press("ui_pause")):
		get_tree().change_scene("res://Scenes/Pause_Menu.tscn")
	else:
		get_tree().change_scene("res://Scenes/Main_Menu.tscn")
