extends CanvasLayer

export (int) var time_left = 30

func _ready():
	update_display()
	$Timer.start()

func _on_Timer_timeout():
	time_left -= 1
	$TimeLeftTxt.text = String(time_left)
	if time_left < 11:
		$TimeSound.play()
	if time_left <= 0:
		_restart_game()

func _restart_game():
	GameData.reset_data() 
	get_tree().change_scene("res://Scenes/Levels/1.tscn")

func handleCoinCollected():
	GameData.add_coin()  
	update_display()

func handlePortalCollected():
	GameData.add_portal()  
	update_display()

func update_display():
	$PortalsCollectedTxt.text = String(GameData.portals)
	$CoinsCollectedTxt.text = String(GameData.coins)
	$TimeLeftTxt.text = String(time_left)
