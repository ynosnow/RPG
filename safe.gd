extends Node2D
var number = 0
var code = "0258"
var input = ""
var failed = false

var Sprites: Array[Sprite2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprites.append($"Sprite2D0")
	Sprites.append($"Sprite2D1")
	Sprites.append($"Sprite2D2")
	Sprites.append($"Sprite2D3")
	Sprites.append($"Sprite2D4")
	Sprites.append($"Sprite2D5")
	Sprites.append($"Sprite2D6")
	Sprites.append($"Sprite2D7")
	Sprites.append($"Sprite2D8")
	Sprites.append($"Sprite2D9")
	
	_set_active_sprite(number)
	

	

func _set_active_sprite(number: int) -> void:
	for sprite in Sprites:
		sprite.visible = false
	Sprites[number].visible = true


func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if !failed:
		%Label.text = input + "_"
	else:
		failed = false
	if event.is_action_pressed("right"):
		_play_dial_sound()
		if number < 9:
			number += 1
		else:
			number = 0
		_set_active_sprite(number)
	if event.is_action_pressed("left"):
		_play_dial_sound()
		if number > 0:
			number -= 1
		else:
			number = 9
		_set_active_sprite(number)
	if event.is_action_pressed("Enter"):
		_play_dialconfirm_sound()
		input += str(number)
		if input.length() == code.length():
			if input == code:
				_play_safeopened_sound()
				for sprite in Sprites:
					sprite.visible = false
					$"Panel".visible = false
					$"Open".visible = true
			else:
				%Label.text = "XXXX"
				input = ""
				failed = true

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://chinese_shop.tscn")
	
	
func _play_dial_sound():
	$"Dial".play()
	await get_tree().create_timer(0.2, false).timeout
	$"Dial".stop()
	
func _play_dialconfirm_sound():
	$"DialConfirm".play(0.2)
	await get_tree().create_timer(0.2, false).timeout
	$"DialConfirm".stop()
	
func _play_safeopened_sound():
	$"SafeOpened".play(7.8)
	await get_tree().create_timer(2, false).timeout
	$"SafeOpened".stop()
