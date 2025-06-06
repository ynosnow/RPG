extends Button

var Talk_Stage : int = 0

func _on_pressed() -> void:
	%Panel.visible = true
	match Talk_Stage:
		0: 
			%DialogLabel.text = "I will go to Mr. physics Teacher"
			Talk_Stage += 1
		1: 
			%DialogLabel.text = "But I need you help"
			Talk_Stage += 1
		2: 
			%DialogLabel.text = "I need help with soldering"
			Talk_Stage += 1
		3: 
			%DialogLabel.text = "at Working Bench on the left "
			Talk_Stage += 1
		4: 
			%Panel.visible = false
			Talk_Stage = 0
