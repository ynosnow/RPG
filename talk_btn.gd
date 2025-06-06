extends Button

var talk_stage: int = 0
var text_finished := false
@export var slot_data: SlotData

func _ready() -> void:
	%Talk_Btn.visible = false
	%Panel.visible = false

	match Global.npc:
		"Heinrich":
			if Global.fight_comleted:
				if Global.heinrich_dialog_finished:
					hide_dialog()
				else:
					reset_post_fight_dialog()
			else:
				%Talk_Btn.visible = true
		"ChineseChef":
			%Talk_Btn.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and %Talk_Btn.visible and not text_finished:
		_on_pressed()

func _on_pressed() -> void:
	match Global.npc:
		"Heinrich":
			handle_heinrich_dialog()
		"ChineseChef":
			%Panel.visible = true
			%DialogLabel.text = "What are you doing here"

func handle_heinrich_dialog() -> void:
	%Panel.visible = true

	if Global.fight_comleted:
		match talk_stage:
			5:
				%DialogLabel.text = "You did it!"
			6:
				%DialogLabel.text = "To continue you must find 4 Pieces"
				show_pickups(true)
			7:
				%DialogLabel.text = "Of a key and I will shape it into a key"
			8:
				%DialogLabel.text = "Come back after collecting them"
				%Panel.visible = false
				talk_stage = 0
				return
			0:
				var player = get_node_or_null("/root/Game/Player")
				if player:
					Global.inventory_data = player.inventory_data

				if has_all_key_pieces():
					remove_key_pieces_and_add_key()
					show_pickups(false)
					%DialogLabel.text = "You got the key pieces"
					talk_stage = 10
				else:
					if Global.chinese_shop_entered:
						talk_stage = 16
					else:
						%DialogLabel.text = "You didn't collect the key pieces"
						talk_stage = 8
						return
			9:
				%DialogLabel.text = "Thanks for bringing the pieces!"
			10:
				%DialogLabel.text = "This is the key"
				Global.if_keys_picked_up = true
			11:
				%DialogLabel.text = "It unlocks the Chinese restaurant"
			12:
				%DialogLabel.text = "There’s a basement under it with a hidden safe"
			13:
				%DialogLabel.text = "But the safe needs a code"
			14:
				%DialogLabel.text = "Search the restaurant. The code is hidden somewhere"
			15:
				%DialogLabel.text = "Be careful... he might notice something's off"
			16:
				if Global.cash >= 500000:
					%DialogLabel.text = "So you got the money"
					talk_stage = 17
				else:
					%Panel.visible = false
					%Talk_Btn.visible = false
					text_finished = true
					return
			17:
				%DialogLabel.text = "Find out the rest yourself"
				talk_stage = 18
				return
			18:
				end_heinrich_dialog()
				return
		talk_stage += 1
	else:
		if not text_finished:
			match talk_stage:
				0:
					%DialogLabel.text = "Hey, you're the new guy right?"
				1:
					%DialogLabel.text = "Beat me in a fight and I will help you."
				_:
					start_battle_transition()
					text_finished = true
					%Talk_Btn.visible = false
					%Panel.visible = false
					talk_stage = 0
					return
			talk_stage += 1

func reset_post_fight_dialog() -> void:
	talk_stage = 5
	%Talk_Btn.visible = true
	%Panel.visible = true
	show_post_fight_dialog()

func show_post_fight_dialog() -> void:
	match talk_stage:
		5:
			%DialogLabel.text = "You did it!"
		6:
			%DialogLabel.text = "To continue you must find 4 Pieces"
		7:
			%DialogLabel.text = "Of a key and I will shape it into a key"
		8:
			%DialogLabel.text = "Come back after collecting them"
		_:
			hide_dialog()

func show_pickups(visible: bool) -> void:
	var paths = [
		"/root/Game/Pickup1",
		"/root/Game/Pickup2",
		"/root/Game/Pickup3",
		"/root/Game/Pickup4"
	]
	for path in paths:
		var pickup = get_node_or_null(path)
		if pickup:
			pickup.visible = visible

func start_battle_transition() -> void:
	var player = get_node("/root/Game/Player")
	if player:
		Global.player_stats["max_hp"] = player.max_hp
		Global.player_stats["current_hp"] = player.current_hp
		Global.inventory_data = player.inventory_data

		SaveManager._save()

		var battle_music = $BattleMusic
		MusicPlayer.play_music(battle_music.stream)

		var transition = get_node("/root/TransitionManager")
		transition.scene_path = "res://Battle.tscn"
		transition.play_transition()

func has_all_key_pieces() -> bool:
	var pieces = ["Key Piece1", "Key Piece2", "Key Piece3", "Key Piece4"]
	var inventory = Global.inventory_data
	if inventory == null:
		return false
	for name in pieces:
		var found = false
		for slot in inventory.slot_datas:
			if slot and slot.item_data and slot.item_data.name == name:
				found = true
				break
		if not found:
			return false
	return true

func remove_key_pieces_and_add_key() -> void:
	var inventory = Global.inventory_data
	if inventory == null:
		return

	var pieces = ["Key Piece1", "Key Piece2", "Key Piece3", "Key Piece4"]
	for name in pieces:
		for i in range(inventory.slot_datas.size()):
			var slot = inventory.slot_datas[i]
			if slot and slot.item_data and slot.item_data.name == name:
				inventory.decrease_slot_quantity(i, 1)
				break

	var key_item = preload("res://Item/Items/full_key_as_item.tres")
	var new_slot = SlotData.new()
	new_slot.item_data = key_item
	new_slot.quantity = 1
	inventory.pick_up_slot_data(new_slot)
	inventory.inventory_updated.emit(inventory)

func end_heinrich_dialog() -> void:
	hide_dialog()
	talk_stage = 16
	text_finished = true
	Global.heinrich_dialog_finished = true

func hide_dialog() -> void:
	%Panel.visible = false
	%Talk_Btn.visible = false
