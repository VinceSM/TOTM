extends KinematicBody2D

onready var player = $AnimatedSprite
onready var movement_manager = MovementManager
onready var game_manager = GameManager

var screen_size
var is_dead = false
var is_in_process = false

# Inicializa el jugador
func _ready():
	initialize_screen_size()

# Inicializa el tamaño de la pantalla
func initialize_screen_size():
	screen_size = get_viewport_rect().size

# Maneja las entradas del jugador
func _input(event):
	if not is_dead:
		handle_gravity_flip(event)

# Maneja el cambio de gravedad
func handle_gravity_flip(event):
	movement_manager.handle_gravity_flip(event, self)

# Procesa el movimiento del jugador
func _process(delta):
	if not is_dead and not get_tree().paused:
		process_movement(delta)

# Procesa el movimiento del jugador
func process_movement(delta):
	movement_manager.move(self, delta)

# Obtiene la altura del sprite animado del jugador
func get_animated_sprite_height():
	if player.frames:
		var animation = player.frames.get_animation_names()[0]
		return player.frames.get_frame(animation, 0).get_size().y
	return 0

# Añade una moneda al contador
func add_coin():
	game_manager.add_coin()

# Añade un portal al contador
func add_portal():
	game_manager.add_portal()

# Maneja la muerte del jugador
func die():
	is_dead = true
	stop_player_animation()
	start_death_timer()

# Detiene la animación del jugador
func stop_player_animation():
	player.stop()

# Inicia el temporizador de muerte
func start_death_timer():
	$DeadTimer.start()

# Maneja el evento de timeout del temporizador de muerte
func _on_DeadTimer_timeout():
	restart_game()

# Reinicia el juego
func restart_game():
	game_manager.restart_game()

