extends Node2D

@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var break_menu_ui = get_node_or_null("UI/BreakMenu")
@onready var player: CharacterBody2D = $Player
@onready var inventory_ui = $UI/InventoryInterface
var talkstage = 0

func _ready() -> void:
	Global.opponent = "Chef"
	Global.npc = "ChineseChef"
	if Global.chinese_shop_entered:
		SaveManager._load()
	Global.location = "chinese_shop"
	player.inventory_data = Global.inventory_data
	player.inventory_data.ensure_slot_count(12)
	call_deferred("_init_inventory")
	Global.chinese_shop_entered = true
	
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
	if event.is_action_pressed("Interact"):
		if $"Area2D2/Button".visible:
			_on_button_pressed()
			
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


func _process(delta: float) -> void:
	if Global.chef_defeated == true:
		$"Area2D2/Chef".visible = false
		%DialogLabel.visible = false
		%Panel.visible = false
		$"StaticBody2D3".position = Vector2(500,35)
	else:
		$"StaticBody2D3".position = Vector2(5,35)
	if Global.money_collected_from_chinese == true:
		$"Door2".visible = false 
		$"Door".visible = true
		$"StaticBody2D5".position = Vector2(500,35)
		$"StaticBody2D4".position = Vector2(5,35)
	else:
		$"StaticBody2D4".position = Vector2(500,35)
	

func _on_body_entered(body: Node2D) -> void:
	if talkstage == 0:
		$"Area2D2/CanvasLayer2/Panel".visible = true
		$"Area2D2/CanvasLayer2/Panel/DialogLabel".text = "We are closed, dont come closer!"
		talkstage+= 1
	if Global.chef_defeated == false:
		$"Area2D2/Button".visible = false

func _on_body_exited(body: Node2D) -> void:
	if Global.chef_defeated == false:
		$"Area2D2/Button".visible = false


func _on_button_pressed() -> void:
	if talkstage == 1:
		$"Area2D2/CanvasLayer2/Panel/DialogLabel".text = "YOU HAVE NO CHANCE AGAINST ME"
		talkstage += 1
	elif talkstage == 2:
		$"Area2D2/Button".visible = false
		$"Area2D2/CanvasLayer2/Panel".visible = false
		start_battle_transition()
	else:
		$"Area2D2/CanvasLayer2/Panel".visible = false
		
		
func start_battle_transition() -> void:
	var battle_music = $"Area2D2/BattleMusic"
	var player_node = get_node("Player")
	if player_node:
		Global.player_stats["max_hp"] = player_node.max_hp
		Global.player_stats["current_hp"] = player_node.current_hp
		Global.inventory_data = player_node.inventory_data
		SaveManager._save()
		MusicPlayer.play_music(battle_music.stream)
		var transition = get_node("/root/TransitionManager")
		transition.scene_path = "res://Battle.tscn"
		transition.play_transition()


func _on_safe_code_collision_body_entered(body: Node2D) -> void:
	if body == player:
		$"SafeCodeButton".visible = true


func _on_safe_code_button_pressed() -> void:
	SaveManager._save()
	get_tree().change_scene_to_file("res://SafeCode.tscn")


func _on_safe_code_collision_body_exited(body: Node2D) -> void:
	$"SafeCodeButton".visible = false


func _on_safe_button_pressed() -> void:
	SaveManager._save()
	get_tree().change_scene_to_file("res://Safe.tscn")


func _on_safe_collision_body_entered(body: Node2D) -> void:
	if body == player:
		$"SafeButton".visible = true


func _on_safe_collision_body_exited(body: Node2D) -> void:
	$"SafeButton".visible = false


func _on_upstairs_body_entered(body: Node2D) -> void:
	if body == player:
		player.position = Vector2(0,0)
		Global.location = "chinese_shop" 


func _on_downstairs_body_entered(body: Node2D) -> void:
	if body == player:
			player.position = Vector2(25,850)
			Global.location = "chinese_shop_underground" 
				
func _on_exit_body_entered(body: Node2D) -> void:
	if body == player:
		player.position = Vector2(758.0,230.0)
		SaveManager._save_position_only()
		Global.changed_from_chinese = true
		Global.hide_menu_on_start = true
		await get_tree().change_scene_to_file("res://game.tscn")


func _on_fight_body_entered(body: Node2D) -> void:
	if body == player and Global.chef_defeated != true:
		start_battle_transition()
		$"Area2D2/CanvasLayer2/Panel".visible = false
		$"Area2D2/CanvasLayer2/Panel/DialogLabel".visible = false
		$"UI/Menu_Btn".visible = false
