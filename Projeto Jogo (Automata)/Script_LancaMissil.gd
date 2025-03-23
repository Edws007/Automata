extends Area2D

const Max_Dano = 100
var alcance = 500
var tempo_disparo = 15
var mira = Vector2.ZERO
var radar = false
var dano = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	radar=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mira = Geral.rastro-$Position2D.global_position
	if mira.length()<2*alcance:
		rotation=mira.angle()
	if mira.length()<alcance and radar:
		get_node("Missil").visible=false
		radar= false
		Tiro()
		$Timer.start(tempo_disparo)

func Tiro():
	var cena_blast   = preload("res://Cena_Missil.tscn")
	var objeto_blast = cena_blast.instance()
	get_tree().root.add_child(objeto_blast)
	objeto_blast.global_position = $Position2D.global_position
	objeto_blast.rotation = mira.angle()
	$Tiro_Inimigo.play(0)

func Torreta_Recarregada():
	radar=true
	get_node("Missil").visible=true

func Acerto_Dano(area):
	if area.name =='Laser' or area.name =='Blast' or area.name =='Missil':
		dano += Geral.dano_laser
		if dano>= Max_Dano:
			if randf()>0.8:
				var itemdrop   = preload("res://Cena_VidaUp.tscn")
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
			print(Geral.saude)
		else:
			Geral.saude-=Geral.dano_blast
			print(Geral.saude)
