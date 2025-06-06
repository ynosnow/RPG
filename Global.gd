extends Node

var level: int = 1
var xp: int = 0
var xp_to_next_level: int = 100
var cash: int = 0 #zum erhöhen Global.cash += 10000
var location: String = ""
var if_keys_picked_up = false
var turn_text_off = false
var changed_from_game = false
var changed_from_school = false
var changed_from_solder = false

var player_stats = {
	"max_hp": 100,
	"current_hp": 100
}


var inventory_data: InventoryData = InventoryData.new()
var npc = ""
var intro_completed = false
var hide_menu_on_start = false
var fight_comleted = false
var chinese_shop_entered = false
var opponent = ""
var chef_defeated = false
var heinrich_dialog_finished = false



func format_cash(amount: int) -> String:
	var str_amount = str(amount)
	var result = ""
	var count = 0
	for i in range(str_amount.length() - 1, -1, -1):
		result = str_amount[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result  
	return result + "€"


func get_quest1_text() -> String:
	return "Main Quest: Get 5 Million Cash " + format_cash(cash) + " / 5,000,000€"


func gain_xp(amount: int) -> void:
	xp += amount
	while xp >= xp_to_next_level:
		xp -= xp_to_next_level
		level += 1
		_on_level_up()


func _on_level_up() -> void:
	
	player_stats["max_hp"] += 10
	player_stats["current_hp"] = player_stats["max_hp"]
	
	
	xp_to_next_level = int(xp_to_next_level * 1.25)
	
	
