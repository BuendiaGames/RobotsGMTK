extends KinematicBody2D

tool

export(int) var distance = 10.0 setget setdist, getdist
export(int, "H", "V") var mode = 0 setget setmode, getmode

#Platform speed
const speed = 30.0
var vel = Vector2(0.0, 0.0)

#Mode 
const H = 0
const V = 1

#Editor auxiliar variables
var startline = null
var endline = null
var direction = 1


#Set/get for the editor exported vars
func setdist(new_value):
	distance = new_value
	
	if mode == H:
		endline = Vector2(distance, 0) + position
	elif mode == V:
		endline = Vector2(0, distance) + position

	update()

func getdist():
	return distance

func setmode(new_value):
	mode = new_value
	update()

func getmode():
	return mode




# Called when the node enters the scene tree for the first time.
func _ready():
	startline = position
	set_process(not Engine.editor_hint)

#Move the platform when in-game
func _process(delta):
	if mode == H:
		vel.x = speed * direction
		if direction == 1 and position.x >= endline:
			direction = -1
		elif direction == -1 and position.x <= startline:
			direction = +1
	else:
		vel.y = speed * direction
		if direction == 1 and position.y >= endline:
			direction = -1
		elif direction == -1 and position.y <= startline:
			direction = +1


#Update a line in editor
func _draw():
	if Engine.editor_hint:
		draw_line(position, endline, Color(1.0,0.0,0.0), 1.5)



