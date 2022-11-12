extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction = "left"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($CollisionShape2D.shape.extents)


func _on_Wind_body_entered(body):
	if body.name == "Player":
		#print("Apple")
		if direction == "left":
			body.blow_left = true
		elif direction == "right":
			body.blow_right = true
		else:
			print("Variable direction can only be \"left\" or \"right\". Your variable: ", direction)


func _on_Wind_body_exited(body):
	if body.name == "Player":
		body.blow_left = false
		body.blow_right = false
