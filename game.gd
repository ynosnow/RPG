extends Node2D

@onready var inventory_ui = get_node("UI/InventoryInterface")
@onready var break_menu_ui = get_node_or_null("UI/BreakMenu")
@onready var player: CharacterBody2D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

func _ready() -> void:
	call_deferred("_init_inventory")
	if Global.hide_menu_on_start:
		Global.hide_menu_on_start = false  
		var menu = get_node("UI/Menu")
		if menu:
			menu.visible = false
		await get_tree().process_frame 
		SaveManager._load()

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


func _on_chinese_entrance_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://chinese_shop.tscn")
