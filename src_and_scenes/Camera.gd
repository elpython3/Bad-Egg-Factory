extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var SPEED = 200
var editable = true
signal run
signal pause

func get_editable(editable_p):
	editable = editable_p
# Called when the node enters the scene tree for the first time.
func _ready():
	$Run.show()

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
	
func start(pos):
	$Run.show()
	$Run.disabled = false
	position = pos
	


func _on_Run_pressed():
	$Run.hide()
	$Run.disabled = true
	emit_signal("run")


func _on_Pause_pressed():
	emit_signal("pause")
