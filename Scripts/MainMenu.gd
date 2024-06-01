extends Control

func _ready():
	_adjust_buttonP($VBoxContainer/PlayButton, 200, 100, 250, 100)
	_adjust_buttonQ($VBoxContainer/QuitButton, 200, 100, 250, 100)

func _adjust_buttonP(button, left, top, width, height):
	button.rect_min_size = Vector2(width, height) 
	button.margin_left = left
	button.margin_top = top
	button.margin_right = left + width
	button.margin_bottom = top + height
	
func _adjust_buttonQ(button, left, top, width, height):
	button.rect_min_size = Vector2(width, height) 
	button.margin_left = left
	button.margin_top = top
	button.margin_right = left + width
	button.margin_bottom = top + height
	
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
