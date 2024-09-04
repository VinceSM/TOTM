extends CanvasLayer

var coins = 0
var portals = 0
var time_left = 40  # Tiempo en segundos

func _ready():
	$PortalsCollectedTxt.text = String(portals)
	$CoinsCollectedTxt.text = String(coins)
	$TimeLeftTxt.text = String(time_left)
	
	# Iniciar un temporizador
	$Timer.start()
	
func _on_Timer_timeout():
	time_left -= 1
	$TimeLeftTxt.text = String(time_left)
	
	if time_left <= 0:
		_restart_scene()

func _restart_scene():
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()

func handleCoinCollected():
	print("coin collected")
	coins+=1
	$CoinsCollectedTxt.text = String(coins)
	
func handlePortalCollected():
	print("portal Collected")
	portals +=1
	$PortalsCollectedTxt.text = String (portals)
	
