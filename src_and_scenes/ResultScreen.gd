extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal retry
signal next

export var good_or_bad = false # false is bad, true is good
export var level_name = ""
export var level_description = ""
var should_show = false
var level_show = true

func get_shouldShow(should_show_p):
	should_show = should_show_p


# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func start():
	level_show = true
	$LevelShowTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if should_show == true or level_show == true:
		show()
		if level_show == true:
			$TitleMessage.text = level_name
			$Message.text = level_description
			$RetryButton.hide()
			$NextButton.hide()
		else:
			if good_or_bad == false:
				$TitleMessage.text = "You Died!"
				$Message.text = "You fell from a high place! (you're an egg)"
				$RetryButton.show()
				$RetryButton.text = "Retry Level"
				$NextButton.hide()
			elif good_or_bad == true:
				$TitleMessage.text = "Congratulations!"
				$Message.text = "You beat the level!"
				$RetryButton.show()
				$RetryButton.text = "Replay Level"
				$NextButton.show()
				$NextButton.text = "Next Level"
	else:
		hide()

func _on_RetryButton_pressed():
	emit_signal("retry")


func _on_NextButton_pressed():
	emit_signal("next")


func _on_LevelShowTimer_timeout():
	level_show = false
