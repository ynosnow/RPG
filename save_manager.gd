extends Node

const save_location := "user://SaveFile.tres"
var SaveFileData: SaveDataResource = SaveDataResource.new()

func _save():
	var player = get_tree().current_scene.get_node("Player")
	SaveFileData.xp = Global.xp
	SaveFileData.xp_to_next_level = Global.xp_to_next_level
	SaveFileData.level = Global.level
	if player:
		SaveFileData.player_position = player.position
		SaveFileData.player_current_hp = player.current_hp
		SaveFileData.player_max_hp = player.max_hp
		if player.inventory_data:
			SaveFileData.inventory = player.inventory_data.duplicate(true)
		ResourceSaver.save(SaveFileData, save_location)

func _load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
		var player = get_tree().current_scene.get_node("Player")
		if player:
			await get_tree().create_timer(0.0).timeout
			Global.xp = SaveFileData.xp
			Global.xp_to_next_level = SaveFileData.xp_to_next_level
			Global.level = SaveFileData.level
			player.position = SaveFileData.player_position
			player.current_hp = SaveFileData.player_current_hp
			player.max_hp = SaveFileData.player_max_hp
			if SaveFileData.inventory:
				player.inventory_data = SaveFileData.inventory.duplicate(true)
				var inventory_interface = get_tree().current_scene.get_node("UI/InventoryInterface")
				if inventory_interface:
					inventory_interface.set_player_inventory_data(player.inventory_data)

func _save_hp_only():
	var stats = Global.player_stats
	if stats:
		SaveFileData.player_current_hp = stats["current_hp"]
		SaveFileData.player_max_hp = stats["max_hp"]
		ResourceSaver.save(SaveFileData, save_location)
	else:
		print("No player stats found in Global!")

func _save_position_only():
	var player_node = get_tree().current_scene.get_node("Player")
	if player_node:
		SaveFileData.player_position = player_node.position
		ResourceSaver.save(SaveFileData, save_location)
	else:
		print("Player node not found for saving position.")

func _save_xp_only():
	if Global:
		SaveFileData.xp = Global.xp
		SaveFileData.xp_to_next_level = Global.xp_to_next_level
		SaveFileData.level = Global.level
		ResourceSaver.save(SaveFileData, save_location)
	else:
		print("Global data not found for saving XP.")
		
# New function to reset all save stats
func reset_save_data():

	SaveFileData.player_position = Vector2.ZERO
	
	
	SaveFileData.player_current_hp = 100
	SaveFileData.player_max_hp = 100
	
	
	SaveFileData.inventory = null
	
	SaveFileData.xp = 0
	SaveFileData.xp_to_next_level = 100 
	SaveFileData.level = 1
	ResourceSaver.save(SaveFileData, save_location)
	print("Save data has been reset.")
