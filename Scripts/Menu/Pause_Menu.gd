extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("ui_pause"):
		_toggle_pause_menu()

func _toggle_pause_menu():
	visible = not get_tree().paused
	get_tree().paused = not get_tree().paused

func _on_Main_Menu_pressed():
	GameData.reset_data()
	get_tree().paused = false 
	get_tree().change_scene("res://Scenes/Menu/Main_Menu.tscn") 

