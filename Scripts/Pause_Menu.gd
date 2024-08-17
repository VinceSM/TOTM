extends Control

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("ui_pause"):
		if get_tree().paused == false:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false

