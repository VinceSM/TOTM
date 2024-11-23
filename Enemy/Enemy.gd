# Enemy.gd
extends KinematicBody2D

# Referencia al nodo AnimatedSprite
onready var sprite = $AnimatedSprite

# Variables exportadas para ajuste fácil en el editor
export var velocidad_enemigo = 100  # Velocidad a la que se mueve el enemigo

# Variables para controlar el comportamiento del enemigo
var direccion = 1  # Dirección actual de movimiento (1 para derecha, -1 para izquierda)
var esta_muerto = false  # Bandera para verificar si el enemigo está muerto

# Se llama cuando el nodo entra en el árbol de escena
func _ready():
	# Configurar máscara de colisión para detectar solo paredes
	set_collision_mask_bit(1, true)  # Asumiendo que las paredes están en la capa 2 (índice 1)
	for i in range(2, 32):  # Deshabilitar todas las demás capas de colisión
		if i != 1:  # Saltar la capa de paredes
			set_collision_mask_bit(i, false)

# Se llama en cada frame de física
func _physics_process(delta):
	if not esta_muerto:
		patrullar(delta)

# Función para manejar el comportamiento de patrulla del enemigo
func patrullar(delta):
	# Establecer la velocidad basada en la dirección actual y la velocidad
	var velocidad = Vector2(velocidad_enemigo * direccion, 0)
	MovementManagerPlayer.set_velocity(velocidad)
	
	# Mover el enemigo usando el MovementManagerPlayer
	var colision = MovementManagerPlayer.move(self, delta, true)
	
	# Verificar colisión con paredes
	if colision:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.normal.x != 0:
				direccion *= -1  # Invertir dirección
				break
	
	# Actualizar la animación del enemigo
	actualizar_animacion()

# Función para actualizar la animación del enemigo basada en su movimiento
func actualizar_animacion():
	sprite.play("walk")
	# Voltear el sprite horizontalmente basado en la dirección del movimiento
	sprite.flip_h = MovementManagerPlayer.get_velocity().x < 0

# Función para manejar el comportamiento de ataque del enemigo (por implementar)
func atacar():
	pass

# Función para manejar la muerte del enemigo (por implementar)
func morir():
	pass
