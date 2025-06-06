extends Control

var menu_visible : bool = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_new_game_pressed() -> void:
	SaveManager.reset_save_data()
	get_tree().change_scene_to_file("res://intro.tscn") 

func _on_load_game_pressed() -> void:
	var menu = get_tree().current_scene.get_node("UI/Menu")
	var load_ui = get_tree().current_scene.get_node("UI/LoadUi")
	if load_ui:
		load_ui.visible = true
		if menu:
			menu.visible = false
			menu_visible = false  
