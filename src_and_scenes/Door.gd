extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var teleport_scene
export var KILL_PLAYER = false
export var TELEPORT_ROOM = ""


var body

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_parent().move_child(self, 1)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$AnimatedSprite.play()
	#print(get_tree())
	
	#move_and_slide(Vector2.ZERO)
	#print(get_slide_count())
#	if get_slide_count() < 1 and collided == true:
#		$AnimatedSprite.play("default", true)
#		collided = false
#	print(get_slide_count())
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		#print(collision)#.collider.name)
#		if "Player" in collision.collider.name:
#			$AnimatedSprite.play()
#			collided = true

func next_level():
	var ERR
	#print(get_tree())
	if TELEPORT_ROOM == "":
		ERR = get_tree().change_scene_to(teleport_scene)
	else:
		if TELEPORT_ROOM == "main_room":
			#print(get_tree())
			ERR = get_tree().change_scene("res://src_and_scenes/Rooms/Room1.tscn")
	
	if ERR != OK:
		print("something failed in the door scene")


func _on_Door_body_entered(body_p):
	if body_p.name == "Player":
		body_p.flash = true
		body = body_p
		$FlashTimer.start()

func _on_FlashTimer_timeout():
	if KILL_PLAYER == false:
		next_level()
		
	else:
		body.die()
