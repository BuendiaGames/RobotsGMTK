extends Node2D


const extra = 4.0

var texto
var texto2
var elapsed_time 
var next_char = 0.05
var j 
var controles = false


# Called when the node enters the scene tree for the first time.
func _ready():
	j=0
	elapsed_time = 0.0
	$Label3.hide()
	$Label4.hide()
	texto = $Label2.text
	texto2 = $Label4.text
	$Label2.text = ""
	$Label4.text = ""
	$robotnpc/AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
		
	if j < len(texto) and not controles:
		if elapsed_time >= next_char:
			elapsed_time = 0.0
			$Label2.text += texto[j]
			next_char = rand_range(0.001, 0.12)
			j += 1		
	elif not controles:
		if elapsed_time >= next_char+extra:
			elapsed_time = 0.0
			j = 0
			$Label2.hide()
			$Label4.show()
			controles = true
	
	if j < len(texto2) and controles:
		if elapsed_time >= next_char:
			elapsed_time = 0.0
			$Label4.text += texto2[j]
			next_char = rand_range(0.001, 0.12)
			j += 1
			
	if j >= len(texto2) and elapsed_time >= next_char and controles:
		$Label3.show()
		
	if Input.is_action_just_pressed("ui_accionA"):
		$fadeout.fadeout()
		global.start()
	
	
