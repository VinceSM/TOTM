extends KinematicBody2D

export var speed = 300
export var vertical_speed = 400
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
	velocity.x = 0  # Resetear la velocidad horizontal cada frame
	
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
		_animated_sprite.play("look")

	if Input.is_action_just_pressed("ui_up") and not is_on_ceiling:
		_animated_sprite.flip_v = true  # Voltear sprite verticalmente (mirar hacia arriba)
		is_on_ceiling = true
	elif Input.is_action_just_pressed("ui_down") and is_on_ceiling:
		_animated_sprite.flip_v = false
		is_on_ceiling = false

func move_player(delta):
	if is_on_ceiling and position.y > 0:
		velocity.y = -vertical_speed
	elif not is_on_ceiling and position.y < screen_size.y - get_animated_sprite_height():
		velocity.y = vertical_speed
	else:
		velocity.y = 0

	velocity = move_and_slide(velocity, Vector2.UP)

func avoid_player_fall(delta):
	pass

func get_animated_sprite_height():
	if _animated_sprite.frames:
		var animation = _animated_sprite.frames.get_animation_names()[0]
		return _animated_sprite.frames.get_frame(animation, 0).get_size().y
	return 0

func add_Coin():
	var canvasLayer = get_tree().get_root().find_node("HUD",true,false)
	
	canvasLayer.handleCoinCollected()
