extends Button


func _on_pressed() -> void:
	var break_menu = get_tree().current_scene.get_node("UI/BreakMenu")
	if break_menu:
		break_menu.visible = false

	var game_menu = get_tree().current_scene.get_node("UI/GameMenu")
	if game_menu:
		game_menu.visible = true
