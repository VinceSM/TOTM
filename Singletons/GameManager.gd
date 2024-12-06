# GameManager.gd
extends Node

# Variables que antes estaban en GameData
var coins = 0
var portals = 0
var total_coins = 0

# Función para agregar una moneda
func add_coin():
	coins += 1
	total_coins += 1
	update_hud()

# Función para agregar un portal
func add_portal():
	portals += 1
	update_hud()

# Función para reiniciar los datos del juego
func reset_data():
	coins = 0
	portals = 0

# Función para obtener el total de monedas
func get_total_coins():
	return total_coins

# Función para actualizar el HUD
func update_hud():
	var hud = get_hud()
	if hud:
		hud.update_display()

# Función para reiniciar el juego
func restart_game():
	reset_data()
	ChangeScene.change_scene("res://Levels/1.tscn")

# Función para obtener el nodo HUD
func get_hud():
	return get_tree().get_root().find_node("HUD", true, false)

