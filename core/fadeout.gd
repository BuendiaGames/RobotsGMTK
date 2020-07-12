extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	fadein()

#Position this to get the entire screen
func reposition():
	var view = get_viewport_rect().size
	rect_position = - 0.5 *view
	rect_size = 2*view
	show()

func fadein():
	reposition()
	$anim.play("fade-in")

func fadeout():
	reposition()
	$anim.play("fade-out")
