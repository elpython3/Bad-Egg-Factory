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
		
		
	if Input.is_action_pressed("move_left"):
		velocity_p.x -= 1
		left = true
		right = false
		
	if Input.is_action_pressed("move_down"):
		velocity_p.y += 1
		up = false
		down = true

	if Input.is_action_pressed("move_up"):
		velocity_p.y -= 1
		up = true
		down = false
	
	if Input.is_action_pressed("ui_cancel"):
		die()
		
	
	# Just Pressed
		if Input.is_action_just_pressed("move_right"):
			up = false
			down = false
			
		if Input.is_action_just_pressed("move_left"):
			up = false
			down = false
			
		if Input.is_action_just_pressed("move_down"):
			left = false
			right = false
			
		if Input.is_action_just_pressed("move_up"):
			left = false
			right = false
	
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
		# Choose walk animation based on movement direction
		if get_animation_direction(last_direction) != "left" and get_animation_direction(last_direction) != "right":
			animation = get_animation_direction(last_direction) + "_normal"
			
		else:
			animation = "right_normal"
			$AnimatedSprite.flip_h = get_animation_direction(last_direction) == "left"
		# Play the walk animation
		$AnimatedSprite.play(animation)
	else:
		var animation = "down_idle"
		# Choose idle animation based on last movement direction and play it
		if get_animation_direction(last_direction) != "left" and get_animation_direction(last_direction) != "right":
			animation = get_animation_direction(last_direction) + "_idle"
		else:
			animation = "right_idle"
			$AnimatedSprite.flip_h = get_animation_direction(last_direction) == "left"
		# Play the walk animation
		$AnimatedSprite.play(animation)

func animateAll(velocity_p):
	print($AnimatedSprite.frame)
	"""
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * MOVEMENT_SPEED
		
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		if left == true or right == true:
			$AnimatedSprite.animation = "right_idle"
			$AnimatedSprite.flip_h = left
		elif down == true:
			$AnimatedSprite.animation = "down_idle"
		elif up == true:
			$AnimatedSprite.animation = "up_idle"

	velocity = move_and_slide(velocity)

	if velocity.x != 0:
		$AnimatedSprite.animation = "right_normal"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = left
	elif velocity.y > 0:
		$AnimatedSprite.animation = "down_normal"
	"""
	if should_update == true:
		$AnimatedSprite.play()
		if flash == false:
			if velocity_p.length() <= 0:
				if left == true or right == true:
					$AnimatedSprite.animation = "right_idle"
					$AnimatedSprite.flip_h = left
				elif down == true:
					$AnimatedSprite.animation = "idle"
				elif up == true:
					$AnimatedSprite.animation = "up_idle"
					#$AnimatedSprite.flip_h = left
#			else:
			if velocity_p.x != 0:
				$AnimatedSprite.animation = "right_normal"
				$AnimatedSprite.flip_v = false
				$AnimatedSprite.flip_h = left
			if velocity_p.y > 0:
				#$AnimatedSprite.animation = "up"
				#$AnimatedSprite.flip_v = velocity_p.y > 0
				$AnimatedSprite.animation = "down_normal"
					#if $AnimatedSprite.frame == 0:
					#	$AnimatedSprite.frame += 1
		else:
			$AnimatedSprite.animation = "flash"

# Processing
func _process(_delta):
	#get_parent().move_child(self, -1)
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
		else:
			$FlashTimer.start()

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
				is_bat = true
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
	flash = false
	$FlashTimer.stop()
	$AnimatedSprite.animation = "down_idle"


func _on_AnimatedSprite_animation_finished():
	if killed == true:
		hide()
