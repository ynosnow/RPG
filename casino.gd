extends Node2D

@onready var player: CharacterBody2D = $Player

func _on_area_2d_body_entered(body: Node2D) -> void:
	await get_tree().change_scene_to_file("res://gambling.tscn")

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	await get_tree().change_scene_to_file("res://gambling.tscn")


func _on_exit_body_entered(body: Node2D) -> void:
<<<<<<< HEAD
	if body == player:
		await get_tree().change_scene_to_file("res://game.tscn")
=======
	await get_tree().change_scene_to_file("res://game.tscn")
>>>>>>> a8e63f4c4dada4d13fd92272928fa07512fce834
