extends Node

const save_location := "user://SaveFile.tres"


var SaveFileData: SaveDataResource = SaveDataResource.new()

func _save():
	var player = get_tree().current_scene.get_node("Player")
	if player:
		SaveFileData.player_position = player.position
		if player.inventory_data:
			SaveFileData.inventory = player.inventory_data.duplicate(true)
	ResourceSaver.save(SaveFileData, save_location)

func _load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
		var player = get_tree().current_scene.get_node("Player")
		if player:
			await get_tree().create_timer(0.0).timeout
			
			player.position = SaveFileData.player_position
			
			if SaveFileData.inventory:
				player.inventory_data = SaveFileData.inventory.duplicate(true)
				var inventory_interface = get_tree().current_scene.get_node("UI/InventoryInterface")
				if inventory_interface:
					inventory_interface.set_player_inventory_data(player.inventory_data)

func _on_load_pressed():
	var ui = get_tree().current_scene.get_node("UI")
	var game_menu = ui.get_node("GameMenu")
	var load_ui = ui.get_node("LoadUi")
	if game_menu:
		game_menu.visible = false
	if load_ui:
		load_ui.visible = true




func _on_save_btn_pressed() -> void:
	_save()
	
	

func _on_save_state_btn_pressed() -> void:
	_load()
	var ui = get_tree().current_scene.get_node("UI")
	var load_ui = ui.get_node("LoadUi")
	if load_ui:
		load_ui.visible = false
		
