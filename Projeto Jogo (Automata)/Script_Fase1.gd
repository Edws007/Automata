extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Personagem/Corpo_Personagem/Camera2D.limit_left = -288
	$Personagem/Corpo_Personagem/Camera2D.limit_right = 3040
	$Personagem/Corpo_Personagem/Camera2D.limit_top = -1184
	$Personagem/Corpo_Personagem/Camera2D.limit_bottom = 1568
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
