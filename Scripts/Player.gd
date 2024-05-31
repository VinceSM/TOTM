extends KinematicBody2D

export var speed = 500
onready var _animated_sprite = $AnimatedSprite

var velocity = Vector2()
var screen_size
var is_on_ceiling = false

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	handle_input()
	move_player(delta)

func handle_input():
	velocity = Vector2()  # Resetear la velocidad cada frame
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		_animated_sprite.play("run")
		_animated_sprite.flip_h = false  # Voltear sprite hacia la derecha
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		_animated_sprite.play("run")
		_animated_sprite.flip_h = true  # Voltear sprite hacia la izquierda
	else:
		_animated_sprite.stop()

	if Input.is_action_just_pressed("ui_up") and not is_on_ceiling:
		position.y -= 500  # Mover hacia arriba
		_animated_sprite.flip_v = true  # Voltear sprite verticalmente (mirar hacia arriba)
		is_on_ceiling = true
	elif Input.is_action_just_pressed("ui_down") and is_on_ceiling:
		position.y += 500  # Mover hacia abajo
		_animated_sprite.flip_v = false  # No voltear sprite verticalmente (mirar hacia abajo)
		is_on_ceiling = false

func move_player(delta):
	velocity = move_and_slide(velocity, Vector2.UP)

	# Asegurarse de que el jugador no salga de los límites de la pantalla horizontalmente
	if position.x < 0:
		position.x = 0
	elif position.x > screen_size.x - get_animated_sprite_width():
		position.x = screen_size.x - get_animated_sprite_width()

	# Restringir la posición vertical del jugador cuando esté en el suelo o en el techo
	if is_on_ceiling:
		position.y = max(0, position.y)
	else:
		position.y = min(screen_size.y - get_animated_sprite_height(), position.y)

func is_on_floor():
	return not is_on_ceiling  # Verificar si el jugador está en contacto con el suelo

func get_animated_sprite_width():
	if _animated_sprite.frames:
		var animation = _animated_sprite.frames.get_animation_names()[0]
		return _animated_sprite.frames.get_frame(animation, 0).get_size().x
	return 0

func get_animated_sprite_height():
	if _animated_sprite.frames:
		var animation = _animated_sprite.frames.get_animation_names()[0]
		return _animated_sprite.frames.get_frame(animation, 0).get_size().y
	return 0
