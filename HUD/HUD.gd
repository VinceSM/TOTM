extends CanvasLayer

export (int) var time_left = 30

func _ready():
	update_display()
	$Timer.start()

func _on_Timer_timeout():
	if not get_tree().paused:
		time_left -= 1
		$TimeLeftTxt.text = String(time_left)
		if time_left < 11:
			$TimeSound.play()
		if time_left <= 0:
			GameManager.restart_game()

func handleCoinCollected():
	GameManager.add_coin()

func handlePortalCollected():
	GameManager.add_portal()

func update_display():
	$PortalsCollectedTxt.text = String(GameData.portals)
	$CoinsCollectedTxt.text = String(GameData.coins)
	$TimeLeftTxt.text = String(time_left)
