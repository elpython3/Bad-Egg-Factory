extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var SPEED = 200
var is_rotating = false
var editable = true
signal run

func get_editable(editable_p):
	editable = editable_p
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.show()
	#pass # Replace with function body.

func get_input(velocity_p):
	if editable == true:
		if Input.is_action_pressed("move_left"):
			velocity_p.x -= 1
		if Input.is_action_pressed("move_right"):
			velocity_p.x += 1
		if Input.is_action_pressed("move_up"):
			velocity_p.y -= 1
		if Input.is_action_pressed("move_down"):
			velocity_p.y += 1
	return velocity_p

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	velocity = get_input(velocity)
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
	#$Camera2D.rotate(deg2rad(10))



func _on_RotateTimer_timeout():
	is_rotating = false
	#rotation_degrees = 0


func _on_Run_pressed():
	$Run.hide()
	emit_signal("run")


func _on_Camera_body_entered(body):
	print("Apple")
	if "Map" in body.name:
		print("Banana")
		if velocity.x > 0 or velocity.x < 0:
			velocity.x = 0
		if velocity.y > 0 or velocity.y < 0:
			velocity.y = 0
		position += velocity
