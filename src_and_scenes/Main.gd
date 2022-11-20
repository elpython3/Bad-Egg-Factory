extends Node

export(PackedScene) var main_room

var updateErasoldiers = false

func _ready():
	pass


func _on_Player_hit():
	game_over()

func game_over():
	pass

func new_game():
	updateErasoldiers = true
	var ERR = get_tree().change_scene_to(main_room)

	if ERR != OK:
		print("FAIL: ", ERR)

func _process(_delta):
	pass
