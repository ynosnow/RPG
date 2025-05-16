extends Node


var cash: int = 0 #zum erhöhen Global.cash += 10000
var location: String = ""

var player_stats = {
	"max_hp": 100,
	"current_hp": 100
}


var inventory_data: InventoryData = InventoryData.new()
var npc = ""
var intro_completed = false
var hide_menu_on_start = false
var fight_comleted = false



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
