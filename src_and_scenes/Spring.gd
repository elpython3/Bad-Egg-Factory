extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var original_pos
var raycast
var mouse_in = false

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	raycast = $RayCast2D
	$AnimatedSprite.animation = "default"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($RayCast2D.cast_to)
	velocity = Vector2.ZERO
	#print(original_pos - position)
	velocity = original_pos - position
	velocity = move_and_slide(velocity, Vector2(0, 0), false, 4, 0.785398, false)
	#print(get_slide_count())
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			#print(collision.collider.name)
			if "Player" in collision.collider.name:
				$AnimatedSprite.animation = "spring_down"
				#print("APPLES")
			else:
				$AnimatedSprite.animation = "default"
	else:
		$AnimatedSprite.animation = "default"

func get_rot():
	var mouse_pos = get_global_mouse_position()
	var dist1 = abs(mouse_pos.x - position.x)
	var dist2 = abs(mouse_pos.y - position.y)
	var dist3 = sqrt(pow(dist1, 2) + pow(dist2, 2))
	var angle = acos((pow(dist3, 2) - (pow(dist1, 2) + pow(dist2, 2)))/(2 * dist1 * dist2))
	rotate(angle)
#	c^2=a^2+b^2-2*a*b*cos(theta)
#	(c^2-(a^2 + b^2))/2 * a * b =cos(theta)

func _on_Spring_mouse_entered():
	mouse_in = true

func _on_Spring_mouse_exited():
	mouse_in = false
