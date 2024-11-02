extends Control

# Método llamado cuando el nodo está listo. Oculta el menú de pausa al iniciar.
func _ready():
	visible = false  

# Método para manejar la entrada del usuario
# Detecta si se presiona la acción de pausa y alterna el menú de pausa
func _input(event):
	if event.is_action_pressed("ui_pause"):  
		_toggle_pause_menu()  

# Método para alternar la visibilidad del menú de pausa y pausar/reanudar el juego
func _toggle_pause_menu():
	visible = not get_tree().paused  
	get_tree().paused = not get_tree().paused  

# Método para manejar la transición al menú principal
# Restablece los datos de juego y cambia la escena al menú principal.
func _on_Main_Menu_pressed():
	GameData.reset_data() 
	get_tree().paused = false  
	get_tree().change_scene("res://Scenes/Menu/Main_Menu.tscn")
