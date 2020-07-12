extends KinematicBody2D

const g = 20.0 * 14
const speed = 70.0 
const jump_speed = 40.0 * 3.742

var vel = Vector2(0.0, 0.0)
var on_air
var currobj = null #object which you are interacting with

var anim = ""

const tau = 50.0 #Average time to change, in seconds
const tau_rnd = 10.0

#To make all input changes, these are available actions
const actions = ["right", "left", "up", "down", "accionA"]
var default_inputs = {}
var current_action = "idle"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	#Store the default inputs we use
	store_default_inputs()
	
	set_process(true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_input(delta) #Make the movement
	
	#Snap to avoid artifacts in platforms
	var snap = Vector2(0, 16)
	if on_air:
		snap = Vector2(0,0)
	
	move_and_slide_with_snap(vel, snap, Vector2(0,-1))

#This function accounts for the movement of the character
func move_input(delta):
	on_air = not is_on_floor()
	
	#Direction where should I move
	if Input.is_action_pressed("ui_up") and not on_air:
		set_anim("walk")
		vel.y = -jump_speed
		on_air = true
		current_action = "ui_up"
	elif Input.is_action_pressed("ui_right"):
		set_anim("walk")
		$Sprite.flip_h = false
		vel.x = speed
		current_action = "ui_right"
	elif Input.is_action_pressed("ui_left"):
		set_anim("walk")
		$Sprite.flip_h = true
		vel.x = -speed
		current_action = "ui_left"
	else:
		set_anim("idle")
		current_action = "idle"
		vel.x = 0.0
	
	#Go down
	if on_air:
		vel.y += delta*g
	else:
		vel.y = 0
		
	if Input.is_action_just_pressed("ui_accionA") and currobj != null:
		currobj.act()



#Changes current animation
func set_anim(new_anim):
	if (new_anim != anim):
		$AnimationPlayer.play(new_anim)
		anim = new_anim


#Stores all the InputEvents in a dictionary so all of them are available
func store_default_inputs():
	
	
	for action in actions:
		action = "ui_" + action
		default_inputs[action] = InputMap.get_action_list(action)[0]


#Change all keys 
func shuffle_input_map():
	
	var nact = len(actions)
	var indices = range(nact)
	
	indices.shuffle()
	
	var action1 #Actions in order
	var action2 #Shuffled stuff
	
	for j in range(nact):
		action1 = "ui_" + actions[j]
		action2 = "ui_" + actions[indices[j]]
		InputMap.action_erase_events(action1)
		InputMap.action_add_event(action1, default_inputs[action2])
	

#Shuffle input map and reinit the counter
func _on_timeout():
	$timer.wait_time = tau + tau_rnd * (2*randf()-1)
	release_key()
	shuffle_input_map() 
	# aqui
	
#Reases the key that is actually pressed to avoid
#confounding the input when the shuffle happens
func release_key():
	if current_action != "idle":
		var ev = InputEventAction.new()
		ev.action = current_action
		ev.pressed = false
		Input.parse_input_event(ev)
	
# update the current object
func _on_Area2D_area_entered(area):
	if "monitor" in area.name:
		currobj = area
	elif "gancho" == area.name:
		currobj = area
	
	#pass # Replace with function body.

# update the current object
func _on_Area2D_area_exited(area):
	currobj = null


#If collides with enemy, it's dead
func _on_Area2D_body_entered(body):
	if "npc" in body.name:
		get_node("../fadeout").fadeout()
		global.retry_level()

