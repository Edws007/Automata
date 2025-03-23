extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var raio = 75
var voltas_minuto = 10
var mov=Vector2.ZERO
var tempo=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempo += delta
	#print(tempo)
	mov.x=raio*-sin(2*PI*voltas_minuto/60*tempo)
	mov.y=raio*cos(2*PI*voltas_minuto/60*tempo)
	mov=move_and_slide(mov)
	
