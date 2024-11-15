extends KinematicBody2D

export var speed = 300
export var vertical_speed = 400
export var fall_limit = 2000

onready var player = $AnimatedSprite

var velocity = Vector2()
var screen_size
var is_on_ceiling = false
var is_on_floor = false
var is_dead = false
var is_in_process = false

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if is_dead:
		return
	if event.is_action_pressed("ui_up") and not is_on_ceiling:
		player.flip_v = true
		is_on_ceiling = true
	elif event.is_action_pressed("ui_down") and is_on_ceiling:
		player.flip_v = false
		is_on_ceiling = false

func _process(delta):
	if not is_dead and not get_tree().paused:
		move_player_x()
		move_player_y()

func move_player_x():
	velocity.x = 0
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		player.play("run")
		player.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		player.play("run")
		player.flip_h = true
	else:
		player.stop()
		player.play("look")

func move_player_y():
	if is_on_ceiling and position.y > 0:
		velocity.y = -vertical_speed
	elif not is_on_ceiling and position.y < fall_limit:
		velocity.y = vertical_speed
	else:
		velocity.y = 0

	velocity = move_and_slide(velocity, Vector2.UP)

func get_animated_sprite_height():
	if player.frames:
		var animation = player.frames.get_animation_names()[0]
		return player.frames.get_frame(animation, 0).get_size().y
	return 0

func add_Coin():
	GameManager.add_coin()

func add_Portal():
	GameManager.add_portal()

func die():
	is_dead = true
	player.stop()
	$DeadTimer.start()

func _on_DeadTimer_timeout():
	GameManager.restart_game()
