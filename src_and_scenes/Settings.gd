extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var root = $Tree.create_item()
	#tree.set_hide_root(true)
	
	var child1 = $Tree.create_item(root)
	var child2 = $Tree.create_item(root)
	var subchild1 = $Tree.create_item(child1)
	subchild1.set_text(0, "Subchild1")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
