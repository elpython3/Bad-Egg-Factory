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

# Called when the node enters the scene tree for the first time.
func _ready():
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$ResultScreen.get_shouldShow(should_show_result)
	$Camera.get_editable(editable)
	if editable == false:
		$Camera.position = $Player.position
	$Pause.get_shouldShow(paused)
	$FallingWind.get_player($Player)
	if paused == false:
		$Player.get_should_update(!editable)
	else:
		$Player.get_should_update(!paused)
	
		

func _input(event):
	if Input.is_action_just_pressed("right_click"):
		if editable == true:
			var conveyor_group = get_tree().get_nodes_in_group("conveyors")
			for conveyor in conveyor_group:
				if "Belt" in conveyor.name:
					if conveyor.mouse_in == true:
						conveyor.queue_free()
						return
			var belt_inst = CONVEYOR_SCENE.instance()
			belt_inst.position = get_local_mouse_position()
			if Input.is_action_pressed("use_shift"):
				belt_inst.left_or_right = true
			belt_inst.add_to_group("conveyors")
			add_child(belt_inst)

func start():
	#$Player.position = $StartPos.position
	$Camera.start($StartPos.position)
	$Player.start($StartPos.position)
	$ResultScreen.start()
	if restart == true:
		for conveyor in get_tree().get_nodes_in_group("conveyors"):
			conveyor.queue_free()
	should_show_result = false
	editable = true
	restart = false



func _on_Camera_run():
	editable = false


func _on_Player_hit():
	should_show_result = true
	$ResultScreen.good_or_bad = false


func _on_ResultScreen_retry():
	start()

func _on_ResultScreen_next():
	var ERR = get_tree().change_scene_to(NEXT_ROOM)

	if ERR != OK:
		print("FAIL: ", ERR)

func _on_Player_finish():
	should_show_result = true
	$ResultScreen.good_or_bad = true



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
