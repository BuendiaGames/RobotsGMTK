extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# play level 1
func _on_Button_pressed():
	$fadeout.fadeout()
	global.start()
	print("hago")
	pass # Replace with function body.

# play level 2
func _on_Button2_pressed():
	$fadeout.fadeout()
	global.goto_scene("res://levels/level-3.tscn")
	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().quit()
	pass # Replace with function body.
