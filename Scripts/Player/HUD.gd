extends CanvasLayer

# Tiempo inicial para el temporizador, configurable desde el editor
export (int) var time_left = 30

# Método llamado cuando el nodo está listo. Inicia el temporizador y actualiza la pantalla.
func _ready():
	update_display() 
	$Timer.start()  

# Método llamado cuando el temporizador llega a un intervalo de tiempo
# Descuenta un segundo y actualiza el tiempo en pantalla.
func _on_Timer_timeout():
	if not get_tree().paused: 
		time_left -= 1
		$TimeLeftTxt.text = String(time_left) 
		# Reproduce un sonido cuando quedan menos de 10 segundos
		if time_left < 11:
			$TimeSound.play()
		# Reinicia el juego si el tiempo se agota
		if time_left <= 0:
			_restart_game()

# Reinicia el juego al nivel inicial y restablece los datos de juego
func _restart_game():
	GameData.reset_data() 
	get_tree().change_scene("res://Scenes/Levels/1.tscn") 

# Método para manejar la recolección de una moneda
# Añade una moneda a los datos de juego y actualiza la interfaz.
func handleCoinCollected():
	GameData.add_coin()  
	update_display()  

# Método para manejar la recolección de un portal
# Añade un portal a los datos de juego y actualiza la interfaz.
func handlePortalCollected():
	GameData.add_portal()  
	update_display()  

# Actualiza los elementos de la interfaz con la información de tiempo, monedas y portales recolectados
func update_display():
	$PortalsCollectedTxt.text = String(GameData.portals)  # Muestra los portales recolectados
	$CoinsCollectedTxt.text = String(GameData.coins)  # Muestra las monedas recolectadas
	$TimeLeftTxt.text = String(time_left)  # Muestra el tiempo restante
