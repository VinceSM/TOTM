extends KinematicBody2D

# Configuración de velocidad y límites
export var speed = 300  
export var vertical_speed = 400  
export var fall_limit = 2000  

# Referencia al nodo de animación del jugador
onready var player = $AnimatedSprite

# Variables de control de estado del jugador
var velocity = Vector2() 
var screen_size  
var is_on_ceiling = false  
var is_on_floor = false  
var is_dead = false 
var is_in_process = false  

# Método que se ejecuta cuando el nodo está listo
func _ready():
	screen_size = get_viewport_rect().size  

# Método que procesa la entrada del usuario
# Controla la inversión de gravedad (subir y bajar)
func _input(event):
	if is_dead:  
		return  
	if event.is_action_pressed("ui_up") and not is_on_ceiling:  
		player.flip_v = true 
		is_on_ceiling = true
	elif event.is_action_pressed("ui_down") and is_on_ceiling: 
		player.flip_v = false
		is_on_ceiling = false

# Método que se llama en cada cuadro y controla el movimiento
func _process(delta):
	if not is_dead and not get_tree().paused:  # Solo se mueve si no está muerto ni en pausa
		move_player_x()  
		move_player_y()  

# Controla el movimiento horizontal del jugador
func move_player_x():
	velocity.x = 0
	
	if Input.is_action_pressed("ui_right"):  # Movimiento hacia la derecha
		velocity.x += speed
		player.play("run") 
		player.flip_h = false  
	elif Input.is_action_pressed("ui_left"):  # Movimiento hacia la izquierda
		velocity.x -= speed
		player.play("run")
		player.flip_h = true  
	else: 
		player.stop()
		player.play("look")

# Controla el movimiento vertical del jugador
func move_player_y():
	if is_on_ceiling and position.y > 0:  # Movimiento hacia el techo
		velocity.y = -vertical_speed
	elif not is_on_ceiling and position.y < fall_limit:  # Movimiento hacia el suelo
		velocity.y = vertical_speed
	else:  # Detiene el movimiento vertical si alcanza los límites
		velocity.y = 0

	# Aplica el movimiento calculado al jugador
	velocity = move_and_slide(velocity, Vector2.UP)

# Obtiene la altura de la animación actual del jugador
func get_animated_sprite_height():
	if player.frames:
		var animation = player.frames.get_animation_names()[0]
		return player.frames.get_frame(animation, 0).get_size().y
	return 0

# Función para agregar una moneda al contador de GameData y actualizar el HUD
func add_Coin():
	GameData.add_coin() 
	var canvasLayer = get_tree().get_root().find_node("HUD", true, false)
	canvasLayer.update_display()  

# Función para agregar un portal al contador de GameData y actualizar el HUD
func add_Portal():
	GameData.add_portal() 
	var canvasLayer = get_tree().get_root().find_node("HUD", true, false)
	canvasLayer.update_display() 

# Función que maneja la muerte del jugador, detiene la animación y empieza un temporizador
func die():
	is_dead = true  
	player.stop()
	$DeadTimer.start() 

# Método que se llama cuando el temporizador de muerte finaliza, reinicia el juego
func _on_DeadTimer_timeout():
	get_tree().change_scene("res://Scenes/Levels/1.tscn") 
