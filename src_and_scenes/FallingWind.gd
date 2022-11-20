extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func get_player(player_p):
	player = player_p

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position
	if player.falling_hard == false:
		hide()
	else:
		show()
