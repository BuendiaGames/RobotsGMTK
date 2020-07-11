extends Area2D


#Show it with a base or not
export (int, "Base", "NoBase") var base = 0

#The node to act over when this computer is activated
export (NodePath) var linkedNode = null


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Show base or not
	if base == 0:
		$legs.show()
	else:
		$legs.hide()
	
	#We do not need any specific process
	set_process(false)

#Do the action when activated
func act():
	
	#Delete the linked node
	if linkedNode != null:
		linkedNode.queue_free()
	
