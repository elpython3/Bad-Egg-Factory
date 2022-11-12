extends KinematicBody2D

export var left_or_right = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouse_in = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if left_or_right == false:
		$AnimatedSprite.play("default", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Belt_mouse_entered():
	mouse_in = true

func _on_Belt_mouse_exited():
	mouse_in = false
