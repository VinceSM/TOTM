extends Area2D

export var speed = 500
onready var _animated_sprite = $AnimatedSprite

var screen_size


func _process(delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("run")
	else: _animated_sprite.stop()
	
func _ready():
	screen_size = get_viewport_rect().size

