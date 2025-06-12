extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	await get_tree().change_scene_to_file("res://gambling.tscn")

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	await get_tree().change_scene_to_file("res://gambling.tscn")


func _on_exit_body_entered(body: Node2D) -> void:
	await get_tree().change_scene_to_file("res://game.tscn")
