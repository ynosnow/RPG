extends Button

func _on_pressed() -> void:
	var break_menu = get_tree().current_scene.get_node("UI/BreakMenu")
	if break_menu:
		break_menu.visible = false

	var inventory_ui = get_tree().current_scene.get_node("UI/InventoryInterface")
	if inventory_ui:
		inventory_ui.visible = true


func _on_map_btn_pressed() -> void:
	SaveManager._save()
	get_tree().change_scene_to_file("res://Map.tscn")
