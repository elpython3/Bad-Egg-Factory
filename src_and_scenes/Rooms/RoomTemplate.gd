extends Node2D

export(PackedScene) var CONVEYOR_SCENE
export(PackedScene) var SPRING_SCENE
export(PackedScene) var NEXT_ROOM
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var editable = true
var restart = false
var paused = false
var should_show_result = false
var last_spring = weakref(null)
var init = false
var finish_play = false
var play_game_over = false
var player_path = []

# Called when the node enters the scene tree for the first time.
func _ready():
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$ResultScreen.get_shouldShow(should_show_result)
	$Camera.get_editable(editable)
	if editable == false:
		$Camera.position = $Player.position-($Camera.screen_size)/2
	$BG.position = $Camera.position
	$FinishSFX.position = $Camera.position
	$Pause.get_shouldShow(paused)
	$FallingWind.get_player($Player)
	if paused == false:
		$Player.get_should_update(!editable)
	else:
		$Player.get_should_update(!paused)
	update()
	
func _draw():
	for i in player_path:
		draw_circle(i, 5, Color8(240, 240, 240))

func _input(event):
	if Input.is_action_just_pressed("right_click"):
		if editable == true:
			var conveyor_group = get_tree().get_nodes_in_group("conveyors")
			var spring_group = get_tree().get_nodes_in_group("springs")
			for conveyor in conveyor_group:
				if "Belt" in conveyor.name:
					if conveyor.mouse_in == true:
						conveyor.queue_free()
						return
			for spring in spring_group:
				if "Spring" in spring.name:
					if spring.mouse_in == true:
						spring.queue_free()
						if spring == last_spring:
							last_spring = spring_group[-1]
						return
			if Input.is_action_pressed("use_ctrl"):
				var spring_inst = SPRING_SCENE.instance()
				spring_inst.position = get_local_mouse_position()
				spring_inst.add_to_group("springs")
				add_child(spring_inst)
				move_child(spring_inst, 4)
				last_spring = weakref(spring_inst)
				return
			else:
				var belt_inst = CONVEYOR_SCENE.instance()
				belt_inst.position = get_local_mouse_position()
				if Input.is_action_pressed("use_shift"):
					belt_inst.left_or_right = true
				#get_parent().move_child(self, 1)
				belt_inst.add_to_group("conveyors")
				add_child(belt_inst)
				move_child(belt_inst, 4)
				return
	if Input.is_action_just_pressed("left_click"):
		if editable == true:
			if (!last_spring.get_ref()):
				pass
			else:
				last_spring.get_ref().get_rot(false)

func start():
	#$Player.position = $StartPos.position
	$Camera.start($StartPos.position)
	$Camera/Camera2D.limit_left = $TopLeftMin.position.x
	$Camera/Camera2D.limit_right = $BottomRightMin.position.x
	$Camera/Camera2D.limit_top = $TopLeftMin.position.y
	$Camera/Camera2D.limit_bottom = $BottomRightMin.position.y
	$Buttons.start()
	$Player.start($StartPos.position)
	$Player.killed = false
	$ResultScreen.start()
	if restart == true:
		for conveyor in get_tree().get_nodes_in_group("conveyors"):
			conveyor.queue_free()
		for spring in get_tree().get_nodes_in_group("springs"):
			spring.queue_free()
	should_show_result = false
	editable = true
	restart = false
	if init == false:
		$BG.play()
		
		init = true



func _on_Camera_run():
	editable = false
	player_path.clear()
	$PointAdd.start()
	if (!last_spring.get_ref()):
		pass
	else:
		last_spring.get_ref().get_rot(true)


func _on_Player_hit():
	should_show_result = true
	$ResultScreen.good_or_bad = false
	$BG.stop()
	if play_game_over == false:
		if $GameOverSFX.playing == false:
			$GameOverSFX.play()
			play_game_over = true
	$PointAdd.stop()


func _on_ResultScreen_retry():
	if $ResultScreen.good_or_bad == true:
		restart = true
	init = false
	start()

func _on_ResultScreen_next():
	var ERR = get_tree().change_scene_to(NEXT_ROOM)

	if ERR != OK:
		print("FAIL: ", ERR)

func _on_Player_finish():
	should_show_result = true
	$ResultScreen.good_or_bad = true
	$BG.stop()
	
	



func _on_Camera_pause():
	paused = true


func _on_Pause_resume():
	paused = false


func _on_Pause_restart():
	paused = false
	restart = true
	start()


func _on_Pause_retry():
	paused = false
	start()



func _on_BG_finished():
	$BG.play()


func _on_FinishSFX_finished():
	$FinishSFX.stop()


func _on_Finish_player_entered():
	if $FinishSFX.playing == false:
		$FinishSFX.play()


func _on_GameOverSFX_finished():
	$GameOverSFX.stop()


func _on_PointAdd_timeout():
	player_path.push_back($Player.position)
