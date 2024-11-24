extends KinematicBody2D

# Referencia al nodo AnimatedSprite
onready var sprite = $AnimatedSprite

# Variables exportadas para ajuste fácil en el editor
export var enemy_speed = 100  # Velocidad a la que se mueve el enemigo

# Variables para controlar el comportamiento del enemigo
var direction = 1  # Dirección actual de movimiento (1 para derecha, -1 para izquierda)
var is_dead = false  # Bandera para verificar si el enemigo está muerto

# Se llama cuando el nodo entra en el árbol de escena
func _ready():
	# Configurar máscara de colisión para detectar solo paredes en la capa 2
	set_collision_mask_bit(1, true)  # La capa 2 corresponde al índice 1
	for i in range(32):
		if i != 1:  # Mantener activa solo la capa 2
			set_collision_mask_bit(i, false)

# Se llama en cada frame de física
func _physics_process(delta):
	if not is_dead:
		patrol(delta)

# Función para manejar el comportamiento de patrulla del enemigo
func patrol(delta):
	# Establecer la velocidad basada en la dirección actual y la velocidad
	var velocity = Vector2(enemy_speed * direction, 0)
	
	# Mover el enemigo y obtener la información de colisión
	var collision = move_and_slide(velocity, Vector2.UP)
	
	# Verificar colisión con paredes
	if is_on_wall():
		direction *= -1  # Invertir dirección
	
	# Actualizar la animación del enemigo
	update_animation()

# Función para actualizar la animación del enemigo basada en su movimiento
func update_animation():
	sprite.play("walk")
	# Voltear el sprite horizontalmente basado en la dirección del movimiento
	sprite.flip_h = direction < 0

# Función para manejar el comportamiento de ataque del enemigo (por implementar)
func attack():
	pass

# Función para manejar la muerte del enemigo (por implementar)
func die():
	pass

