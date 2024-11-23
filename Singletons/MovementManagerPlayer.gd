# MovementManagerPlayer.gd
extends Node

# Variables para el movimiento
var speed = Vector2()  # Velocidad actual
var horizontal_speed = 300  # Velocidad horizontal
var vertical_speed = 400  # Velocidad vertical
var fall_limit = 2000  # Límite de caída

# Variables de estado
var is_on_ceiling = false  # Indica si el jugador está en el techo
var is_on_ground = false  # Indica si el jugador está en el suelo

# Función principal de movimiento
func move(entity, delta, is_enemy = false):
	if is_enemy:
		return move_enemy(entity)
	else:
		move_player(entity)
		return entity.move_and_slide(speed, Vector2.UP)

# Función para mover al jugador
func move_player(entity):
	move_player_x(entity)
	move_player_y(entity)

# Función para mover al enemigo
func move_enemy(entity):
	return entity.move_and_slide(speed, Vector2.UP)

# Función para mover al jugador horizontalmente
func move_player_x(entity):
	speed.x = 0
	
	if Input.is_action_pressed("ui_right"):
		speed.x += horizontal_speed
		entity.get_node("AnimatedSprite").play("run")
		entity.get_node("AnimatedSprite").flip_h = false
	elif Input.is_action_pressed("ui_left"):
		speed.x -= horizontal_speed
		entity.get_node("AnimatedSprite").play("run")
		entity.get_node("AnimatedSprite").flip_h = true
	else:
		entity.get_node("AnimatedSprite").stop()
		entity.get_node("AnimatedSprite").play("idle")

# Función para mover al jugador verticalmente
func move_player_y(entity):
	if is_on_ceiling and entity.position.y > 0:
		speed.y = -vertical_speed
	elif not is_on_ceiling and entity.position.y < fall_limit:
		speed.y = vertical_speed
	else:
		speed.y = 0

# Función para manejar el cambio de gravedad
func handle_gravity_flip(event, entity):
	if event.is_action_pressed("ui_up") and not is_on_ceiling:
		entity.get_node("AnimatedSprite").flip_v = true
		is_on_ceiling = true
	elif event.is_action_pressed("ui_down") and is_on_ceiling:
		entity.get_node("AnimatedSprite").flip_v = false
		is_on_ceiling = false

# Función para establecer la velocidad
func set_velocity(new_speed: Vector2):
	speed = new_speed

# Función para obtener la velocidad actual
func get_velocity() -> Vector2:
	return speed
