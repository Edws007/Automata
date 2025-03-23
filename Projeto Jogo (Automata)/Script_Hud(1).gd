extends ParallaxBackground

func _ready():
	pass

func _process(delta):
	$Campo.scale.x=0.2*Geral.campo/Geral.campo_inicial
	$Campo.position.x=10+1000*$Campo.scale.x/2
	#print ($Campo.scale.x)
	$Saude.scale.x=0.2*Geral.saude/Geral.saude_inicial	
	$Saude.position.x=10+1000*$Saude.scale.x/2
