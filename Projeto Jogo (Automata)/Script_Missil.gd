extends Area2D

const acelera = 0.5
const alcance = 1500
const omega= 10

var tempo = 10
var mira = Vector2.ZERO
var mov = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print(get_parent().rotation_degrees)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempo += delta
	mira=Geral.rastro - $Position2D.global_position
	mov.x=acelera*tempo*cos(get_parent().rotation)
	mov.y=acelera*tempo*sin(get_parent().rotation)
	get_parent().global_position += mov
	if mira.dot(mov)> 0 and mira.length()<=alcance:
		get_parent().rotation-=mira.angle_to(mov)/omega
		
func Missil_hit(body):
	if body.name == 'Corpo_Personagem':
		if Geral.campo>=Geral.dano_missil:
			Geral.campo-=Geral.dano_missil
		elif Geral.campo>0:
			Geral.saude=Geral.dano_missil-Geral.campo
			Geral.campo=0
		else:
			Geral.saude-=Geral.dano_missil
	get_parent().queue_free()


func Misssil_Down(area):
	if not area.name =="LancaMissil":
		get_parent().queue_free()
