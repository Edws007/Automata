extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Raio = 100
const Max_Dano = 150
var mov=Vector2.ZERO
var tempo = 0
var dano = 0
var theta = 0
var Pos_Inicial = Vector2.ZERO
var Sentido = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Pos_Inicial=get_parent().global_position
	randomize()
	theta = rand_range(-PI,PI)
	if randf()>0.5:
		Sentido=1
		$AnimationPlayer.play("Girando")
	else:
		Sentido = -1
		$AnimationPlayer.play_backwards("Girando")
	$Timer.start(rand_range(3,5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempo += delta
	mov.x = Raio*sin(2*PI*tempo/10+theta)
	mov.y = Sentido*Raio*cos(2*PI*tempo/10+theta)
	get_parent().global_position = Pos_Inicial+mov
	
func Tiro(Direcao):
	var cena_blast   = preload("res://Cena_Blast.tscn")
	var objeto_blast = cena_blast.instance()
	get_tree().root.add_child(objeto_blast)
	objeto_blast.global_position = $Position2D.global_position + 75*Direcao.normalized()
	objeto_blast.rotation = Direcao.angle()+PI/2

func Peao_Recarregado():
	Tiro(Vector2(1,0))
	Tiro(Vector2(-1,0))
	Tiro(Vector2(0.5,sqrt(3)/2))
	Tiro(Vector2(-0.5,sqrt(3)/2))
	Tiro(Vector2(0.5,-sqrt(3)/2))
	Tiro(Vector2(-0.5,-sqrt(3)/2))
	$Timer.start(rand_range(3,5))

func Acerto_Dano(area):
	if area.name =='Laser':
		dano += Geral.dano_laser
		if dano>= Max_Dano:
			if randf()>0.8:
				var itemdrop   = preload("res://Cena_PowerUp.tscn")
				var objeto_item = itemdrop.instance()
				get_tree().root.add_child(objeto_item)
				objeto_item.global_position = $Position2D.global_position
			get_parent().queue_free()

func Toque_Dano(body):
	if body.name == 'Corpo_Personagem':
		if Geral.campo>=Geral.dano_blast:
			Geral.campo-=Geral.dano_blast
			#print(Geral.campo)
		elif Geral.campo>0:
			Geral.saude-=Geral.dano_blast-Geral.campo
			Geral.campo=0
		else:
			Geral.saude-=Geral.dano_blast

