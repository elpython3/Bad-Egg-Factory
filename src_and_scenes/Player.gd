extends RigidBody2D

signal hit
signal hard_hit

export var room = 0

# Movement Constants
const MOVEMENT_SPEED = 1
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

var add_str_moving = "_normal"
var add_str_stat = "_idle"

var killed = false
var should_die = false
var hard_rot = false

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
		set_deferred("mode", RigidBody2D.MODE_KINEMATIC)
	velocity = Vector2.ZERO # The player's movement vector.
	$AnimatedSprite.play()
	if killed == false:
		$AnimatedSprite.animation = "default"
	else:
		$AnimatedSprite.animation = "crack"
		
func _physics_process(delta):
	
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
	#print(linear_velocity.y)
#	if linear_velocity.y >= 250 and linear_velocity.y < 300:
#		hard_rot = true
	
#	if linear_velocity.y < 250:
#		should_die = false
#		hard_rot = false
	apply_central_impulse(velocity)
	#print(linear_velocity.x, should_die, hard_rot)
	checkCollisions(delta)
	#print(linear_velocity.y)
	
	
func checkCollisions(delta):
	var collisionList = get_colliding_bodies()
	if(get_colliding_bodies().size() > 0):
		if should_die == true:# or abs(linear_velocity.x) > 100:
			die()
		else:
			#print(linear_velocity.y)
			if "Belt" in collisionList[0].get_name():
				if collisionList[0].left_or_right == false:
					convey_left = true
				if collisionList[0].left_or_right == true:
					convey_right = true
	else:
		convey_left = false
		convey_right = false



func _integrate_forces(state):
	pass

func die():
	#hide()
	killed = true
	emit_signal("hit")
	set_deferred("mode", RigidBody2D.MODE_STATIC)

func start(pos):
	position = pos
	$AnimatedSprite.animation = "default"
	should_die = false

func _on_Player_hit():
	pass # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	if killed == true:
		hide()


