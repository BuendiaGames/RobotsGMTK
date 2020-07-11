extends Area2D

#tool

export(int) var longitud = 1 setget alargar, getlength
export(int) var check_pos = 16 setget setarea, getarea

const hook_speed = 30.0
var going_down = true
var robot = null

#Draws a larger hook
func alargar(new_value):
	longitud = new_value
	
	#Delete any children created before
	for c in $sprites.get_children():
		if "cadena" in c.name and c.name != "cadena":
			c.queue_free()
	
	
	#Generate new strings for the hook
	if longitud > 1:
		var cadena = null
		for j in range(longitud-1):
			cadena = $sprites/cadena.duplicate()
			cadena.position.y = -16 * (j+1)
			$sprites.add_child(cadena)

func getlength():
	return longitud


func setarea(new_value):
	check_pos = new_value
	$shape.position.y = new_value

func getarea():
	return check_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	robot = get_tree().root.get_node("level/robot")
	set_process(false)


#Start acting
func act():
	robot.set_process(false)
	set_process(true)

func _process(delta):
	#Go up and down!
	if going_down:
		$sprites.position.y += delta * hook_speed
		
		#Enough going down, pick player and go up
		if $sprites.position.y >= check_pos:
			going_down = false
			$sprites/gancho.region_rect.position.y += 16
			$timer.start()
	else:
		$sprites.position.y -= delta * hook_speed
		robot.position.y -= delta * hook_speed


func _on_gancho_timeout():
	get_node("../fadeout").fadeout()
	global.load_next_level()
