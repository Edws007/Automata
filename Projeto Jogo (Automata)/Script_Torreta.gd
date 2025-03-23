extends Area2D

const Max_Dano = 50
var alcance = 500
var tempo_disparo = 0.5
var mira = Vector2.ZERO
var radar = false
var cano = 10
var dano = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	radar=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mira = Geral.rastro-$Position2D.global_position
	if mira.length()<2*alcance:
		rotation=mira.angle()
	if mira.length()<alcance:
		get_node("Desligada").visible=false
		get_node("Ligada").visible=true
		if radar:
			#print("Atirar!")
			radar= false
			Tiro()
			$Timer.start(tempo_disparo)
	else:
		get_node("Desligada").visible=true
		get_node("Ligada").visible=false

func Tiro():
	var cena_blast   = preload("res://Cena_Blast.tscn")
	var objeto_blast = cena_blast.instance()
	get_tree().root.add_child(objeto_blast)
	objeto_blast.global_position = $Position2D.global_position + 75*mira.normalized() +cano*Vector2(mira.y,mira.x).normalized()
	objeto_blast.rotation = mira.angle()
	cano *=-1
	$Tiro_Inimigo.play(0)

func Torreta_Recarregada():
	radar=true

func Acerto_Dano(area):
	if area.name =='Laser' or area.name =='Blast' or area.name =='Missil':
		dano += Geral.dano_laser
		if dano>= Max_Dano:
			if randf()>0.8:
				var itemdrop   = preload("res://Cena_CampoUp.tscn")
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
