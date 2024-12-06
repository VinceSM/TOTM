# MovementManager.gd
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
func move(entity, _delta, is_enemy = false):
	if is_enemy:
		return move_enemy(entity)
	else:
		return move_player(entity)

# Función para mover al jugador
func move_player(entity):
	update_player_horizontal_movement(entity)
	update_player_vertical_movement(entity)
	return entity.move_and_slide(speed, Vector2.UP)

# Función para mover al enemigo
func move_enemy(entity):
	return entity.move_and_slide(speed, Vector2.UP)

# Función para actualizar el movimiento horizontal del jugador
func update_player_horizontal_movement(entity):
	speed.x = 0
	var animated_sprite = entity.get_node("AnimatedSprite")
	
	if Input.is_action_pressed("ui_right"):
		speed.x += horizontal_speed
		play_run_animation(animated_sprite, false)
	elif Input.is_action_pressed("ui_left"):
		speed.x -= horizontal_speed
		play_run_animation(animated_sprite, true)
	else:
		play_idle_animation(animated_sprite)

# Función para actualizar el movimiento vertical del jugador
func update_player_vertical_movement(entity):
	if is_on_ceiling and entity.position.y > 0:
		speed.y = -vertical_speed
	elif not is_on_ceiling and entity.position.y < fall_limit:
		speed.y = vertical_speed
	else:
		speed.y = 0

# Función para reproducir la animación de correr
func play_run_animation(sprite, flip_h):
	sprite.play("run")
	sprite.flip_h = flip_h

# Función para reproducir la animación de estar quieto
func play_idle_animation(sprite):
	sprite.stop()
	sprite.play("idle")

# Función para manejar el cambio de gravedad
func handle_gravity_flip(event, entity):
	var animated_sprite = entity.get_node("AnimatedSprite")
	if event.is_action_pressed("ui_up") and not is_on_ceiling:
		flip_gravity(animated_sprite, true)
	elif event.is_action_pressed("ui_down") and is_on_ceiling:
		flip_gravity(animated_sprite, false)

# Función para cambiar la gravedad
func flip_gravity(sprite, to_ceiling):
	sprite.flip_v = to_ceiling
	is_on_ceiling = to_ceiling

# Función para establecer la velocidad
func set_velocity(new_speed: Vector2):
	speed = new_speed

# Función para obtener la velocidad actual
func get_velocity() -> Vector2:
	return speed

# Función para actualizar el movimiento del enemigo según su estado
func move_enemy_with_direction(entity, _speed, direction):
	var velocity = Vector2(_speed * direction, 0)
	return entity.move_and_slide(velocity, Vector2.UP)

