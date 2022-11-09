extends KinematicBody2D

signal hit

export var room = 0

# Movement Constants
const MOVEMENT_SPEED = 100
const ACCELERATION = 0.8

# Player Variables
var velocity = Vector2.ZERO
var last_direction = Vector2.ZERO
var screen_size
var left = false
var right = true
var up = false
var down = false
var should_update = false
var flash = false
#var flash_counter = 0
var is_bat = false
var is_ox = false

var add_str_moving = "_normal"
var add_str_stat = "_idle"

var killed = false

func get_playerPos(_position):
	pass

func get_shouldUpdate(y_or_n):
	should_update = y_or_n

func _ready():
	screen_size = get_viewport_rect().size
	#hide()

func get_input(velocity_p):
	# Held down, used for movements
	if Input.is_action_pressed("move_right"):
		velocity_p.x += 1
		left = false
		right = true
		up = false
		down = false
		
		
		
	if Input.is_action_pressed("move_left"):
		velocity_p.x -= 1
		left = true
		right = false
		up = false
		down = false
		
	if Input.is_action_pressed("move_down"):
		velocity_p.y += 1
		up = false
		down = true
		up = false
		down = false

	if Input.is_action_pressed("move_up"):
		velocity_p.y -= 1
		up = true
		down = false
		up = false
		down = false
		
	
	# Just Pressed
	if Input.is_action_just_released("move_right"):
		print("Apple")
		left = false
		right = false
		up = false
		down = false
		
	if Input.is_action_just_released("move_left"):
		left = false
		right = false
		up = false
		down = false
		
	if Input.is_action_just_released("move_down"):
		left = false
		right = false
		up = false
		down = false
		
	if Input.is_action_just_released("move_up"):
		left = false
		right = false
		up = false
		down = false
	
	return velocity_p

func get_animation_direction(direction: Vector2):
	var norm_direction = direction.normalized()
	if norm_direction.y >= 0.707:
		return "down"
	elif norm_direction.y <= -0.707:
		return "up"
	elif norm_direction.x <= -0.707:
		return "left"
	elif norm_direction.x >= 0.707:
		return "right"
	return "down"

func animate_player(direction: Vector2):
	
	if direction != Vector2.ZERO:
		# update last_direction
		last_direction = direction
		var animation = "down_normal"
		
		if is_bat == true:
			add_str_moving = "_bat"
			add_str_stat = "_bat_idle"
		elif is_ox == true:
			add_str_moving = "_ox"
			add_str_stat = "_ox_idle"
		else:
			add_str_moving = "_normal"
			add_str_stat = "_idle"
		# Choose walk animation based on movement direction
		if get_animation_direction(last_direction) != "left" and get_animation_direction(last_direction) != "right":
			animation = get_animation_direction(last_direction) + add_str_moving
			
		else:
			animation = "right" + add_str_moving
			$AnimatedSprite.flip_h = get_animation_direction(last_direction) == "left"
		# Play the walk animation
		$AnimatedSprite.play(animation)
	else:
		var animation = "down_idle"
		# Choose idle animation based on last movement direction and play it
		if get_animation_direction(last_direction) != "left" and get_animation_direction(last_direction) != "right":
			animation = get_animation_direction(last_direction) + add_str_stat
		else:
			animation = "right" + add_str_stat
			$AnimatedSprite.flip_h = get_animation_direction(last_direction) == "left"
		# Play the walk animation
		$AnimatedSprite.play(animation)

# Processing
func _process(_delta):
	#get_parent().move_child(self, -1)
	print(left, right, up, down)
	if room == 0:
		$Camera2D.limit_left = -1200
		$Camera2D.limit_top = -800
		$Camera2D.limit_right = 2250
		$Camera2D.limit_bottom = 1750
	velocity = Vector2.ZERO # The player's movement vector.
	$AnimatedSprite.play()
	if killed == false:
		if flash == false:
			velocity = get_input(velocity)
#		else:
#			$FlashTimer.start()

		if velocity.length() > 0:
			velocity = velocity.normalized() * MOVEMENT_SPEED
		
		velocity = move_and_slide(velocity)
		
		if flash == false:
			animate_player(velocity)
		else:
			$AnimatedSprite.animation = "flash"
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.name != "Map":
	#			if "Erasoldier" in collision.collider.name:
	#				die()
				pass
			if "Powerup" in collision.collider.name:
				if collision.collider.bat_or_ox == false:
					is_bat = true
				else:
					is_ox = true
				start_flash()
#			if "Crate" in collision.collider.name:
#				if is_ox == false:
#					collision.collider.push(velocity*5000000000000)
		#print("Collided with: ", collision.collider.name)
	else:
		$AnimatedSprite.animation = "death_normal"
		

func die():
	#hide()
	killed = true
	emit_signal("hit")

func start(pos):
	show()
	position = pos
	$AnimatedSprite.animation = "down_idle"

func _on_Player_hit():
	pass # Replace with function body.

func _on_FlashTimer_timeout():
	print("Apple")
	flash = false
	$FlashTimer.stop()
	$AnimatedSprite.animation = "down_idle"
	velocity.x += 1
	velocity = move_and_slide(velocity)
	animate_player(velocity)

func start_flash():
	flash = true
	$FlashTimer.start()

func _on_AnimatedSprite_animation_finished():
	if killed == true:
		hide()
