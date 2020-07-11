extends StaticBody2D

# red = 0, blue = 1
export(int, "red", "blue") var color = 0 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if color == 0:
		$AnimationPlayer.play("roja")
	else:
		$AnimationPlayer.play("azul")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
