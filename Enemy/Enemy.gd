extends KinematicBody2D

onready var enemigo = $AnimatedSprite
onready var movimiento = MovementManager

var screen_size
var is_dead = false

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	pass

func _process(delta):
	pass

func attack():
	pass

func take_damage(amount):
	pass

func die():
	pass
