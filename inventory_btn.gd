extends Button

func _on_pressed() -> void:
	var break_menu = get_tree().current_scene.get_node("UI/BreakMenu")
	if break_menu:
		break_menu.visible = false

	var inventory_ui = get_tree().current_scene.get_node("UI/InventoryUI")
	if inventory_ui:
		inventory_ui.visible = true
