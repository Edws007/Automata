extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Max_Dano = 1000
const Max_Dist = 200
const Vel_Mov = 2
const Vel_Ataque= 10
const Tempo_Disparo = 0.5
var mov=Vector2.ZERO
var tempo = 0
var dano = 0
var pos_inicial = Vector2.ZERO
var pos_ataque = Vector2.ZERO
var pos_final = Vector2.ZERO
var Velocidade = 0
var Vida = false
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Vida = true
	$Corpo.visible = true
	$Esplosao.visible = false
	$Timer.start(2*Tempo_Disparo)
	pos_inicial=get_parent().global_position
	pos_final = get_parent().global_position + Vector2(rand_range(-Max_Dist,Max_Dist),rand_range(-Max_Dist,Max_Dist)) + (Geral.rastro-get_parent().global_position)/10
	Velocidade=Vel_Mov

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dano<Max_Dano:
		mov = Velocidade*(pos_final-pos_inicial).normalized()
		get_parent().global_position += mov
		if (get_parent().global_position-pos_final).length_squared()<pow(Velocidade,2):
			pos_inicial=get_parent().global_position
			if randf()>0.9-0.4*dano/Max_Dano:
				pos_final=Geral.rastro
				Velocidade=Vel_Ataque
			else:
				pos_final = get_parent().global_position + Vector2(rand_range(-Max_Dist,Max_Dist),rand_range(-Max_Dist,Max_Dist)) + (Geral.rastro-get_parent().global_position).normalized()*Max_Dist
				Velocidade=Vel_Mov
	elif Vida:
		Vida = false
		$Esplosao.visible=true
		$AnimationPlayer.play("Morrendo")
	
	
func Tiro(Direcao):
	var cena_blast   = preload("res://Cena_Blast.tscn")
	var objeto_blast = cena_blast.instance()
	get_tree().root.add_child(objeto_blast)
	objeto_blast.global_position = $Position2D.global_position + 75*Direcao.normalized()
	objeto_blast.rotation = Direcao.angle()+PI/2

func Peao_Recarregado():
	Tiro(Vector2(1,0))
	Tiro(Vector2(-1,0))
	Tiro(Vector2(0,1))
	Tiro(Vector2(0,-1))
	Tiro(Vector2(1,1))
	Tiro(Vector2(-1,1))
	Tiro(Vector2(1,-1))
	Tiro(Vector2(-1,-1))
	$Timer.start(Tempo_Disparo)

func Acerto_Dano(area):
	if area.name =='Laser':
		dano += Geral.dano_laser

func Ataque_Personagem(body):
	if body.name =='corpo_Personagem':
		if Geral.campo>=Geral.dano_blast:
			Geral.campo-=Geral.dano_blast
		elif Geral.campo>0:
			Geral.saude-=Geral.dano_blast-Geral.campo
			Geral.campo=0
		else:
			Geral.saude-=Geral.dano_blast

func Fim_Animacao(anim_name):
	if anim_name == "Morrendo":
		#get_parent().queue_free()
		get_tree().change_scene("res://Inicio/Menu.tscn")
