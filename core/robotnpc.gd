extends KinematicBody2D

export(int) var distance = 10.0 setget setdist, getdist


#Platform speed
const speed = 30.0
var vel = Vector2(0.0, 0.0)

#Editor auxiliar variables
var startline = null
var endline = Vector2(distance, 0)
var direction = 1


#Set/get for the editor exported vars
func setdist(new_value):
	distance = new_value
	
	endline = Vector2(distance, 0)
	print(position, endline)
	
	update()

func getdist():
	return distance

# Called when the node enters the scene tree for the first time.
func _ready():
	startline = position
	$AnimationPlayer.play("walk")
	set_process(not Engine.editor_hint)

#Move the platform when in-game
func _process(delta):
	
	vel.x = speed * direction
	if direction == 1 and position.x >=  startline.x + endline.x:
		direction = -1
		$Sprite.flip_h = true
	elif direction == -1 and position.x <= startline.x:
		direction = +1
		$Sprite.flip_h = false
	
	move_and_slide(vel)

#Update a line in editor
func _draw():
	if Engine.editor_hint:
		draw_line(Vector2(0,0), endline, Color(1.0,0.0,0.0), 1.5)



