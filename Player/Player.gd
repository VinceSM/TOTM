extends KinematicBody2D

onready var player = $AnimatedSprite
onready var movimiento = MovementManager
onready var game_manager = GameManager

var screen_size
var is_dead = false
var is_in_process = false

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if is_dead:
		return
	movimiento.handle_gravity_flip(event, self)

func _process(delta):
	if not is_dead and not get_tree().paused:
		movimiento.move(self, delta)

func get_animated_sprite_height():
	if player.frames:
		var animation = player.frames.get_animation_names()[0]
		return player.frames.get_frame(animation, 0).get_size().y
	return 0

func add_Coin():
	game_manager.add_coin()

func add_Portal():
	game_manager.add_portal()

func die():
	is_dead = true
	player.stop()
	$DeadTimer.start()

func _on_DeadTimer_timeout():
	game_manager.restart_game()
