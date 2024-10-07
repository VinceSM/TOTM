extends Node2D

func _ready():
	pass # Replace with function body.


func _on_btnScore_pressed():
	get_tree().change_scene("res://Scenes/Player/Score.tscn")
