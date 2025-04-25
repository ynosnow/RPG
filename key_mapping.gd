extends Control

@onready var inventory_ui = $"../InventoryUI"
@onready var break_menu_ui = $"../BreakMenu"

func _unhandled_input(event):
	if event.is_action_pressed("toggle_break_menu"):
		break_menu_ui.visible = not break_menu_ui.visible

func _process(_delta):
	if Input.is_action_just_pressed("toggle_inventory"):
		var inventory_ui = get_tree().current_scene.get_node("UI/InventoryUI")
		var break_menu = get_tree().current_scene.get_node_or_null("UI/BreakMenu")

		if inventory_ui:
			inventory_ui.visible = not inventory_ui.visible

		if break_menu and inventory_ui.visible:
			break_menu.visible = false
