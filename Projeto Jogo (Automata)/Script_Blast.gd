extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocidade = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().global_position.x += velocidade*cos(get_parent().rotation)
	get_parent().global_position.y += velocidade*sin(get_parent().rotation)


func Blast_hit(body):
	if body.name == 'Corpo_Personagem':
		if Geral.campo>=Geral.dano_blast:
			Geral.campo-=Geral.dano_blast
		elif Geral.campo>0:
			Geral.saude-=Geral.dano_blast-Geral.campo
			Geral.campo=0
		else:
			Geral.saude-=Geral.dano_blast
	get_parent().queue_free()
