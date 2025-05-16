extends Button

var Talk_Stage : int = 0
var Text_finished = false

func _ready() -> void:
	if Global.fight_comleted == true:
		reset_post_fight_dialog()
	else:
		%Talk_Btn.visible = true
		%Panel.visible = false

func reset_post_fight_dialog() -> void:
	Talk_Stage = 5
	%Talk_Btn.visible = true
	%Panel.visible = true
	show_post_fight_dialog()

func _on_pressed() -> void:
	%Panel.visible = true
	if Global.fight_comleted == true:
		if Talk_Stage == 5:
			%DialogLabel.text = "You did it!"
			Talk_Stage += 1
		elif Talk_Stage == 6:
			%DialogLabel.text = "To continue you must find 4 Pieces"
			show_pickups(true)
			Talk_Stage += 1
		elif Talk_Stage == 7:
			%DialogLabel.text = "Of a key and I will shape it into a key"
			Talk_Stage += 1
		elif Talk_Stage == 8:
			%DialogLabel.text = "Come back after collecting them"
			%Panel.visible = false
			Talk_Stage = 0
		elif Talk_Stage == 0:
			var player_node = get_node_or_null("/root/Game/Player")
			if player_node:
				Global.inventory_data = player_node.inventory_data
			if has_all_key_pieces():
				remove_key_pieces_and_add_key()
				%DialogLabel.text = "You got the key pieces"
				show_pickups(false)
				Talk_Stage = 10
				%Talk_Btn.visible = true
			else:
				%DialogLabel.text = "You didn't collect the key pieces"
				Talk_Stage = 8
		elif Talk_Stage == 9:
			%DialogLabel.text = "Thanks for bringing the pieces!"
		elif Talk_Stage == 10:
			%Panel.visible = false
			%Talk_Btn.visible = false
			Talk_Stage = 0
		else:
			Talk_Stage = 0
	else:
		if not Text_finished:
			Talk_Stage += 1
			if Talk_Stage == 1:
				%DialogLabel.text = "Hey, you're the new guy right?"
			elif Talk_Stage == 2:
				%DialogLabel.text = "Beat me in a fight and I will help you."
			elif Talk_Stage > 2:
				%Panel.visible = false
				%Talk_Btn.visible = false
				Talk_Stage = 0
				Text_finished = true
				start_battle_transition()

func show_post_fight_dialog() -> void:
	if Talk_Stage == 5:
		%DialogLabel.text = "You did it!"
	elif Talk_Stage == 6:
		%DialogLabel.text = "To continue you must find 4 Pieces"
	elif Talk_Stage == 7:
		%DialogLabel.text = "Of a key and I will shape it into a key"
	elif Talk_Stage == 8:
		%DialogLabel.text = "Come back after collecting them"
	else:
		%Panel.visible = false
		%Talk_Btn.visible = false

func show_pickups(visible: bool) -> void:
	var pickups_paths = [
		"/root/Game/Pickup1",
		"/root/Game/Pickup2",
		"/root/Game/Pickup3",
		"/root/Game/Pickup4"
	]
	for path in pickups_paths:
		var pickup_node = get_node_or_null(path)
		if pickup_node:
			pickup_node.visible = visible

func start_battle_transition() -> void:
	var battle_music = $BattleMusic
	var player_node = get_node("/root/Game/Player")
	if player_node:
		Global.player_stats["max_hp"] = player_node.max_hp
		Global.player_stats["current_hp"] = player_node.current_hp
		Global.inventory_data = player_node.inventory_data
		SaveManager._save()
		MusicPlayer.play_music(battle_music.stream)
		var transition = get_node("/root/TransitionManager")
		transition.scene_path = "res://Battle.tscn"
		transition.play_transition()

func has_all_key_pieces() -> bool:
	var needed_pieces = ["Key Piece1", "Key Piece2", "Key Piece3", "Key Piece4"]
	var inventory = Global.inventory_data
	if inventory == null:
		return false
	for slot_data in inventory.slot_datas:
		if slot_data and slot_data.item_data:
			pass
	for piece_name in needed_pieces:
		var found = false
		for slot_data in inventory.slot_datas:
			if slot_data and slot_data.item_data.name == piece_name:
				found = true
				break
		if not found:
			return false
	return true

func remove_key_pieces_and_add_key() -> void:
	var inventory = Global.inventory_data
	if inventory == null:
		return
	var needed_pieces = ["Key Piece1", "Key Piece2", "Key Piece3", "Key Piece4"]
	for piece_name in needed_pieces:
		for i in range(inventory.slot_datas.size()):
			var slot = inventory.slot_datas[i]
			if slot and slot.item_data and slot.item_data.name == piece_name:
				inventory.decrease_slot_quantity(i, 1)
				break

	var key_item_data = preload("res://Item/Items/full_key_as_item.tres")
	var new_slot = SlotData.new()
	new_slot.item_data = key_item_data
	new_slot.quantity = 1
	inventory.pick_up_slot_data(new_slot)
	inventory.inventory_updated.emit(inventory)
