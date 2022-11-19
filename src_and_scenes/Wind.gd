extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction = false # false = left, true = right

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.flip_h = direction


func _on_Wind_body_entered(body):
	if body.name == "Player":
		#print("Apple")
		if direction == false:
			body.blow_left = true
		elif direction == true:
			body.blow_right = true
		else:
			print("Variable direction can only be \"left\" or \"right\". Your variable: ", direction)


func _on_Wind_body_exited(body):
	if body.name == "Player":
		body.blow_left = false
		body.blow_right = false
