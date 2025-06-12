extends Node

func _on_load_pressed():
	var ui = get_tree().current_scene.get_node("UI")
	var game_menu = ui.get_node("GameMenu")
	var load_ui = ui.get_node("LoadUi")
	if game_menu:
		game_menu.visible = false
	if load_ui:
		load_ui.visible = true

func _on_save_btn_pressed() -> void:
	SaveManager._save()
	
	

func _on_save_state_btn_pressed() -> void:
	SaveManager._load()
	var ui = get_tree().current_scene.get_node("UI")
	var load_ui = ui.get_node("LoadUi")
	if load_ui:
		load_ui.visible = false
		
