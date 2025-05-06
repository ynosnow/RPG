extends Button

func _on_pressed() -> void:
	var inventory_ui = get_tree().current_scene.get_node("UI/InventoryUI")
	if inventory_ui:
		inventory_ui.visible = false
