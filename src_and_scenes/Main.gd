extends Node

export(PackedScene) var main_room

var updateErasoldiers = false

func _ready():
	pass
	#$Map.hide()
	#randomize()
	#$ErasoldierTimer.start()
	#print("Apples")
	#new_game()


func _on_Player_hit():
	game_over()

func game_over():
	pass

func new_game():
#	$Player.start($StartPosition.position)
#	$Map.show()
#	$Map.show_new_tiles()
#
	updateErasoldiers = true
	var ERR = get_tree().change_scene_to(main_room)

	if ERR != OK:
		print("something failed in the door scene")
	
	#print(get_tree().get_nodes_in_group("mob_group")[0])

func _process(_delta):
#	var mob_group = get_tree().get_nodes_in_group("mob_group")
#	for mob in mob_group:
#		mob.get_shouldUpdate(updateErasoldiers)
	pass
