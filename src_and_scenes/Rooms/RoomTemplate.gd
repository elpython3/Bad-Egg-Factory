extends Node2D

export(PackedScene) var CONVEYOR_SCENE
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var editable = true

# Called when the node enters the scene tree for the first time.
func _ready():
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera.get_editable(editable)
	if editable == false:
		$Camera.position = $Player.position
	$Player.get_should_update(!editable)
	#mob_group.y
	
		

func _input(event):
#	if event is InputEventMouseButton:
#		#if event.type == InputEvent.MOUSE_BUTTON:
#		if event.pressed:
#			if event.buttonindex == BUTTON_RIGHT:
#				print("APPLE")
		#print("Mouse Click/Unclick at: ", event.position)
	if event is InputEventMouseMotion:
	   #print("Mouse Motion at: ", event.position)
		pass
	if Input.is_action_just_pressed("right_click"):
		if editable == true:
			#print("RIGHT")
			var conveyor_group = get_tree().get_nodes_in_group("conveyors")
			for conveyor in conveyor_group:
				#print(conveyor.name)
				if "Belt" in conveyor.name:
					if conveyor.mouse_in == true:
						conveyor.queue_free()
						return
			var belt_inst = CONVEYOR_SCENE.instance()
			#print(get_local_mouse_position())
			belt_inst.position = get_local_mouse_position()
			if Input.is_action_pressed("use_shift"):
				belt_inst.left_or_right = true
			#print(belt_inst.name)
			belt_inst.add_to_group("conveyors")
			add_child(belt_inst)
		
		
		#print(conveyor_group)

func start():
	#$Player.position = $StartPos.position
	$Camera.position = $StartPos.position
	$Player.start($StartPos.position)

func _on_Player_hard_hit():
	$Camera.is_rotating = true



func _on_Camera_run():
	editable = false
