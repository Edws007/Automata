extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#visible = false
	$CanvasLayer.visible=false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("Pause")):
		$CanvasLayer.visible = not $CanvasLayer.visible
		get_tree().paused = $CanvasLayer.visible
