extends CanvasLayer

export (int) var time_left = 30

# Inicialización del HUD
func _ready():
	update_display()
	start_timer()

# Inicia el temporizador
func start_timer():
	$Timer.start()

# Maneja el evento de timeout del temporizador
func _on_Timer_timeout():
	if not get_tree().paused:
		update_time()
		check_time_critical()
		check_game_over()

# Actualiza el tiempo restante
func update_time():
	time_left -= 1
	update_time_display()

# Actualiza la visualización del tiempo en el HUD
func update_time_display():
	$TimeLeftTxt.text = String(time_left)

# Verifica si el tiempo es crítico (menos de 11 segundos) y reproduce un sonido
func check_time_critical():
	if time_left < 11:
		$TimeSound.play()

# Verifica si el tiempo se ha agotado y reinicia el juego si es necesario
func check_game_over():
	if time_left <= 0:
		GameManager.restart_game()

# Maneja la recolección de una moneda
func handle_coin_collected():
	GameManager.add_coin()

# Maneja la recolección de un portal
func handle_portal_collected():
	GameManager.add_portal()

# Actualiza toda la información mostrada en el HUD
func update_display():
	update_portals_display()
	update_coins_display()
	update_time_display()

# Actualiza la visualización de los portales recolectados
func update_portals_display():
	$PortalsCollectedTxt.text = String(GameManager.portals)

# Actualiza la visualización de las monedas recolectadas
func update_coins_display():
	$CoinsCollectedTxt.text = String(GameManager.coins)

