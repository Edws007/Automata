extends KinematicBody2D

const velocidade = 300
const dash = 5000
const carga_campo = 5

var angulo = 0
var joy_angulo = Vector2.ZERO
var joy_anda = Vector2.ZERO
var teclado_wasd = Vector2.ZERO
var mouse_pos = Vector2.ZERO
var mouse_olha = Vector2.ZERO
var entrada = ''
var especial = false
var Vivo = true
# Called when the node enters the scene tree for the first time.
func _ready():
	entrada = ''
	especial = false
	$AnimationPlayer.play("Parado")
	Vivo=true
	
func _process(delta):
	if Geral.saude>0:
		var mov=Vector2.ZERO
		
		joy_anda = Input.get_vector("A1_Left","A1_Right","A1_Up","A1_Down")
		joy_angulo = Input.get_vector("A2_Left","A2_Right","A2_Up","A2_Down")
		teclado_wasd = Input.get_vector("T_Left","T_Right","T_Up","T_Down")
		mouse_pos=get_global_mouse_position()
		
		if joy_anda.length()>0:
			entrada='controle'
		elif teclado_wasd.length()>0:
			entrada='teclado'
		
		if	entrada=='controle':
			
			if (joy_angulo.length()>0):
				angulo=joy_angulo.angle()
			elif(joy_anda.length()>0):
				angulo=joy_anda.angle()
				#print (angulo)
			rotation=angulo
			mov =+velocidade*joy_anda
			if joy_anda.length()>0:
				if abs(joy_anda.angle()-angulo)<PI/2:
					$AnimationPlayer.play("Movendo")
				else:
					$AnimationPlayer.play_backwards("Movendo")
			else:
				$AnimationPlayer.play("Parado")
		elif entrada=='teclado':
			mouse_olha=mouse_pos-$Position2D.global_position
			#print(mouse_olha.normalized().y )
			angulo=mouse_olha.angle()
			#print(mouse_olha.normalized().x)
			rotation=angulo
			mov.x =+ velocidade*(-mouse_olha.normalized().x*teclado_wasd.y-mouse_olha.normalized().y*teclado_wasd.x)
			mov.y =+ velocidade*(-mouse_olha.normalized().y*teclado_wasd.y+mouse_olha.normalized().x*teclado_wasd.x)
		
		mov=move_and_slide(mov)
		Geral.rastro=$Position2D.global_position
		
		if Input.is_action_just_pressed("Dash_Left"):
			mov.x =+ dash*sin(rotation)
			mov.y =- dash*cos(rotation)
			mov=move_and_slide(mov)
			
		if Input.is_action_just_pressed("Dash_Right"):
			mov.x =- dash*sin(rotation)
			mov.y =+ dash*cos(rotation)
			mov=move_and_slide(mov)
		
		if Input.is_action_just_pressed("Dash_Foward"):
			mov.x =+ dash*cos(rotation)
			mov.y =+ dash*sin(rotation)
			mov=move_and_slide(mov)
		
		if Geral.laser_especial:
			Geral.laser_especial = false
			especial=true
			$Powerup_Pega.play(0)
			$Timer.start(5)
		
		if (Input.is_action_just_pressed("Laser")):
			var cena_disparo   = preload("res://Cena_Laser.tscn")
			var objeto_disparo = cena_disparo.instance()
			get_tree().root.add_child(objeto_disparo)
			objeto_disparo.global_position = $Position2D.global_position + Vector2(75*cos(angulo),75*sin(angulo))
			objeto_disparo.rotation = angulo
			if especial:
				$Powerup_Atira.play(0)
				var objeto_disparo_e = cena_disparo.instance()
				var objeto_disparo_d = cena_disparo.instance()
				get_tree().root.add_child(objeto_disparo_e)
				get_tree().root.add_child(objeto_disparo_d)
				objeto_disparo.get_node("Laser/Laser_Padrão").visible=false
				objeto_disparo.get_node("Laser/Laser_Especial").visible=true
				objeto_disparo_e.get_node("Laser/Laser_Padrão").visible=false
				objeto_disparo_e.get_node("Laser/Laser_Especial").visible=true
				objeto_disparo_d.get_node("Laser/Laser_Padrão").visible=false
				objeto_disparo_d.get_node("Laser/Laser_Especial").visible=true
				objeto_disparo_e.global_position = $Position2D.global_position + Vector2(75*cos(angulo)+25*sin(angulo),75*sin(angulo)-25*cos(angulo))
				objeto_disparo_d.global_position = $Position2D.global_position + Vector2(75*cos(angulo)-25*sin(angulo),75*sin(angulo)+25*cos(angulo))
				objeto_disparo_e.rotation = angulo
				objeto_disparo_d.rotation = angulo
			else:
				$Tiro_Comum.play(0)
		
		if Geral.campo<Geral.campo_inicial-carga_campo:
			Geral.campo+=carga_campo*delta
		else:
			Geral.campo=Geral.campo_inicial
	elif Vivo:
		Vivo=false
		Geral.rastro=Vector2.ZERO
		$AnimationPlayer.play("Morte")
		$Morte.play()

func Especial_Fim():
	especial=false

func Morte_Personagem():
	Geral.resetar()
	get_tree().change_scene("res://Cena_GameOver.tscn")
