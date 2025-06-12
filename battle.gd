extends Control

signal textbox_closed

@export var max_enemy_hp := 100
var enemy_current_hp = max_enemy_hp
var player_stats = {}
var grabbed_slot_data: SlotData
var is_player_turn = true

@onready var player_hp_bar = $PlayerPanel.get_node("PlayerData/ProgressBar")
@onready var player_hp_label = player_hp_bar.get_node("Label")
@onready var enemy_hp_bar = $VBoxContainer.get_node("ProgressBar")
@onready var enemy_hp_label = enemy_hp_bar.get_node("Label")
@onready var battle_music = $BattleMusic
@onready var inventory_interface: Control = $ActionsPanel/Actions/Item/UI/InventoryInterface
@onready var inventory_ui = get_node("ActionsPanel/Actions/Item/UI/InventoryInterface")
@onready var player: CharacterBody2D = $Player
@onready var grabbed_slot: PanelContainer = $ActionsPanel/Actions/Item/UI/InventoryInterface/GrabbedSlot



func _ready() -> void:
	if Global.changed_from_chinese:
		queue_free()  
		return  
	if Global.opponent == "Heinrich":
		$"VBoxContainer/Heinrich".visible = true
		display_text("Heinrich has attacked you!")
	else:
		$"VBoxContainer/Chef".visible = true
		display_text("Chef has attacked you!")
	player.inventory_data = Global.inventory_data
	player.can_move = false
	call_deferred("_init_inventory")
	player_stats = Global.player_stats

	if player_stats and player_stats.has("current_hp"):
		player_stats["current_hp"] = max(player_stats["current_hp"], 1)
		update_hp_bars()

	
	await get_tree().create_timer(0.25).timeout
	%ActionsPanel.show()
	MusicPlayer.play_music(battle_music.stream)

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextBox.visible:
		$TextBox.hide()
		emit_signal("textbox_closed")

	if Input.is_action_just_pressed("toggle_inventory") and inventory_ui.visible:
		inventory_ui.visible = false
		%ActionsPanel.show()

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)

func display_text(text):
	%TextBox.show()
	%TextBox.get_node("DialogLabel").text = text

func update_hp_bars():
	player_hp_bar.max_value = player_stats["max_hp"]
	player_hp_bar.value = player_stats["current_hp"]
	player_hp_label.text = str(player_stats["current_hp"]) + " / " + str(player_stats["max_hp"])

	enemy_hp_bar.max_value = max_enemy_hp
	enemy_hp_bar.value = enemy_current_hp
	enemy_hp_label.text = str(enemy_current_hp) + " / " + str(max_enemy_hp)

func _on_attack_pressed() -> void:
	if is_player_turn:
		var base_damage = 25
		var is_critical = randf() < 0.02
		var damage = base_damage * 2 if is_critical else base_damage

		enemy_current_hp = max(0, enemy_current_hp - damage)
		update_hp_bars()

		if is_critical:
			$"Super Effective Hit Sound".play()
			display_text("Critical hit! You dealt " + str(damage) + " damage!")
		else:
			$"Hit Sound".play(1.0)
			display_text("You attacked the enemy for " + str(damage) + " HP!")

		is_player_turn = false
		await self.textbox_closed

		if enemy_current_hp == 0:
			MusicPlayer.stop_music()
			display_text("You Win!")
			await self.textbox_closed
			display_text("You Gained 25 Exp")
			$"Win Sound".play()
			SaveManager._save_hp_only()
			await self.textbox_closed
			Global.hide_menu_on_start = true
			Global.fight_comleted = true
			Global.gain_xp(25)
			SaveManager._save_xp_only()
			if Global.location == "Overworld":
				await get_tree().change_scene_to_file("res://game.tscn")
			elif Global.location == "chinese_shop":
				Global.chef_defeated = true
				await get_tree().change_scene_to_file("res://chinese_shop.tscn")
		else:
			enemy_counterattack()

func enemy_counterattack():
	if enemy_current_hp > 0:
		var counter_damage = 15
		player_stats["current_hp"] = max(0, player_stats["current_hp"] - counter_damage)
		display_text("The enemy attacked you for " + str(counter_damage) + " HP!")
		update_hp_bars()
		is_player_turn = true

func _on_run_pressed() -> void:
	MusicPlayer.stop_music()
	display_text("Got away safely")
	$"Flee Sound".play()
	await self.textbox_closed
	Global.hide_menu_on_start = true
	if Global.location == "Overworld":
		await get_tree().change_scene_to_file("res://game.tscn")
	elif Global.location == "chinese_shop":
		await get_tree().change_scene_to_file("res://chinese_shop.tscn")

func _on_item_pressed() -> void:
	if inventory_ui:
		%ActionsPanel.hide()
		inventory_ui.visible = not inventory_ui.visible

func _init_inventory():
	if inventory_interface and player:
		inventory_interface.set_player_inventory_data(player.inventory_data)
		player.inventory_data.inventory_interact.connect(on_inventory_interact)

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int) -> void:
	if button == MOUSE_BUTTON_LEFT:
		var slot_data = inventory_data.slot_datas[index]
		if slot_data and slot_data.item_data.name == "Apple":
			if can_use_item(slot_data.item_data):
				heal_player(20)
				inventory_data.decrease_slot_quantity(index, 1)
				var return_slot_data = inventory_data.drop_slot_data(slot_data, index)

	
	update_grabbed_slot()


func update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()

func _on_inventory_item_pressed(item_data: ItemData) -> void:
	if item_data.name == "Apple" and can_use_item(item_data):
		heal_player(20)
		remove_single_item_from_inventory(item_data)


func heal_player(amount: int) -> void:
	player_stats["current_hp"] = min(player_stats["max_hp"], player_stats["current_hp"] + amount)
	update_hp_bars()

func remove_item_from_inventory(item_data: ItemData) -> void:
	var inventory_data = Global.inventory_data
	for slot_data in inventory_data.slot_datas:
		if slot_data.item_data == item_data:
			inventory_data.slot_datas.erase(slot_data)
			break
	inventory_interface.update_inventory_ui()
	
func can_use_item(item_data: ItemData) -> bool:
	if item_data.name == "Apple":
		return player_stats["current_hp"] < player_stats["max_hp"]
	return true

func remove_single_item_from_inventory(item_data: ItemData) -> void:
	var inventory_data = Global.inventory_data
	for i in range(inventory_data.slot_datas.size()):
		var slot_data = inventory_data.slot_datas[i]
		if slot_data.item_data.name == item_data.name:
			slot_data.quantity -= 1
			if slot_data.quantity <= 0:
				inventory_data.slot_datas.remove_at(i)
			break
	inventory_interface.update_inventory_ui()
	update_grabbed_slot()
