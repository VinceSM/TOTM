extends KinematicBody2D

var velocity = Vector2()
var speed = 300
var vertical_speed = 400
var fall_limit = 2000

var is_on_ceiling = false
var is_on_floor = false

func move(entity, delta):
	move_x(entity)
	move_y(entity)
	entity.move_and_slide(velocity, Vector2.UP)

func move_x(entity):
	velocity.x = 0
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		entity.get_node("AnimatedSprite").play("run")
		entity.get_node("AnimatedSprite").flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		entity.get_node("AnimatedSprite").play("run")
		entity.get_node("AnimatedSprite").flip_h = true
	else:
		entity.get_node("AnimatedSprite").stop()
		entity.get_node("AnimatedSprite").play("look")

func move_y(entity):
	if is_on_ceiling and entity.position.y > 0:
		velocity.y = -vertical_speed
	elif not is_on_ceiling and entity.position.y < fall_limit:
		velocity.y = vertical_speed
	else:
		velocity.y = 0

func handle_gravity_flip(event, entity):
	if event.is_action_pressed("ui_up") and not is_on_ceiling:
		entity.get_node("AnimatedSprite").flip_v = true
		is_on_ceiling = true
	elif event.is_action_pressed("ui_down") and is_on_ceiling:
		entity.get_node("AnimatedSprite").flip_v = false
		is_on_ceiling = false
