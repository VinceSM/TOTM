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
	# Configurar máscara de colisión para detectar solo paredes en la capa 2
	set_collision_mask_bit(1, true)  # La capa 2 corresponde al índice 1
	for i in range(32):
		if i != 1:  # Mantener activa solo la capa 2
			set_collision_mask_bit(i, false)

# Se llama en cada frame de física
func _physics_process(delta):
	if not esta_muerto:
		patrullar(delta)

# Función para manejar el comportamiento de patrulla del enemigo
func patrullar(delta):
	# Establecer la velocidad basada en la dirección actual y la velocidad
	var velocidad = Vector2(velocidad_enemigo * direccion, 0)
	
	# Mover el enemigo y obtener la información de colisión
	var colision = move_and_slide(velocidad, Vector2.UP)
	
	# Verificar colisión con paredes
	if is_on_wall():
		direccion *= -1  # Invertir dirección
	
	# Actualizar la animación del enemigo
	actualizar_animacion()

# Función para actualizar la animación del enemigo basada en su movimiento
func actualizar_animacion():
	sprite.play("walk")
	# Voltear el sprite horizontalmente basado en la dirección del movimiento
	sprite.flip_h = direccion < 0

# Función para manejar el comportamiento de ataque del enemigo (por implementar)
func atacar():
	pass

# Función para manejar la muerte del enemigo (por implementar)
func morir():
	pass

