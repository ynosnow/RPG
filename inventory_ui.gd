extends Control

@onready var inventory_ui = $"../InventoryUI"

func _unhandled_input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory_ui.visible = not inventory_ui.visible

#
