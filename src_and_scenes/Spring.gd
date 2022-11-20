extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var original_pos
var cast_dir
var mouse_in = false
var kill_any_spring = false

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	cast_dir = $RayCast2D.cast_to
	$AnimatedSprite.animation = "default"
	kill_any_spring = true
	$KillTimer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RayCast2D.rotation = rotation
	cast_dir = $RayCast2D.global_position
	velocity = Vector2.ZERO
	velocity = original_pos - position
	velocity = move_and_slide(velocity, Vector2(0, 0), false, 4, 0.785398, false)
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if "Player" in collision.collider.name:
				$AnimatedSprite.animation = "spring_down"
			elif "Spring" in collision.collider.name:
				if kill_any_spring == true:
					collision.collider.queue_free()
			else:
				$AnimatedSprite.animation = "default"
	else:
		$AnimatedSprite.animation = "default"

func get_rot(reverse):
	if reverse == false:
		rotate(deg2rad(45))
	else:
		rotate(deg2rad(-45))



func _on_SpringCollisions_mouse_entered():
	mouse_in = true


func _on_SpringCollisions_mouse_exited():
	mouse_in = false


func _on_KillTimer_timeout():
	kill_any_spring = false
