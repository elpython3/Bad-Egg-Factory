extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var bat_or_ox = false # false = bat, true = ox

var up = true
var down = false

var velocity = Vector2.ZERO
var original_pos = position

var collected = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	$CollisionShape2D.set_deferred("disabled", false)
	if bat_or_ox == false:
		$AnimatedSprite.animation = "bat"
	else:
		$AnimatedSprite.animation = "ox"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity = Vector2.ZERO
	if collected == false:
		$AnimatedSprite.play()
		if position.y > (original_pos.y + 20):
			down = false
			up = true
		if position.y < (original_pos.y - 20):
			up = false
			down = true
		if up == true:
			velocity.y -= 1
		if down == true:
			velocity.y += 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * 20
		velocity = move_and_slide(velocity)
	
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			print(collision)
			if "Player" in collision.collider.name:
				#collected = true
				queue_free()
	else:
		pass
