extends KinematicBody2D

export var SPEED = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var new_speed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED

	velocity = move_and_slide(velocity)
#
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if "Player" in collision.collider.name:
			if collision.collider.is_ox == true:
				print(collision.collider.velocity.x)
				if collision.collider.right == true:
					#if collision.collider.velocity.x > 0:
					velocity.x += 1
				elif collision.collider.left == true:
					velocity.x -= 1

				if collision.collider.velocity.y > 0:
					velocity.y += 1
				elif collision.collider.velocity.y < 0:
					velocity.y -= 1
		else:
			velocity.x = 0
			velocity.y = 0

func push(velocity_p):
	print("Apple")
	velocity = move_and_slide(velocity_p, Vector2())

func _on_Crate_body_entered(body):
	#print("Banana")
	if body.is_ox == false:
		if body.velocity.x > 0 or body.velocity.x < 0:
			body.velocity.x = 0
		if body.velocity.y > 0 or body.velocity.y < 0:
			body.velocity.y = 0
