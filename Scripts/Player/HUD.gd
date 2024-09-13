extends CanvasLayer

var time_left = 40  # Tiempo en segundos

func _ready():
	update_display()
	$Timer.start()

func _on_Timer_timeout():
	time_left -= 1
	$TimeLeftTxt.text = String(time_left)
	
	if time_left <= 0:
		_restart_game()

func _restart_game():
	GameData.reset_data()  # Restablecer los datos al reiniciar
	get_tree().change_scene("res://Scenes/Levels/1.tscn")

func handleCoinCollected():
	GameData.add_coin()  # Actualizar las monedas en el Singleton
	update_display()

func handlePortalCollected():
	GameData.add_portal()  # Actualizar los portales en el Singleton
	update_display()

func update_display():
	$PortalsCollectedTxt.text = String(GameData.portals)
	$CoinsCollectedTxt.text = String(GameData.coins)
	$TimeLeftTxt.text = String(time_left)
