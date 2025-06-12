extends Node2D

@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var break_menu_ui = get_node_or_null("UI/BreakMenu")
@onready var player: CharacterBody2D = $Player
@onready var inventory_ui = $UI/InventoryInterface

func _ready() -> void:
	
	player.inventory_data = Global.inventory_data
	player.inventory_data.ensure_slot_count(12)
	call_deferred("_init_inventory")
	
	if Global.changed_from_game == true:
		SaveManager._load_everything_but_position()
		player.position = Vector2(240, -521)
		Global.changed_from_school = false
	elif Global.changed_from_solder == true and Global.location == "School":
		SaveManager._load_everything_but_position()
		player.position = Vector2(-1919.0, -530.0)
	else:
		SaveManager._load()
	Global.location = "School"

func _process(delta: float) -> void:
	if Global.changed_from_solder == true:
		var solder = $solder
		if solder:
			solder.collision_layer = 1
			solder.collision_mask = 1
			Global.changed_from_solder = false  
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if Global.level_school == 5:
		if body == player:
			Global.changed_from_school = true
			Global.hide_menu_on_start = true
			get_tree().change_scene_to_file("res://game.tscn")
	else:
		pass

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
	
	if event.is_action_pressed("Quest"):
		SaveManager._save()
		get_tree().change_scene_to_file("res://Quest.tscn")

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

func _on_solder_body_entered(body: Node2D) -> void:
	if Global.level_school == 2:
		if body == player:
			SaveManager._save()
			get_tree().change_scene_to_file("res://soldering.tscn")

func _on_programming_body_entered(body: Node2D) -> void:
	if Global.level_school == 3:
		if body == player:
			SaveManager._save()
			get_tree().change_scene_to_file("res://Browser.tscn")
	else:
		pass
