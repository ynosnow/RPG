extends Node

@onready var player: CharacterBody2D = $Player
var Talk_Stage : int = 0
var Test_points : int = 0
var solution : String = ""
signal closed
var test_finished = false



func _ready():
	player.can_move = false
	%TestInput.visible = false
		

func _on_next_btn_pressed() -> void:

	if Talk_Stage == 10:
		solution = %TestInput.get_text()
		if solution == "117N":
			print("RICHTIG")
			Test_points += 3
		else:
			print("FALSCH")
		print(Test_points)
		%Story.text = "2.) 1.7mach in XXXm/s Format? (2P)"
		%TestInput.text = ""

	elif Talk_Stage == 11:
		solution = %TestInput.get_text()
		if solution == "578m/s":
			print("RICHTIG")
			Test_points += 2
		else:
			print("FALSCH")
		print(Test_points)
		%Story.text = "3.) A body has a density of 870 kg/m3 and a mass of 120 kg. State the volume in X.XXXm3 Format. (3P)"
		%TestInput.text = ""

	elif Talk_Stage == 12:
		solution = %TestInput.get_text()
		if solution == "0.138m3":
			print("RICHTIG")
			Test_points += 3
		else:
			print("FALSCH")
		print(Test_points)
		%Story.text = "4.) A business trip lasts from 7:32 to 12:14. The mileage has changed from 125,954 km to 126,621 km. What is the average speed in XXX.Xkm/h? (4P)"
		%TestInput.text = ""

	elif Talk_Stage == 13:
		solution = %TestInput.get_text()
		if solution == "141.9km/h":
			print("RICHTIG")
			Test_points += 4
		else:
			print("FALSCH")
		print(Test_points)
		%Story.text = "5.) An airplane is flying at 2100 km/h at an altitude of 14 km at a temperature of -60°C. How fast is the airplane traveling at Mach in X.XXmach? (Hint: First calculate the speed in m/s) (5P)"
		%TestInput.text = ""

	elif Talk_Stage == 14:
		solution = %TestInput.get_text()
		if solution == "1.99mach":
			print("RICHTIG")
			Test_points += 5
		else:
			print("FALSCH")
		print(Test_points)
		%Story.text = "OK Let's check the answers"
		%TestInput.visible = false
		%"Next_Btn".visible = false
		test_finished = true
		
	Talk_Stage += 1
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and Talk_Stage < 9:
		Talk_Stage += 1
		if Talk_Stage == 1:
			%Story.text = "The Class: Good morning mister Teacher!"
		if Talk_Stage == 2:
			%Story.text = "Good"
		if Talk_Stage == 3:
			%Story.text = "Sit Down Class!"
		if Talk_Stage == 4:
			%Story.text = "Today is the Day of the Test"
		if Talk_Stage == 5:
			%Story.text = "If you fuck up, It's over!"
		if Talk_Stage == 6:
			%Story.text = "except you have 5 Million Euros left over HAHAHAHA"
		if Talk_Stage == 7:
			%Story.text = "Good Luck!"
		if Talk_Stage == 8:
			%Story.text = ""
			%Test.visible = true
		if Talk_Stage == 9:
			Talk_Stage+=1
			%Story.text = "1.) What is the weight of 12kg? Write the Answers in unrounded XXXN Format (3P)"
			%Next_Btn.visible = true
			%TestInput.visible = true
			%TestInput.text = "Write your solution here..."

	elif (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and Talk_Stage == 15:
		if test_finished == true:
			%Next_Btn.visible = false
			if Test_points == 17:
				%Story.text = "You got a 100%! You have definitely a bright future ahead"
				emit_signal("closed")
				await closed
				get_tree().change_scene_to_file("res://credits.tscn")
			else:
				%Story.text = "You didn't score well. You got %d/17 Points. You are definitely fucked now" % Test_points
				emit_signal("closed")
				await closed
				get_tree().change_scene_to_file("res://Assets/School.tscn")
			Global.hide_menu_on_start = true
			Global.intro_completed = true
