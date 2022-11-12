extends KinematicBody2D

export var SPEED = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var new_speed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED

	velocity = move_and_slide(velocity)
#
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if "Player" in collision.collider.name:
			if collision.collider.is_ox == true and collision.collider.charge == true:
				break_block()

func push(velocity_p):
	print("Apple")
	velocity = move_and_slide(velocity_p, Vector2())
	
func break_block():
	queue_free()
