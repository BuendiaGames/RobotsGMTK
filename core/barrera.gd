extends StaticBody2D

# red = 0, blue = 1
export(int, "red", "blue") var color = 0 

var is_activated
#var tiempo = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("barreras")
	if color == 0:
		$AnimationPlayer.play("roja")
		is_activated = true
		$Sprite.show()
	else:
		$AnimationPlayer.play("azul")
		is_activated = false
		$Sprite.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	#tiempo += delta
	# if it is activated you can collide with it, otherwise not
	if is_activated:
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(0, true)
		$Sprite.show()
	else:
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		$Sprite.hide()
		
	#if tiempo >= 5:
	#	tiempo = 0
	#	change_activated()
	
#	pass

# change if a barrier is activated or not
func change_activated():
	is_activated = not is_activated
