extends Node

const dano_laser = 10
const dano_blast = 25
const dano_missil = 150
const saude_inicial = 250
const campo_inicial = 100

var fase = 0
var campo = 0
var saude = 0
var rastro = Vector2.ZERO
var laser_especial = false

# Called when the node enters the scene tree for the first time.
func _ready():
	resetar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func resetar():
	fase = 0
	campo = campo_inicial
	saude = saude_inicial
	laser_especial=false

func ChamaFase():
	fase+=1
	match fase:
		1:
			get_tree().change_scene("res://Cena_Fase1.tscn")
		2:
			get_tree().change_scene("res://Cena_Fase2.tscn")
		3:
			get_tree().change_scene("res://Cena_Fase_Final.tscn")
		_:
			resetar()
			get_tree().change_scene("res://Inicio/Menu.tscn")
	
