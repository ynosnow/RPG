extends Button

var Talk_Stage : int = 0

func _on_pressed() -> void:
	%Panel.visible = true
	match Talk_Stage:
		0: 
			%DialogLabel.text = "Hello I'm cyan Boy"
			Talk_Stage += 1
		1: 
			Talk_Stage = 0
			%Panel.visible = false
