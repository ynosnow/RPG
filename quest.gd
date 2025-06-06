extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.intro_completed == true:
		$"Panel/Label1".text = Global.get_quest1_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	if Global.location == "Overworld":
		Global.hide_menu_on_start = true
		get_tree().change_scene_to_file("res://game.tscn")
	elif Global.location == "School":
		get_tree().change_scene_to_file("res://Assets/School.tscn")
	elif Global.location == "chinese_shop":
		get_tree().change_scene_to_file("res://chinese_shop.tscn")
	elif Global.location == "chinese_shop_underground":
		get_tree().change_scene_to_file("res://chinese_shop.tscn")
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Quest"):
		if Global.location == "Overworld":
			Global.hide_menu_on_start = true
			get_tree().change_scene_to_file("res://game.tscn")
		elif Global.location == "School":
			get_tree().change_scene_to_file("res://Assets/School.tscn")
		elif Global.location == "chinese_shop":
			get_tree().change_scene_to_file("res://chinese_shop.tscn")
		elif Global.location == "chinese_shop_underground":
			get_tree().change_scene_to_file("res://chinese_shop.tscn")
