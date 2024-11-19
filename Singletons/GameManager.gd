extends Node

func update_hud():
	var hud = get_hud()
	if hud:
		hud.update_display()

func restart_game():
	GameData.reset_data()
	get_tree().change_scene("res://Levels/1.tscn")

func get_hud():
	return get_tree().get_root().find_node("HUD", true, false)

func add_coin():
	GameData.add_coin()
	update_hud()

func add_portal():
	GameData.add_portal()
	update_hud()
