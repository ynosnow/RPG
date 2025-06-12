extends Button

var Talk_Stage : int = 0

func _on_pressed() -> void:
	if Talk_Stage == 0:
		Talk_Stage = randi_range(1, 4)
		%Panel.visible = true
		match Talk_Stage:
			0:
				%Panel.visible = false
			1:
				%DialogLabel.text = "9/11 was an inside job"
			2: 
				%DialogLabel.text = "Corona was made by the CIA"
			3:
				%DialogLabel.text = "The Earth is flat change my mind"
			4:
				%DialogLabel.text = "Skibidi"
	else:
		%Panel.visible = false
		Talk_Stage = 0
