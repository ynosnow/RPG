extends Node2D


func _on_browser_btn_pressed() -> void:
	%Browser.visible = true
	%Browser_close.visible = true


func _on_browser_close_pressed() -> void:
	%Home.visible = false
	%Browser.visible = false
	%Browser_close.visible = false


func _on_home_btn_pressed() -> void:
	if %Home.visible == true:
		%Home.visible = false
	else:
		%Home.visible = true
