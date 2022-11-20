extends CanvasLayer

signal start_game
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_NewGame_pressed():
	hideAll()
	emit_signal("start_game")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hideAll():
	$MenuOptions.hide()
	$Title.hide()
	$Version.hide()


func _on_HowToPlay_pressed():
	$HowToPlay.should_show = true
