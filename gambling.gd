extends Node2D

func _on_red_pressed() -> void:
	var Random = randi_range(1, 16)
	var betting_value = $SpinBox.value
	if betting_value <= Global.cash:
		if Random <= 6:
			Global.cash = Global.cash + betting_value
			%DialogLabel.text = "You have won, now you have " + str(Global.cash) + " Money"
		else:
			Global.cash = Global.cash - betting_value
			if Random >= 15:
				%DialogLabel.text = "It was Green, now you have " + str(Global.cash) + " Money"
			else:
				%DialogLabel.text = "It was Black, now you have " + str(Global.cash) + " Money"
	else:
		%DialogLabel.text = "You have only have " + str(Global.cash) + " Money"

func _on_black_pressed() -> void:
	var Random = randi_range(1, 16)
	var betting_value = $SpinBox.value
	if betting_value <= Global.cash:
		if Random <= 14 and Random >= 7:
			Global.cash = Global.cash + betting_value
			%DialogLabel.text = "You have won, now you have " + str(Global.cash) + " Money"
		else:
			Global.cash = Global.cash - betting_value
			if Random <= 6:
				%DialogLabel.text = "It was Red, now you have " + str(Global.cash) + " Money"
			else:
				%DialogLabel.text = "It was Green, now you have " + str(Global.cash) + " Money"
	else:
		%DialogLabel.text = "You have only have " + str(Global.cash) + " Money"

func _on_green_pressed() -> void:
	var Random = randi_range(1, 16)
	var betting_value = $SpinBox.value
	if betting_value <= Global.cash:
		if Random >= 15:
			Global.cash = Global.cash + betting_value*3
			%DialogLabel.text = "You have won, now you have " + str(Global.cash) + " Money"
		else:
			Global.cash = Global.cash - betting_value
			if Random <= 6:
				%DialogLabel.text = "It was Red, now you have " + str(Global.cash) + " Money"
			else:
				%DialogLabel.text = "It was Black, now you have " + str(Global.cash) + " Money"
	else:
		%DialogLabel.text = "You have only have " + str(Global.cash) + " Money"


func _on_exit_pressed() -> void:
	await get_tree().change_scene_to_file("res://casino.tscn")
<<<<<<< HEAD
	
func _process(delta: float) -> void:
	if Global.cash == 0:
		get_tree().change_scene_to_file("res://Credits.tscn")
=======
>>>>>>> a8e63f4c4dada4d13fd92272928fa07512fce834
