extends Node2D

var talkstage = 0

func _on_browser_btn_pressed() -> void:
	%Browser.visible = true
	%Browser_close.visible = true

func _on_browser_close_pressed() -> void:
	%Home.visible = false
	%Browser.visible = false
	%Altium.visible = false
	%Altium22Loading.visible = false
	%ArduinoIde.visible = false
	%Cisco.visible = false
	%CrystalDisk.visible = false
	%Discord.visible = false
	%Browser_close.visible = false

func _on_home_btn_pressed() -> void:
	if talkstage == 0:
		if %Home.visible == true:
			%Home.visible = false
			%Altium22.visible = false
			%Altium24.visible = false
			%ArduinoIdeBtn.visible = false
			%CiscoBtn.visible = false
			%CrystalDiskBtn.visible = false
			%DiscordBtn.visible = false
			%shutDown.visible = false
		else:
			%Home.visible = true
			%Altium22.visible = true
			%Altium24.visible = true
			%ArduinoIdeBtn.visible = true
			%CiscoBtn.visible = true
			%CrystalDiskBtn.visible = true
			%DiscordBtn.visible = true
			%shutDown.visible = true
	if talkstage == 8:
		if %Home.visible == true:
			%Home.visible = false
			%Altium22.visible = false
			%Altium24.visible = false
			%ArduinoIdeBtn.visible = false
			%CiscoBtn.visible = false
			%CrystalDiskBtn.visible = false
			%DiscordBtn.visible = false
			%shutDown.visible = false
			%Finish.visible = false
		else:
			%Home.visible = true
			%Altium22.visible = false
			%Altium24.visible = false
			%ArduinoIdeBtn.visible = false
			%CiscoBtn.visible = false
			%CrystalDiskBtn.visible = false
			%DiscordBtn.visible = false
			%shutDown.visible = false
			%shutDown.visible = true

func _on_altium_22_pressed() -> void:
	%Altium22Loading.visible = true
	await get_tree().create_timer(5, false).timeout
	%Altium.visible = true
	%Browser_close.visible = true

func _on_altium_24_pressed() -> void:
	%Altium22Loading.visible = true
	await get_tree().create_timer(5, false).timeout
	%Altium.visible = true
	%Browser_close.visible = true

func _on_arduino_ide_btn_pressed() -> void:
	%ArduinoIde.visible = true
	%Browser_close.visible = true
	%programBtn.visible = true

func _on_cisco_btn_pressed() -> void:
	%Cisco.visible = true
	%Browser_close.visible = true

func _on_crystal_disk_btn_pressed() -> void:
	%CrystalDisk.visible = true
	%Browser_close.visible = true

func _on_discord_btn_pressed() -> void:
	%Discord.visible = true
	%Browser_close.visible = true

func _on_program_btn_pressed() -> void:
	talkstage += 1
	match talkstage:
		1:
			%ArduinoIde0.visible = true
		2:
			%ArduinoIde1.visible = true
		3:
			%ArduinoIde2.visible = true
		4:
			%ArduinoIde3.visible = true
		5:
			%ArduinoIde4.visible = true
		6:
			%ArduinoIde5.visible = true
		7:
			%ArduinoIde6.visible = true
		8:
			%ArduinoIde7.visible = true
			%programBtn.visible = false
			%Finish.visible = true

func _on_finish_pressed() -> void:
	%ArduinoIde7.visible = false
	%ArduinoIde6.visible = false
	%ArduinoIde5.visible = false
	%ArduinoIde4.visible = false
	%ArduinoIde3.visible = false
	%ArduinoIde2.visible = false
	%ArduinoIde1.visible = false
	%ArduinoIde0.visible = false
	%ArduinoIde.visible = false
	%Home.visible = false
	%Finish.visible = false


func _on_shut_down_pressed() -> void:
	if talkstage == 8:
		Global.level_school = 4
		Global.changed_from_solder = true
		await get_tree().change_scene_to_file("res://Assets/School.tscn")
	else:
		pass
