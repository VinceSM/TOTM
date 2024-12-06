extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var kill_area = $RayCast2D/KillArea 
onready var ray_cast = $RayCast2D
onready var attack_timer = $AttackTimer 
onready var attack_sound = $attackSound  
onready var dead_sound = $deadSound 

export var enemy_speed = 100
export var attack_distance = 100

enum State {
	PATROL,
	ATTACK
}

var current_state = State.PATROL
var direction = 1

var player_body = null  # Variable para almacenar la referencia al jugador

func _ready():
	set_collision_mask_bit(1, true)
	for i in range(32):
		if i != 1:
			set_collision_mask_bit(i, false)
	
	# Conectar la señal de la animación cuando termine
	sprite.connect("animation_finished", self, "_on_attack_finished")

	# Asegúrate de que el temporizador no esté corriendo al inicio
	attack_timer.stop()

func _physics_process(delta):
	match current_state:
		State.PATROL:
			patrol(delta)
		State.ATTACK:
			attack()
	
	# Posicionar el KillArea a lo largo del RayCast2D
	var raycast_position = $RayCast2D.position  # Origen del RayCast2D
	var raycast_end = $RayCast2D.cast_to  # Punto final del RayCast2D
	
	# Calcular la dirección y distancia del RayCast2D
	var _direction = (raycast_end - raycast_position).normalized()
	var distance = raycast_end.length()

	# Ajustar la posición y tamaño del KillArea
	kill_area.position = raycast_position + _direction * (distance / 2)  # Centrar el área en el rayo

	# Ajustar el tamaño del CollisionShape2D dentro de kill_area
	var collision_shape = kill_area.get_node("CollisionShape2D")
	if collision_shape:
		var shape = collision_shape.shape
		if shape is RectangleShape2D:
			shape.extents.x = distance / 2  # Ajustamos la mitad de la distancia

func patrol(delta):
	var velocity = Vector2(enemy_speed * direction, 0)
	move_and_slide(velocity, Vector2.UP)

	if is_on_wall():
		direction *= -1
		ray_cast.cast_to.x *= -1

	update_animation("walk")

func update_animation(anim_name):
	sprite.play(anim_name)
	sprite.flip_h = direction < 0

# Maneja la colisión con el jugador a través del Area2D
func _on_KillArea_body_entered(body):
	if body.name == "Player":
		player_body = body  # Guarda una referencia al jugador
		current_state = State.ATTACK
		attack() 

func attack():
	move_and_slide(Vector2.ZERO)  # Detiene el movimiento
	update_animation("attack") # Cambia la animación de ataque
	attack_sound.play()
	attack_timer.start()

func _on_AttackTimer_timeout():
	_on_attack_finished()
	
func _on_attack_finished():
	if player_body:
		dead_sound.pitch_scale = 1.5
		dead_sound.play()
		player_body.die()  # Matar al jugador
		_restart_game()

func _restart_game():
	GameManager.reset_data()
