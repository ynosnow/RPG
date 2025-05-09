extends Button

var Talk_Stage : int = 0

func _on_pressed() -> void:
	%Talk_Btn.visible = false
	%Panel.visible = true
	Talk_Stage = Talk_Stage + 1

	if Talk_Stage == 1:
		%DialogLabel.text = "Hey, you're the new guy right?"
	if Talk_Stage == 2:
		%DialogLabel.text = "Let me show you something."
	if Talk_Stage > 2:
		%Panel.visible = false
		Talk_Stage = 0
	if Talk_Stage == 0:
		var battle_music = $BattleMusic
		var player_node = get_node("/root/Game/Player")
		if player_node:
			Global.player_stats["max_hp"] = player_node.max_hp
			Global.player_stats["current_hp"] = player_node.current_hp
			Global.inventory_data = player_node.inventory_data
			SaveManager._save()

			MusicPlayer.play_music(battle_music.stream)
			

			var transition = get_node("/root/TransitionManager")
			transition.scene_path = "res://Battle.tscn"
			transition.play_transition()
		else:
			print("Player node not found!")
