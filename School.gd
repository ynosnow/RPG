extends Node2D

@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var break_menu_ui = get_node_or_null("UI/BreakMenu")
@onready var player: CharacterBody2D = $Player
@onready var inventory_ui = $UI/InventoryInterface

func _ready() -> void:
	Global.location = "School"
	player.inventory_data = Global.inventory_data
	player.inventory_data.ensure_slot_count(12)
	call_deferred("_init_inventory")
	
	SaveManager._load()

func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		Global.hide_menu_on_start = true
		get_tree().change_scene_to_file("res://game.tscn")

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory_ui:
			inventory_ui.visible = not inventory_ui.visible
			if break_menu_ui and inventory_ui.visible:
				break_menu_ui.visible = false

	if event.is_action_pressed("toggle_break_menu"):
		if break_menu_ui:
			break_menu_ui.visible = not break_menu_ui.visible
			if inventory_ui and break_menu_ui.visible:
				inventory_ui.visible = false
				
	if event.is_action_pressed("toggle_map"):
		SaveManager._save()
		get_tree().change_scene_to_file("res://Map.tscn")

func _init_inventory():
	if inventory_interface and player:
		inventory_interface.set_player_inventory_data(player.inventory_data)
		player.inventory_data.inventory_interact.connect(on_inventory_interact)


func on_inventory_interact(inventory_data: InventoryData, index: int, button: int) -> void:
	if button == MOUSE_BUTTON_LEFT:
		var slot_data = inventory_data.slot_datas[index]
		if slot_data and slot_data.item_data:
			print("Used item: %s" % slot_data.item_data.name)
	inventory_interface.update_grabbed_slot()
	
