extends Node2D

var counter : int = 0

func _process(_delta: float) -> void:
	if counter == 12:
		%Soldering2.visible = true
		%Button13.visible = true
		%Button14.visible = true
		%Button15.visible = true
		%Button16.visible = true
	elif counter == 16:
		%Soldering3.visible = true
		%Button17.visible = true
	else:
		pass

func _on_button_pressed() -> void:
	%Button.visible = false
	counter += 1

func _on_button_2_pressed() -> void:
	%Button2.visible = false
	counter += 1

func _on_button_3_pressed() -> void:
	%Button3.visible = false
	counter += 1

func _on_button_4_pressed() -> void:
	%Button4.visible = false
	counter += 1

func _on_button_5_pressed() -> void:
	%Button5.visible = false
	counter += 1

func _on_button_6_pressed() -> void:
	%Button6.visible = false
	counter += 1

func _on_button_7_pressed() -> void:
	%Button7.visible = false
	counter += 1

func _on_button_8_pressed() -> void:
	%Button8.visible = false
	counter += 1

func _on_button_9_pressed() -> void:
	%Button9.visible = false
	counter += 1

func _on_button_10_pressed() -> void:
	%Button10.visible = false
	counter += 1

func _on_button_11_pressed() -> void:
	%Button11.visible = false
	counter += 1

func _on_button_12_pressed() -> void:
	%Button12.visible = false
	counter += 1

func _on_button_13_pressed() -> void:
	%Button13.visible = false
	counter += 1

func _on_button_14_pressed() -> void:
	%Button14.visible = false
	counter += 1

func _on_button_15_pressed() -> void:
	%Button15.visible = false
	counter += 1

func _on_button_16_pressed() -> void:
	%Button16.visible = false
	counter += 1

func _on_button_17_pressed() -> void:
	Global.level_school = 3
	Global.changed_from_solder = true
	await get_tree().change_scene_to_file("res://Assets/School.tscn")
