extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal run
signal pause


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start():
	$Run.disabled = false

func _on_Run_pressed():
	$ResetTimer.start()
	

func _on_Pause_pressed():
	emit_signal("pause")


func _on_ResetTimer_timeout():
	$Run.disabled = true
	emit_signal("run")
