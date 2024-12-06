#Pause_Menu.gd
extends Control

class_name PauseMenu

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

# Método para resetear el estado del menu de pausa
func reset_pause_state():
	visible = false
	get_tree().paused = false

# Método para manejar la transición al menú principal
# Restablece los datos de juego y cambia la escena al menú principal.
func _on_Main_Menu_pressed():
	GameManager.reset_data() 
	get_tree().paused = false  
	ChangeScene.change_scene("res://Menu/Main_Menu.tscn")
