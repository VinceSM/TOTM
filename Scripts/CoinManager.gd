extends Node

const COIN_FILEPATH = "user://coins.data"

var total_coins = 0       # Total de monedas recolectadas a través de niveles
var level_coins = 0       # Monedas recolectadas en el nivel actual
var current_level = 1     # Nivel actual

# Función para agregar monedas en el nivel actual
func add_coin(amount: int = 1) -> void:
	level_coins += amount
	print("Monedas recolectadas en el nivel ", current_level, ": ", level_coins)

# Función para obtener el total de monedas
func get_total_coins() -> int:
	return total_coins + level_coins

# Función para reiniciar las monedas del nivel actual (por muerte)
func reset_level_coins() -> void:
	level_coins = 0
	print("Monedas reiniciadas en el nivel ", current_level, ": ", level_coins)

# Función para pasar al siguiente nivel
func level_completed() -> void:
	total_coins += level_coins
	print("Nivel ", current_level, " completado. Monedas totales: ", total_coins)
	# Reiniciar las monedas del nivel actual y aumentar el nivel
	level_coins = 0
	current_level += 1
	_update_file()  # Guardamos los datos

# Función para cargar los datos de monedas desde un archivo
func load_coins_data() -> void:
	var coin_data = _load_file(COIN_FILEPATH)
	if coin_data.has("coins") and coin_data.has("level"):
		total_coins = coin_data["coins"]
		current_level = coin_data["level"]
		print("Datos cargados. Monedas: ", total_coins, " Nivel actual: ", current_level)
	else:
		print("No se encontraron datos o los datos son inválidos. Comenzando con 0 monedas.")
		_update_file()  # Creamos el archivo si no existe

# Función interna para actualizar los datos en el archivo
func _update_file() -> void:
	var coin_data = { "coins": total_coins, "level": current_level }
	_save_file(COIN_FILEPATH, coin_data)

# Función para gestionar la muerte 
func on_player_death() -> void:
	reset_level_coins() 

# Guardar y cargar archivos
func _save_file(filepath: String, data: Dictionary) -> void:
	var file = File.new()
	if file.open(filepath, File.WRITE) == OK:
		file.store_var(data)
		file.close()
	else:
		print("Error: No se pudo guardar el archivo en ", filepath)

func _load_file(filepath: String) -> Dictionary:
	var file = File.new()
	if file.file_exists(filepath):
		if file.open(filepath, File.READ) == OK:
			var data = file.get_var()
			file.close()
			return data
		else:
			print("Error: No se pudo leer el archivo en ", filepath)
			return {}
	else:
		print("El archivo no existe: ", filepath)
		return {}
