extends Area2D

@onready var player: CharacterBody2D = $Player
var dialog_signal = false

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if Global.fight_comleted:
		return  
	%Talk_Btn.visible = dialog_signal

func _on_body_entered(_body: Node2D) -> void:
	dialog_signal = true

func _on_body_exited(_body: Node2D) -> void:
	dialog_signal = false
