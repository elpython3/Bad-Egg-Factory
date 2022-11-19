extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal run
signal pause

# Called when the node enters the scene tree for the first time.
func _ready():
	$Run.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start():
	$Run.show()
	$Run.disabled = false

func _on_Run_pressed():
	$Run.hide()
	$Run.disabled = true
	emit_signal("run")

func _on_Pause_pressed():
	emit_signal("pause")
