extends Button

var Talk_Stage : int = 0

func _on_pressed() -> void:
	%Panel.visible = true
	if Global.level_school == 0:
		match Talk_Stage:
			0: 
				%DialogLabel.text = "Hello I'm cyan Boy"
				Talk_Stage += 1
			1: 
				Talk_Stage = 0
				%Panel.visible = false
	elif Global.level_school == 1 or Global.level_school == 2:
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
				%DialogLabel.text = "after that you can come back to me"
				Talk_Stage += 1
			5: 
				%Panel.visible = false
				Talk_Stage = 0
				if Global.level_school == 1:
					Global.level_school = 2
					print(Global.level_school)
	elif Global.level_school == 3:
		match Talk_Stage:
			0: 
				%DialogLabel.text = "Now you have to program it in Arduino IDE"
				Talk_Stage += 1
			1: 
				%DialogLabel.text = "after that you can inform me"
				Talk_Stage += 1
			2: 
				%Panel.visible = false
				Talk_Stage = 0
	else:
		Global.level_school = 5
		match Talk_Stage:
			0: 
				Global.cyan_boy_important = false
				%DialogLabel.text = "thanks for helping out"
				Talk_Stage += 1
			1: 
				%DialogLabel.text = "I will now go to Mr. physics Teacher"
				Talk_Stage += 1
			2: 
				%Panel.visible = false
				Talk_Stage = 0
				
