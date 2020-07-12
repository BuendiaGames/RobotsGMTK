extends Node2D


var texto
var elapsed_time 
var next_char = 0.05
var j 


# Called when the node enters the scene tree for the first time.
func _ready():
	j=0
	elapsed_time = 0.0
	$Label3.hide()
	texto = $Label2.text
	print(texto)
	$Label2.text = ""
	$robotnpc/AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
		
	if (j < len(texto)):
		if elapsed_time >= next_char:
			elapsed_time = 0.0
			$Label2.text += texto[j]
			next_char = rand_range(0.001, 0.12)
			j += 1
			
	if j >= len(texto) and elapsed_time >= next_char:
		$Label3.show()
		
	if Input.is_action_just_pressed("ui_accionA"):
		$fadeout.fadeout()
		global.start()
	
	
