extends Control

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		
		
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Jogar":
			var _game: bool = get_tree().change_scene("res://Cena_Fase1.tscn")
			
		"Sair":
			get_tree().quit()
			
			
func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
