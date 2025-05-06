extends Control

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_new_game_pressed() -> void:
	var menu = get_tree().current_scene.get_node("UI/Menu")
	if menu:
		menu.visible = false


func _on_load_game_pressed() -> void:
	var menu = get_tree().current_scene.get_node("UI/Menu")
	var load_ui = get_tree().current_scene.get_node("UI/LoadUi")
	if load_ui:
		load_ui.visible = true
		menu.visible = false
