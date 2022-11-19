extends RigidBody2D

signal hit
signal finish

export var room = 0

# Movement Constants
const MOVEMENT_SPEED = 100
const BOUNCE_SPEED = 150
const ACCELERATION = 0.8

var frame_counter = 0
# Player Variables
var velocity = Vector2.ZERO
var last_direction = Vector2.ZERO
var screen_size
var should_update = false

var blow_left = false
var blow_right = false
var convey_left = false
var convey_right = false

var finished = false
var killed = false
var should_die = false
var falling_hard = false

var old_pos
var dist = 0.0
var y_speed = 0

func get_playerPos(_position):
	pass

func get_should_update(update_cond):
	should_update = update_cond

func _ready():
	#set_deferred("mode", RigidBody2D.MODE_STATIC)
	screen_size = get_viewport_rect().size
	

func get_input():
	pass

# Processing
func _process(_delta):
	if should_update == true:
		set_deferred("mode", RigidBody2D.MODE_RIGID)
	else:
		set_deferred("mode", RigidBody2D.MODE_STATIC)
	velocity = Vector2.ZERO # The player's movement vector.
	$AnimatedSprite.play()
	if killed == false:
		$AnimatedSprite.animation = "default"
	else:
		$AnimatedSprite.animation = "crack"
	if finished == true:
		emit_signal("finish")
		
func _physics_process(delta):
	if finished == false:
		if blow_left == true:
			velocity.x -= 10
		elif blow_right == true:
			velocity.x += 10
		if convey_left == true:
			velocity.x -= 5
		elif convey_right == true:
			velocity.x += 5
		
		if linear_velocity.y >= 300:
			should_die = true
		
		if linear_velocity.y >= 250:
			falling_hard = true
		else:
			falling_hard = false
		
		apply_central_impulse(velocity)
		checkCollisions(delta)
	else:
		should_die = false
		falling_hard = false
	
	
func checkCollisions(_delta):
	var collisionList = get_colliding_bodies()
	if(get_colliding_bodies().size() > 0):
		if "Spring" in collisionList[0].get_name():
			print(round(rad2deg(collisionList[0].rotation)))
			if round(collisionList[0].rotation) == deg2rad(0):
				apply_central_impulse(Vector2(0, -1).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == 45:
				print("Apple")
				apply_central_impulse(Vector2(1, -1).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == 90:
				apply_central_impulse(Vector2(1, 0).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == 135:
				apply_central_impulse(Vector2(1, 1).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == 180:
				apply_central_impulse(Vector2(0, 1).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == -135:
				apply_central_impulse(Vector2(-1, 1).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == -90:
				apply_central_impulse(Vector2(-1, 0).normalized()*BOUNCE_SPEED)
			elif round(rad2deg(collisionList[0].rotation)) == -45:
				apply_central_impulse(Vector2(-1, -1).normalized()*BOUNCE_SPEED)
		elif should_die == true:
			if finished == false:
				die()
		else:
			if "Belt" in collisionList[0].get_name():
				if collisionList[0].left_or_right == false:
					convey_left = true
				if collisionList[0].left_or_right == true:
					convey_right = true
			
	else:
		convey_left = false
		convey_right = false



func _integrate_forces(_state):
	pass

func die():
	killed = true
	set_deferred("mode", RigidBody2D.MODE_STATIC)
	emit_signal("hit")
	#set_deferred("mode", RigidBody2D.MODE_STATIC)

func start(pos):
	set_deferred("mode", RigidBody2D.MODE_KINEMATIC)
	show()
	position = pos
	$AnimatedSprite.animation = "default"
	#set_deferred("mode", RigidBody2D.MODE_STATIC)
	should_update = false
	finished = false
	should_die = false
	killed = false
	
	
	#set_deferred("mode", RigidBody2D.MODE_STATIC)


func _on_AnimatedSprite_animation_finished():
	if killed == true:
		hide()


