extends KinematicBody2D

const g = 20.0
const speed = 50.0
const jump_speed = 40.0

var vel = Vector2(0.0, 0.0)
var on_air
var currobj = null #object which you are interacting with

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
	
	move_and_slide(vel, Vector2(0,-1))

#	pass

#This function accounts for the movement of the character
func move_input(delta):
	on_air = not is_on_floor()
	
	#Direction where should I move
	if Input.is_action_pressed("ui_up") and not on_air:
		set_anim("walk")
		vel.y = -jump_speed
		on_air = true
		print("hola")
	#elif Input.is_action_pressed("ui_down"):
	#	set_anim("idle")
	#	vel = Vector2(0.0, 1.0)
	elif Input.is_action_pressed("ui_right"):
		set_anim("walk")
		$Sprite.flip_h = false
		vel.x = speed
	elif Input.is_action_pressed("ui_left"):
		set_anim("walk")
		$Sprite.flip_h = true
		vel.x = -speed
	else:
		set_anim("idle")
		vel.x = 0.0
	
	if on_air:
		vel.y += delta*g
	else:
		vel.y = 0
		
	if Input.is_action_just_pressed("ui_accionA") and currobj != null:
			currobj.act()

func set_anim(new_anim):
	if (new_anim != anim):
		$AnimationPlayer.play(new_anim)
		anim = new_anim
	




# update the current object
func _on_Area2D_area_entered(area):
	if area.name == "monitor":
		currobj = area
	#pass # Replace with function body.

# update the current object
func _on_Area2D_area_exited(area):
	currobj = null
	pass # Replace with function body.
