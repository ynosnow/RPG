extends Node2D

@onready var inventory_ui = get_node("UI/InventoryInterface")
@onready var break_menu_ui = get_node_or_null("UI/BreakMenu")
@onready var player: CharacterBody2D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var interact_button: Button = $Interact_Door
@onready var shop_door_sprite: Sprite2D = $ShopChinese
@onready var door_effect: ColorRect = $ShopChinese/DoorEffect

var door_open = false
var player_in_range = false

func _ready() -> void:
	update_level_bar()
	Global.opponent = "Heinrich"
	Global.npc = "Heinrich"
	#if Global.hide_menu_on_start == false:
		#%MenuMusic.volume_db = -80
		#%MenuMusic.play()
		#var tween = create_tween()
		#tween.tween_property(%MenuMusic, "volume_db", 0, 7.0)  
	#else:
		#%MenuMusic.stop()
	
	call_deferred("_init_inventory")
	if Global.hide_menu_on_start:
		Global.hide_menu_on_start = false  
		var menu = get_node("UI/Menu")
		if menu:
			menu.visible = false
		await get_tree().process_frame 
		if Global.changed_from_school and Global.location != "Overworld":
			SaveManager._load_everything_but_position()
			player.position = Vector2(10,0)
		elif Global.changed_from_chinese and Global.location != "Overworld":
			SaveManager._load_everything_but_position()
			player.position = Vector2(760,250)
		else:
			SaveManager._load()
	Global.location = "Overworld"
	interact_button.visible = false
	door_effect.visible = false
	
func _process(delta: float) -> void:
	if $"UI/Menu".visible == false and $"UI/LoadUi".visible == false:
		%LevelingBar.visible = true
		%Level.visible = true
	if TransitionManager.is_transitioning == true:
		$"UI".visible = false
		SaveManager._save()
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

func _on_chinese_entrance_body_entered(body: Node2D) -> void:
	if door_open and body == player:
		SaveManager._save()
		get_tree().change_scene_to_file("res://chinese_shop.tscn")

func _on_interact_door_pressed() -> void:
	if player_in_range:
		if has_key():
			if not door_open:
				door_open = true
				shop_door_sprite.texture = preload("res://Assets/shop_chinese_open.png")
				door_effect.visible = true
				interact_button.visible = false
		else:
			print("Du hast den Schlüssel nicht!")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true
		interact_button.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false
		interact_button.visible = false

func has_key() -> bool:
	var inventory = player.inventory_data
	if inventory == null:
		return false
	for slot_data in inventory.slot_datas:
		if slot_data and slot_data.item_data and slot_data.item_data.name == "Key":
			return true
	return false


func _on_chinese_entrance_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false
		interact_button.visible = false
		
func update_level_bar():
	%LevelingBar.max_value = Global.xp_to_next_level
	%LevelingBar.value = Global.xp
	%Level.text = "Level " + str(Global.level)


func _on_school_collision_body_entered(body: Node2D) -> void:				
	Global.changed_from_game = true
	SaveManager._save()
	await get_tree().change_scene_to_file("res://Assets/School.tscn")


func _on_gopnik_body_entered(body: Node2D) -> void:
	if body == player:
		%gopnikBtn.visible = true

func _on_gopnik_body_exited(body: Node2D) -> void:
	if body == player:
		%gopnikBtn.visible = false

func _on_stand_hot_dog_body_exited(body: Node2D) -> void:
	if body == player:
		%HotDogBtn.visible = false

func _on_stand_hot_dog_body_entered(body: Node2D) -> void:
	if body == player:
		%HotDogBtn.visible = true


func _on_casino_body_entered(body: Node2D) -> void:
	SaveManager._save()
	await get_tree().change_scene_to_file("res://Assets/casino.tscn")
