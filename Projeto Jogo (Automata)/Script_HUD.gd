extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Barra_Campo.max_value = Geral.campo_inicial
	$Barra_Vida.max_value = Geral.saude_inicial


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Barra_Campo.value = Geral.campo
	$Barra_Vida.value = Geral.saude
#	pass
