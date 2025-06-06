extends Button

var Talk_Stage : int = 0

func _on_pressed() -> void:
	%Panel.visible = true
	match Talk_Stage:
		0: 
			%DialogLabel.text = "The School is closed"
			Talk_Stage += 1
		1: 
			%DialogLabel.text = "First you have to find cyan Boy"
			Talk_Stage += 1
		2: 
			%DialogLabel.text = "Good Luck!"
			Talk_Stage += 1
		3: 
			%Panel.visible = false
			Talk_Stage = 0
