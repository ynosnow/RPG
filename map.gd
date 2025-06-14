extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.location == "Overworld":
		$"Overworld".visible = true
	elif Global.location == "School":
		$"School".visible = true
	elif Global.location == "chinese_shop":
		$"chinese_shop".visible = true
	elif Global.location == "chinese_shop_underground":
		$"chinese_shop_underground".visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if Input.is_action_just_pressed("toggle_map"):
		if Global.location == "Overworld":
			get_tree().change_scene_to_file("res://game.tscn")
			Global.hide_menu_on_start = true
		elif Global.location == "School":
			get_tree().change_scene_to_file("res://Assets/School.tscn")
		elif Global.location == "chinese_shop":
			get_tree().change_scene_to_file("res://chinese_shop.tscn")
		elif Global.location == "chinese_shop_underground":
			get_tree().change_scene_to_file("res://chinese_shop.tscn")

func _on_exit_btn_pressed() -> void:
		if Global.location == "Overworld":
			await get_tree().change_scene_to_file("res://game.tscn")
			Global.hide_menu_on_start = true
		elif Global.location == "School":
			await get_tree().change_scene_to_file("res://Assets/School.tscn")
		elif Global.location == "chinese_shop":
			await get_tree().change_scene_to_file("res://chinese_shop.tscn")
		elif Global.location == "chinese_shop_underground":
			await get_tree().change_scene_to_file("res://chinese_shop.tscn")
	
