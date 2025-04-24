extends Area2D

var dialog_signal = false

func _process(_delta: float) -> void:
	%Talk_Btn.visible = dialog_signal
	
func _on_body_entered(_body: Node2D) -> void:
	dialog_signal = true

func _on_body_exited(_body: Node2D) -> void:
	dialog_signal = false
