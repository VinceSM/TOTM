extends KinematicBody2D

export var speed = 300
export var vertical_speed = 400
onready var _animated_sprite = $AnimatedSprite

var velocity = Vector2()
var screen_size
var is_on_ceiling = false
var is_on_floor = false
var is_dead = false

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if event.is_action_pressed("ui_up") and not is_on_ceiling:
		_animated_sprite.flip_v = true 
		is_on_ceiling = true
	elif event.is_action_pressed("ui_down") and is_on_ceiling:
		_animated_sprite.flip_v = false
		is_on_ceiling = false
		

func _process(_delta):
	move_player_x()
	move_player_y()

func move_player_x():
	velocity.x = 0
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		_animated_sprite.play("run")
		_animated_sprite.flip_h = false  
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		_animated_sprite.play("run")
		_animated_sprite.flip_h = true  
	else:
		_animated_sprite.stop()
		_animated_sprite.play("look")

func move_player_y():
	if is_on_ceiling and position.y > 0:
		velocity.y = -vertical_speed
	elif not is_on_ceiling and position.y < screen_size.y - get_animated_sprite_height():
		velocity.y = vertical_speed
	else:
		velocity.y = 0

	velocity = move_and_slide(velocity, Vector2.UP)

func get_animated_sprite_height():
	if _animated_sprite.frames:
		var animation = _animated_sprite.frames.get_animation_names()[0]
		return _animated_sprite.frames.get_frame(animation, 0).get_size().y
	return 0

func add_Coin():
	GameData.add_coin() 
	var canvasLayer = get_tree().get_root().find_node("HUD", true, false)
	canvasLayer.update_display() 

func add_Portal():
	GameData.add_portal() 
	var canvasLayer = get_tree().get_root().find_node("HUD", true, false)
	canvasLayer.update_display()  

func die():
	$deadSound.play()
	$DeadTimer.start()

func _on_DeadTimer_timeout():
	get_tree().change_scene("res://Scenes/Levels/1.tscn")
