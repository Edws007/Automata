extends Area2D
var tempo_disparo = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	monitoring=true


func Tempo_Radar(body):
	if (body.name=="Corpo_Personagem"):
		$Timer.start(5)
		print(monitoring)
