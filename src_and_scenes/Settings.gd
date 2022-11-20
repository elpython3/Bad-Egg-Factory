extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var should_show = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	should_show = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_show == false:
		hide()
	else:
		show()


func _on_Button_pressed():
	should_show = false
