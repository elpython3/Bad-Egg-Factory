extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var good_or_bad = false # false is bad, true is good
var should_show = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_show == true:
		show()
		if good_or_bad == false:
			$TitleMessage.text = "You Died!"
			$Message.text = "You fell from a high place! (you're an egg)"
			$RetryButton.text = "Retry Level"
			$NextButton.hide()
		if good_or_bad == false:
			$TitleMessage.text = "Congratulations!"
			$Message.text = "You beat the level!"
			$RetryButton.text = "Replay Level"
			$NextButton.show()
			$NextButton.text = "Next Level"
	else:
		hide()
		
