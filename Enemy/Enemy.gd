# Enemy.gd
extends KinematicBody2D

# Referencias a nodos del enemigo
onready var sprite = $AnimatedSprite
onready var kill_area = $RayCast2D/KillArea 
onready var ray_cast = $RayCast2D
onready var attack_timer = $AttackTimer  
onready var dead_sound = $Death/DeathSound

# Velocidad y distancia de ataque del enemigo
export var enemy_speed = 100
export var attack_distance = 100

# Estados del enemigo
enum State {
	PATROL,
	ATTACK
}

# Estado actual del enemigo
var current_state = State.PATROL
# Dirección del enemigo
var direction = 1

# Referencia al jugador
var player_body = null

func _ready():
	# Configura la máscara de colisión
	set_collision_mask_bit(1, true)
	for i in range(32):
		if i != 1:
			set_collision_mask_bit(i, false)
	
	# Conecta la señal de la animación cuando termine
	sprite.connect("animation_finished", self, "_on_attack_finished")

	# Asegúrate de que el temporizador no esté corriendo al inicio
	attack_timer.stop()

func _physics_process(delta):
	# Actualiza el estado del enemigo
	match current_state:
		State.PATROL:
			patrol(delta)
		State.ATTACK:
			attack()
	directionKillArea()

func directionKillArea():
	# Posiciona el KillArea a lo largo del RayCast2D
	var raycast_position = $RayCast2D.position  
	var raycast_end = $RayCast2D.cast_to  
	
	# Calcula la dirección y distancia del RayCast2D
	var _direction = (raycast_end - raycast_position).normalized()
	var distance = raycast_end.length()

	# Ajusta la posición y tamaño del KillArea
	kill_area.position = raycast_position + _direction * (distance / 2)  
	kill_area.position = raycast_position + _direction * (distance / 2)  

	# Ajusta el tamaño del CollisionShape2D dentro de kill_area
	var collision_shape = kill_area.get_node("CollisionShape2D")
	if collision_shape:
		var shape = collision_shape.shape
		if shape is RectangleShape2D:
			shape.extents.x = distance / 2  

func patrol(_delta):
	MovementManager.move_enemy_with_direction(self, enemy_speed, direction)
	# Cambia la dirección si el enemigo choca con una pared
	if is_on_wall():
		direction *= -1
		ray_cast.cast_to.x *= -1

	# Actualiza la animación del enemigo
	update_animation("walk")

func update_animation(anim_name):
	# Reproduce la animación especificada
	sprite.play(anim_name)
	sprite.flip_h = direction < 0

# Maneja la colisión con el jugador a través del Area2D
func _on_KillArea_body_entered(body):
	# Verifica si el cuerpo que entró es el jugador
	if body.name == "Player":
		# Detiene el movimiento del jugador
		body.disable_movement()
		# Guarda una referencia al jugador
		player_body = body  
		# Cambia el estado del enemigo a atacar
		current_state = State.ATTACK
		# Ataca al jugador
		attack()

func attack():
	# Detiene el movimiento del enemigo
	move_and_slide(Vector2.ZERO)  
	# Actualiza la animación del enemigo
	update_animation("attack") 
	# Inicia el temporizador de ataque
	attack_timer.start()
	if attack_timer:
		$attackSound.play()

func _on_AttackTimer_timeout():
	# Llama a la función _on_attack_finished cuando el temporizador de ataque termine
	_on_attack_finished()
	
func _on_attack_finished():
	# Verifica si el jugador está referenciado
	if player_body:
		# Reproduce el sonido de muerte
		dead_sound.pitch_scale = 1.5
		dead_sound.play()
		# Mata al jugador
		player_body.die()  
		# Reinicia el juego
		_restart_game()

func _restart_game():
	# Llama al método reset_data de GameManager para reiniciar el juego
	GameManager.reset_data()
