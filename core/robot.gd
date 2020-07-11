extends KinematicBody2D

const speed = 10.0

var vel = Vector2(0.0, 0.0)

var anim = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_input(delta) #Make the movement
	
	move_and_slide(speed * vel)

#	pass

#This function accounts for the movement of the character
func move_input(delta):
	#Direction where should I move
	if Input.is_action_pressed("ui_up"):
		set_anim("idle")
		vel = Vector2(0.0, -1.0)
	elif Input.is_action_pressed("ui_down"):
		set_anim("idle")
		vel = Vector2(0.0, 1.0)
	elif Input.is_action_pressed("ui_right"):
		set_anim("walk")
		$Sprite.flip_h = false
		vel = Vector2(1.0, 0.0)
	elif Input.is_action_pressed("ui_left"):
		set_anim("walk")
		$Sprite.flip_h = true
		vel = Vector2(-1.0, 0.0)
	else:
		set_anim("idle")
		vel = Vector2(0.0, 0.0)

func set_anim(new_anim):
	if (new_anim != anim):
		$AnimationPlayer.play(new_anim)
		anim = new_anim
	


