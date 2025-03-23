extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocidade = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print(get_parent().rotation_degrees)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().global_position.y += velocidade*sin(get_parent().rotation)
	get_parent().global_position.x += velocidade*cos(get_parent().rotation)


func Laser_hit(body):
	get_parent().queue_free()



func Laser_Area(area):
	get_parent().queue_free()
