extends KinematicBody2D


var player
var shouldUpdate

export var SPEED = 75

var left = true
var right = false
var up = false
var down = false

func get_player(player_p):
	player = player_p
	

func get_shouldUpdate(y_or_n):
	shouldUpdate = y_or_n

func _ready():
	#hide()
	pass
	
func _process(_delta):
	var velocity = Vector2.ZERO
	if shouldUpdate == true:
		velocity = global_position.direction_to(player.position)
		#var dir = player.position - position
		#rotation = dir.angle()
		velocity = move_and_slide(velocity * SPEED)
	
	if velocity.x < 0:
		left = true
		right = false
	elif velocity.x > 0:
		right = true
		left = false
	#Animation code based off of direction
	$AnimatedSprite.flip_h = left
		
		#Animation code based off of movement
	$AnimatedSprite.playing = velocity.x != 0
	
func start():
	show()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
