extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if Input.is_action_just_pressed("toggle_map"):
		get_tree().change_scene_to_file("res://game.tscn")
		Global.hide_menu_on_start = true


func _on_exit_btn_pressed() -> void:
	await get_tree().change_scene_to_file("res://game.tscn")
	Global.hide_menu_on_start = true
	
	
