extends CanvasLayer

signal resume
signal retry
signal restart
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var should_show = false

func get_shouldShow(should_show_p):
	should_show = should_show_p

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_show == false:
		hide()
	else:
		show()


func _on_Resume_pressed():
	emit_signal("resume")


func _on_Restart_pressed():
	emit_signal("restart")


func _on_Retry_pressed():
	emit_signal("retry")
